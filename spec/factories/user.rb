FactoryBot.define do
  factory :user do
    email { 'kashmir@gmail.com' }
    password { 'meowmeow' }

    transient do
      profile {}
    end

    factory :mentee do 
      is_mentee { true }
    end

    factory :mentor do 
      is_mentor { true }
    end
  end
end