class MentorshipCapacity < ActiveRecord::Base
  extend Enumerize

  include HasAvailability
  include HasMentoringSkills

  belongs_to :profile
end
