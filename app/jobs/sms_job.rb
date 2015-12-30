class SmsJob
  include SuckerPunch::Job

  def perform(phone_number, message_body)

    SMS.new(phone_number).send message_body
    #raise message
  end
end
