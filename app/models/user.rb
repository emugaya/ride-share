# user.rb

# User model to store signed users. 
class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  with_options dependent: :destroy do |assoc|
    assoc.has_many :rides
    assoc.has_many :ride_matches
  end

  has_many :subscribed_rides, through: :ride_matches, source: :ride

  with_options presence: true do
    validates :uuid
    validates :email
    validates :first_name
    validates :image_url
  end

  def self.from_omniauth(access_token)
    User.find_by(uuid: access_token.uid) || User.create_from_omniauth(access_token)
  end

  def self.create_from_omniauth(access_token)
    data = access_token.info
    User.create(uuid: access_token.uid,
                first_name: data['first_name'],
                email: data['email'],
                image_url:  data['image']
              )
  end
end
