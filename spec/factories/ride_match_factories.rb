FactoryBot.define do
  factory :ride_match do
    ride_id { 1 }
    user_id { User.second.id }
  end
end
