class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(phone_number, message_body)
    # Send the SMS now, then update the message status
    SMS.new(phone_number).send message_body

    # Increase the users sent counter here when we add it.
    # Then fire off the confirm job
  end

end
