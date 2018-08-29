# user.rb

# User model to store signed users. 
class User < ActiveRecord::Base
  self.primary_key = 'id'
  devise :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :rides
  has_many :ride_matches

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(id: access_token.uid)

    unless user
      alternative_image_url = 'https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png'
      user = User.create(id: access_token.uid,
                         first_name: data['first_name'],
                         email: data['email'],
                         image_url: data['image'].length.zero? ? alternative_image_url : data['image'])
    end
    user
  end
end
