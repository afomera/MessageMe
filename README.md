# TMSG.IO

An app to play with Twilio's Messaging API.

Right now it has the ability to send an text message to a phone number inputted. But there is so much more left to do.

It was originally planned to be SaaS app, where it'd take payments for your useage of the app, but due to the terms of payment providers
that is not going to happen.

## Roadmap
* Setup Mailers to work properly
* Pretty up Devise Mailers. Add custom mailers of my our own, welcome email with Getting Started Video
* Getting Started Video / How to Use
* Support System / Email Contact form
* Privacy Policy / Terms of Use?
* Logging of messages
* Create account limits, allow user to subscribe for more messages per month.
 * Free/Basic/Pro plans
 * Pro comes with better logging / scheduled messages?
 * Address Book of people to message for folks on Basic / Pro?
* Would like to be able to handle the replies in some shape or fashion
* Admin Interface for viewing logs / account limits / subscribed users etc.
* The ability to send a shortened 'message' could be nice, give the user a way to click to read more sort of like twitlonger.

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

A rake task has been created to look for all ScheduledMessages with a

```
ScheduledMessage.where("scheduled_at <= ? AND status = ?", Time.zone.now, 'pending')
```

query. This ensures that when the rake task is ran, it will find all Scheduled Messages that should have been ran and the status of pending. Then it goes and looks up the Group, finds all the contacts and then obtains the contacts' phone_number for *each* of the scheduled messages.

Each contact needs a message sent for that ScheduledMessage.

After the messages are sent, the ScheduledMessage status should be updated to 'sent' or 'scheduled'.
