# user.rb

# User model to store signed users. 
class User < ActiveRecord::Base
  self.primary_key = 'id'
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(id: access_token.uid)
    unless user
      user = User.create(id: access_token.uid,
                          first_name: data['first_name'],
                          email: data['email'],
                          image_url: data['image'])
    end
    user
  end
end
