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
Groups are composed of many contacts and contacts can have many groups. But a contact should be unique to each group, meaning one person cannot be added multiple times to the same group. But one contact can be a member of multiple different groups. 
