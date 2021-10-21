FactoryBot.define do
  # This is a private factory
  factory :_mentorship_capacity, class: MentorshipCapacity do
    mentee_capacity { 3 }
    availability { :monthly }
  end
end
