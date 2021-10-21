FactoryBot.define do
  # This is a private factory, use User instead
  factory :_profile, class: Profile do
    name { 'Kashmir' }
    seniority { 3 }

    transient do
      mentorship_capacity { [] }
      expectation { [] }
    end

    trait :mentee do
      is_mentee { true }
    end

    trait :mentor do
      is_mentor { true }
    end

    after(:create) do |profile, evaluator|
      unless profile.mentorship_capacity.present?
        FactoryHelper.create_with_traits_and_attributes(
          :_mentorship_capacity, evaluator.mentorship_capacity || {}, {profile: profile})
      end

      unless profile.expectation.present?
        FactoryHelper.create_with_traits_and_attributes(
          :_expectation, evaluator.expectation || {}, {profile: profile})
      end
    end
  end
end
