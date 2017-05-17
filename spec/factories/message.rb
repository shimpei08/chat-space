FactoryGirl.define do

  factory :message do
    body      { Faker::Lorem.sentence }
    image     { Faker::Avatar.image }
    user_id   { Faker::Number.number }
    group_id  { Faker::Number.number }
  end

end
