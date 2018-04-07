# messages

```swift
let messages = zulip.messages()
```

## Functions

### messages.send

Sends a message.

#### Parameters

 - `messageType`: The type of message to send. It is either
   `MessageType.streamMessage` or `MessageType.privateMessage`.
 - `to`: A stream name (if it is a stream message), or a comma-separated list
   of email addresses (if it is a private message).
 - `subject` *(optional)*: The subject of the message, if it is a stream message.
 - `content`: The content of the message, which will be formatted by Zulip's
   Markdown engine on the backend.
 - `callback`: The content of the message, which will be passed the ID of the
   new message, or an error.

### messages.get

Gets messages.

#### Parameters

 - `narrow`: A Zulip narrow to search for messages in. It should be an array of
   arrays consisting of filters.
    - *example*: `[["is", "private"]]`
    - *example*: `[["stream", "zulip-swift"]]`
    - *example*:
      `[["stream", "zulip-swift"], ["sender", "theskunkmb@gmail.com"]]`
 - `anchor`: The ID of a message to start with. It can also be
   an extremely large number in order to retrieve the newest
   message.
 - `amountBefore`: The amount of messages before the `anchor` message
   to include.
 - `amountAfter`: The amount of messages after the `anchor` message
   to include.
 - `callback`: A callback, which will be passed the messages, or an
   error.

### messages.render

Renders a message to HTML using Zulip's Markdown.

#### Parameters

 - `content`: The content of the message.
 - `callback`: A callback, which will be passed the rendered HTML string, or an
   error.

### messages.update

Updates a message.

#### Parameters

 - content: The new content of the message.
 - callback: A callback, which will be passed an error if there is one.
