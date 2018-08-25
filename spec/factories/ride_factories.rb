FactoryBot.define do
  factory :ride do
    id 1
    from_location 'Kampala'
    destination 'Jinja'
    seats 2
    user_id '1000000000'
    ride_type 'Request'
    time Time.now + (60 * 60 * 1)
  end

  factory :ride_update, parent: :ride do
    from_location 'Mukono'
    destination 'Kayunga'
    seats 2
    user_id '1000000000'
    ride_type 'Offer'
    time Time.now + (60 * 60 * 1)
  end

  factory :invalid_ride, parent: :ride do
    from_location ''
    destination ''
    seats ''
    time (Time.now - (60 * 60 * 1))
  end
end
