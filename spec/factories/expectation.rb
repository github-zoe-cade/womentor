FactoryBot.define do
  # This is a private factory
  factory :_expectation, class: Expectation do
    availability { :monthly }
  end
end
