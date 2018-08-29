# Google Auth User Mock
OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    :provider => 'google_oauth2',
    :uid => '123456789',
    :info => {
      :name => 'Tony Stark',
      :first_name => 'Tony',
      :email => 'tony@andela.com',
      :image => 'https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png'
    },
    :credentials => {
      :token => 'token',
      :refresh_token => 'refresh token'
    }
  }
)
