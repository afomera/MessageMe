class SMS
  def initialize(to_phone_number, user_id)
    @to_phone_number = to_phone_number
    @user_id = user_id
  end

  def client
    Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_token
  end

  def send(body)
    client.account.messages.create(
      #:from => Rails.application.secrets.twilio_phone_number,
      :messaging_service_sid => Rails.application.secrets.twilio_messaging_service_sid,
      :to => @to_phone_number,
      :body => body
    )
    if @user_id.present?
       user = User.find(@user_id)
       user.increment(:quota)
       user.save
    end
  end
end
