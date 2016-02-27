# TMSG.IO

An app to play with Twilio's Messaging API.

Right now it has the ability to send an text message to a phone number inputted. But there is so much more left to do.

It was originally planned to be SaaS app, where it'd take payments for your usage of the app, but due to the terms of payment providers that is not going to happen.

## Roadmap
* Polish the views, cleanup the UI
* Setup Mailers to work properly
* Prep for deployment, ensure RVM on production server is setup to handle whenever (special rvm stuff on readme)
* Devise inviteable to add Users to the site to start?
* Pretty up Devise Mailers. Add custom mailers of my our own, welcome email with Getting Started Video
* Getting Started Video / How to Use
* Create account limits, allow user to contact Team to raise limits.
* Admin Interface for viewing logs / account limits / subscribed users etc.

## Contributing
Feel free to submit pull requests <3. Instructions on how to get the project setup will come soon.

---

## Technical Notes
### Regarding Groups
Groups are composed of many contacts and contacts can have many groups. But a contact should be unique to each group, meaning one person cannot be added multiple times to the same group. But one contact can be a member of multiple different groups.

### Regarding messaging
Regular one-off texts are sent via the Message model, there is an after_commit hook that sends the Message to the SendSmsJob when a message is created.

You can send a one-off text to either a Contact or a Group. If you send it to a group, it will create multiple message entries with duplicate bodies.

The actual sending of the message is then delegated to the SMS class which connects and contacts Twilio to send the text message after being passed in a to_phone_number and a body argument given to the send method like so:


```
SMS.new(message.to_phone_number).send message.body
```

#### Scheduled Messages

Scheduled Messages are stored in a ScheduledMessage model that contains a group (id), a body of a message to send, and a scheduled_at time that the message needs to be sent on/slightly after.

A rake task has been created to look for all ScheduledMessages with a ActiveRecord query like so

```
ScheduledMessage.where("scheduled_at <= ? AND status = ?", Time.zone.now, 'pending')
```

This ensures that when the rake task is ran, it will find all Scheduled Messages that should have been ran and the status of pending. Then it goes and looks up the Group, finds all the contacts and then obtains the contacts' phone_number for *each* of the scheduled messages.

Each contact needs a message sent for that ScheduledMessage.

After the messages are sent, the ScheduledMessage status should be updated to 'sent' or 'scheduled'.

***The quick and dirty approach for sending the messages***

The quick approach would be inside the job where it loops through the contacts, just call the SMS class, and pass in the body of the scheduled message and the contacts phone_number. Then you could just mark the ScheduledMessage as 'sent' then.

Passing it to a job and scheduling the job to complete all the above at the scheduled_at time is another way we could handle it. However for now while we are ok with things being sent as often as the cron is ran, we can just send the messages directly to Twilio.

The best course of action may be to create a Message record for each contact per group for the ScheduledMessage and just let it send the SMS as it does for the one-off messages after_commit via the SendSmsJob. That is a massive amount of Message records and the downside is we have no easy way to attach a sender IP address to the Message model without looking up the user that scheduled the message.  
