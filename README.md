# GraphQL-ActionCableSubscriptions

Example repository that shows how to setup GraphQL Subscriptions with ActionCable as there isn't too much documentation on the matter.

## Some things to keep in mind
- Cannot use async as the adapter, this example uses Redis
- As per standard ActionCable implementation a `subscribe` command has to be sent before any GraphQL or other commands can be sent
- Can't use Scalars (ie just plain String, Int, etc) as a return type

## Overview

A subscription type is defined in the Schema as long as telling GraphQL which subscriptions implementation is used

There's a new channel that has been created to serve as a bridge between ActionCable and GraphQL. Taken from https://graphql-ruby.org/api-doc/1.9.7/GraphQL/Subscriptions/ActionCableSubscriptions

After a Message object is saved, it'll inform subscribers that there's a new Message (after_save hook)

## How to test

**Might need to allow your origin**

**Notice the string representations of hashes**

So in this example to broadcast just create a message in the console with `Message.create(content: "Message")`


### To recieve messages, first send the subscribe command (using a WebSocket client)

```
{
   "command":"subscribe",
   "identifier":"{\"channel\":\"GraphqlChannel\"}"
}
```

### Then send the actual GraphQL subscription command
So the data item actually contains the GraphQL stuff, everything else is related to ActionCable.
Ensure the action item is included as that tells ActionCable which function to call in the channel (in our case execute)

```
{
   "command":"message",
   "identifier":"{\"channel\":\"GraphqlChannel\"}",
   "data":"{ \"query\": \"subscription { newMessage { content } }\", \"variables\": null, \"action\": \"execute\" }"
}
```

