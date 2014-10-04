class User < ActiveRecord::Base
  has_many :messages
  has_many :authentications

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
                          :uid => omni['uid'],
                          :token => omni['credentials']['token'],
                          :token_secret => omni['credentials']['secret'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super #&& provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  CONSUMER_KEY = 'jHW3Mi348jGM3midchfdLaotD'
  CONSUMER_SECRET = 'c8zPREclRq1RFgEEaqpvPEWIa7BKUHxYWSz5E7F7IJwihUmQzn'
  OPTIONS = {site: "http://api.twitter.com", request_endpoint: "http://api.twitter.com"}
  devise :omniauthable

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(username: data.screen_name).first
      user
    else # Create a user with a stub password.
      User.create!(full_name: data.name, username: data.screen_name, provider: access_token.provider,
                   token: access_token.credentials.token, token_secret: access_token.credentials.secret,
                   password: Devise.friendly_token[0, 20])
    end
  end

  def post_tweets(message)
    Twitter.configure do |config|
      config.consumer_key = User::CONSUMER_KEY
      config.consumer_secret = User::CONSUMER_SECRET
      config.oauth_token = self.authentication_token
      config.oauth_token_secret = self.authentication_token_secret
    end
    client = Twitter::Client.new
    begin
      client.update(message)
      return true
    rescue Exception => e
      self.errors.add(:oauth_token, "Unable to send to twitter: #{e.to_s}")
      return false
    end
  end
end