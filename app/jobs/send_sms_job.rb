class SendSmsJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    # Send the SMS now, then update the message status
    SMS.new(message.to_phone_number).send message.body
    message.update_columns(status: "sent")

    # Increase the users sent counter here when we add it.
    # Then fire off the confirm job
  end

end
