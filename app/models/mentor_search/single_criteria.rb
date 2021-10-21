class MentorSearch
  class SingleCriteria

    # @param query_field [String] table_name.field_name to compare to the criteria
    # @param criteria [String] matching value for the query_field
    # @param score_name [String] name of the field in the SQL query
    def initialize(query, query_field, criteria, score_name)
      @query = query
      @query_field = query_field
      @criteria = criteria
      @score_name = score_name
    end

    # score = (1 - (number_of_matching_people / total_number_of_people)) * 100
    def score
      return @query unless @criteria.present? && @query_field.present? && @score_name.present?

      @query.select <<-SQL
        *,
        CASE WHEN #{@query_field} = '#{@criteria}'
        THEN
          100 - ROUND(
            COUNT(*) FILTER (WHERE #{@query_field} = '#{@criteria}') OVER (PARTITION BY #{@query_field})::decimal
            /  COUNT(*) OVER (PARTITION BY '1') * 100
          )::integer
        ELSE 0
        END AS #{@score_name}
      SQL
    end
  end
end
