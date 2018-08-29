FactoryBot.define do
  factory :user do
    uuid { '1000000000' }
    first_name { 'John' }
    email { 'john.doe@andela.com' }
    image_url { 'http://example.com/john_doe.png' }
  end

  factory :invalid_user, parent: :user do
    uuid { '' }
    first_name { '' }
    email { '' }
    image_url { '' }
  end

  factory :second_user, parent: :user do
    uuid { '10000203030' }
    first_name { 'Jane' }
    email { 'jane.doe@andela.com' }
    image_url { 'http://example.com/john_doe.png' }
  end

  factory :third_user, parent: :user do
    uuid { '10000203035' }
    first_name { 'Jack' }
    email { 'jack.doe@andela.com' }
    image_url { 'http://example.com/john_doe.png' }
  end
end
