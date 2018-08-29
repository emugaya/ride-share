FactoryBot.define do
  factory :user do
    id { '1000000000' }
    first_name { 'John' }
    email { 'john.doe@andela.com' }
    image_url { 'http://example.com/john_doe.png' }
  end

  factory :invalid_user, parent: :user do
    id { '' }
    first_name { '' }
    email { '' }
    image_url { '' }
  end

  factory :second_user, parent: :user do
    id { '10000203030' }
    first_name { 'Jane' }
    email { 'jane.doe@andela.com' }
    image_url { 'http://example.com/john_doe.png' }
  end
end
