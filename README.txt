Picus is a simple notification center.

It listens for notifications, and dispatches them to anyone currently subscribed.

Format for notifications is a json message:
{ "facility": "mail", "type": "family", "priority": "middle", "content": arbitrary_json_stuff }

Ideas for notification sources:
- mail
- syslog
