FactoryBot.define do
  factory :user do
    sequence(:email) { |x| "kashmir#{x}@gmail.com" }
    password { 'meowmeow' }

    transient do
      profile { [] }
      with_profile { [] }
    end

    factory :mentor do
      with_profile { [:mentor] }
    end

    factory :mentee do
      with_profile { [:mente] }
    end

    # Transient behaviour
    before(:create) do |user, evaluator|
      next unless evaluator.profile.present? || evaluator.with_profile.present?
      user.singleton_class.skip_callback(:create, :after, :create_user_records, raise: false)
    end

    after(:create) do |user, evaluator|
      next unless evaluator.profile.present?  || evaluator.with_profile.present?

      traits_and_attributes = [evaluator.with_profile, evaluator.profile]

      FactoryHelper.create_with_traits_and_attributes(
        :_profile, traits_and_attributes, {user: user})
      user.singleton_class.set_callback(:create, :after, :create_user_records)
    end
  end
end
