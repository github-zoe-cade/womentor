module MentorSearch::Query

  MIN_ADDITIONAL_SENIORITY = 2

  def build_query
    @query = @mentors
    exclude_requesting_user
    apply_mentee_capacity_constraint
    compute_availability_score
    apply_seniority_constraint
    compute_seniority_score

    compute_job_type_score
    compute_expertise_score
    compute_industry_score

    compute_technologies_score
    # compute_mentoring_skills_score

    # compute total score
    # filter lowest score to hide irrelevant profiles ?
    # order by score
    # select relevant fields
    @query
  end

  private

  def exclude_requesting_user
    return unless @user.present?

    @query = @query.where.not(id: @user.id)
  end

  def apply_mentee_capacity_constraint
    @query = @query.where.not(mentorship_capacities: { mentee_capacity: 0 })
  end

  # Criteria | Weekly score | Monthly score
  #   Weekly       100           0
  #   Monthly      50            100
  def compute_availability_score
    return unless @criteria[:availability].present?

    @query = @query.select <<-SQL
      *,
      CASE
        WHEN mentorship_capacities.availability = '#{@criteria[:availability]}' THEN 100
        WHEN mentorship_capacities.availability = 'monthly' AND '#{@criteria[:availability]}' = 'weekly' THEN 0
        ELSE 50
      END as availability_score
    SQL
  end

  def apply_seniority_constraint
    @query = @query.where('profiles.seniority >= ?', @user.profile.seniority + MIN_ADDITIONAL_SENIORITY)
  end

  def compute_seniority_score
    @query = @query.select <<-SQL
      *,
      GREATEST(100 - ABS(profiles.seniority - #{@user.profile.seniority} - 3)*10, 0) AS seniority_score
    SQL
  end

  def compute_job_type_score
    @query = MentorSearch::SingleCriteria.
      new(@query, 'profiles.job_type', @criteria[:job_type], 'job_type_score').
      score
  end

  def compute_expertise_score
    @query = MentorSearch::SingleCriteria.
      new(@query, 'profiles.expertise', @criteria[:expertise], 'expertise_score').
      score
  end

  def compute_industry_score
    @query = MentorSearch::SingleCriteria.
      new(@query, 'profiles.industry', @criteria[:industry], 'industry_score').
      score
  end

  def compute_technologies_score
    @query = MentorSearch::MultipleCriteria.
      new(@query, "profiles.technologies", @criteria[:technologies], "technologies_score").
      score
  end

  def compute_mentoring_skills_score
    @query = MentorSearch::MultipleCriteria.
      new(@query, "mentorship_capacities.mentoring_skills", @criteria[:mentoring_skills], "mentoring_skills_score").
      score
  end
end
