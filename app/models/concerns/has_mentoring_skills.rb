module HasMentoringSkills
  extend ActiveSupport::Concern

  included do
    enumerize :mentoring_skills,
      in: %i(
        tech_skills soft_skills career_evolution life_balance retraining
        lgbtq_friendly open_source
      ),
      multiple: true
  end
end
