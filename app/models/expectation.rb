class Expectation < ActiveRecord::Base
  extend Enumerize

  include HasAvailability
  include HasExpertise
  include HasJobType
  include HasIndustry
  include HasMentoringSkills
  include HasTechnologies

  belongs_to :profile
end
