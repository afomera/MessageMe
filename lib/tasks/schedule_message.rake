task :schedule_message => :environment do
  @scheduled_messages = ScheduledMessage.where("scheduled_at <= ? AND status = ?", Time.zone.now, 'pending')
  @scheduled_messages.each do |scheduled|
    @group = Group.find(scheduled.group)
    @group.contacts.each do |contacts|
      # Here is where we create a message to be sent out for each contact in the Group
      # receiving the scheduled message
      SMS.new(contacts.phone_number, scheduled.user_id).send scheduled.body
      #Message.create(
      #  user: scheduled.user,
      #  body: scheduled.body,
      #  to_phone_number: contacts.phone_number,
      #  ip_address: scheduled.user.current_sign_in_ip,
      #  status: 'pending'
      #)

    end

    scheduled.update(status: "sent")

    # Once the scheduled message is sent, update the status to sent
    # Maybe even email the user a confirmation message?
    # Should tell them messages were sent X number of times (i.e group.contacts.count)
  end
end
