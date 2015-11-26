class SMS
  def initialize(to_phone_number)
    @to_phone_number = to_phone_number
  end

  def client
    Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_token
  end

  def send(body)
    client.account.messages.create(
      :from => Rails.application.secrets.twilio_phone_number,
      :to => @to_phone_number,
      :body => body
    )
  end
end
