FactoryBot.define do
  factory :ride_match do
    ride_id { 1 }
    user_id { '1000000000' }
  end

  factory :invalid_ride_match, parent: :ride_match do
    ride_id { '' }
    user_id { '' }
  end
end
