class MessagesController < ApplicationController
  before_filter :authenticate_user!
  require 'twilio-ruby'

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save!
      client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      client.account.sms.messages.create(
          from: TWILIO_CONFIG['from'],
          to: @message.phone,
          body: @message.sms
      )
      redirect_to root_path
      flash[:notice] = "Thank you! You will receive an SMS shortly with verification instructions."
    else
      render :new
      flash[:alert] = "message not send cuccessfully"
    end
  end

  private
  def message_params
    params.require(:message).permit(:phone, :sms, :user_id)
  end
end
