FactoryGirl.define do

  factory :user do
    password_number =      Faker::Lorem.characters(8)
    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              password_number
    password_confirmation password_number
  end
end
