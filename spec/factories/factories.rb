FactoryGirl.define do
  factory :post do
    sequence(:name) {|n| "test name #{n}" }
    subject Faker::Name.name
  end
end

FactoryGirl.define do
  factory :task do
    name Faker::Name.name
    content Faker::Name.name
  end
end

FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    tasks [FactoryGirl.build(:task)]
  end
end

