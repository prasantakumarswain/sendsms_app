class Message < ActiveRecord::Base
  belongs_to :users
  require 'twilio-ruby'

end
