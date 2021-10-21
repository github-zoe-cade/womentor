class MentorSearch
  class MultipleCriteria

    def initialize(query, query_field, criteria, score_name)
      @query = query
      @query_field = query_field
      @criteria = criteria
      @score_name = score_name
    end

    def score
      return @query unless @query_field.present? && @criteria.present? && @score_name.present?

      join_subquery
      select_fields
    end

    private

    # Sum of all criterion scores divided by how many values in the criteria
    def select_fields
      @query.select <<-SQL
        *,
        CASE WHEN subquery.matching_criteria_number != 0
        THEN
          ROUND(((#{sum_score}) * subquery.matching_criteria_number)::decimal
          / subquery.total_criteria_number)
        ELSE 0 END AS #{@score_name}
      SQL
    end

    def join_subquery
      @query = @query.joins <<-SQL
        INNER JOIN (SELECT
          profiles.user_id AS user_id,
          cardinality(#{@query_field}) as total_criteria_number,
          cardinality(
            ARRAY(
              SELECT unnest(ARRAY#{array_for_sql(@criteria)})
              INTERSECT SELECT unnest(#{@query_field}))
          ) AS matching_criteria_number,
          #{compute_score_per_criteria}
        FROM profiles
        LEFT JOIN mentorship_capacities ON mentorship_capacities.profile_id = profiles.id
        WHERE profiles.is_mentor IS TRUE
        ) subquery ON subquery.user_id = users.id
      SQL
    end

    def sum_score
      @criteria.map { |criterion| "#{criterion}_score" }.join(' + ')
    end

    def compute_score_per_criteria
      @criteria.map { |criterion| compute_score_for_one_criterion(criterion) }.join(', ')
    end

    # For each criterion compute its rarity score (the rarer the criterion, the higher the score)
    def compute_score_for_one_criterion(criterion)
      <<-SQL
        CASE WHEN '#{criterion}' = ANY(#{@query_field})
        THEN
          100 - ROUND(
            COUNT(*) FILTER (WHERE '#{criterion}' = ANY(#{@query_field})) OVER (PARTITION BY '1')::decimal
            / COUNT(*) OVER (PARTITION BY '1') * 100)::integer
        ELSE 0
        END as #{criterion}_score
      SQL
    end

    def array_for_sql(array)
      array.map(&:to_s).to_s.gsub('"', "'")
    end
  end
end
