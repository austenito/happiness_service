FactoryGirl.define do
  factory :question do
    text Faker::Lorem.sentence(11)
  end
end
