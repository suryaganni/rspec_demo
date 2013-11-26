FactoryGirl.define do
  factory :post do
    sequence(:name) {|n| "test name #{n}" }
    subject Faker::Name.name
  end
end
