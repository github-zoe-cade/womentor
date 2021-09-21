class Profile < ActiveRecord::Base
  extend Enumerize

  include HasAvailability
  include HasExpertise
  include HasJobType

  belongs_to :user
  has_one :expectation, dependent: :destroy
  has_one :mentorship_capacity, dependent: :destroy
end