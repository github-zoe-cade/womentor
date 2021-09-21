class MentorshipCapacity < ActiveRecord::Base
  extend Enumerize

  # include HasMentorshipSkills
  include HasAvailability

  belongs_to :profile
end