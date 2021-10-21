class Profile < ActiveRecord::Base
  extend Enumerize

  include HasAvailability
  include HasExpertise
  include HasJobType
  include HasIndustry
  include HasTechnologies

  belongs_to :user
  has_one :expectation, dependent: :destroy
  has_one :mentorship_capacity, dependent: :destroy

  # TODO Move to profile completion service
  # validates :seniority, presence: true

  # only for seed
  accepts_nested_attributes_for :mentorship_capacity, :expectation

  # Consider making this a service
  def self.create_records(user)
    profile = new(user: user)
    profile.expectation = Expectation.new(profile: profile)
    profile.mentorship_capacity = MentorshipCapacity.new(profile: profile)

    ProfileRepository.save!(profile)
  end
end
