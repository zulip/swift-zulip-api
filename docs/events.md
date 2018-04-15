# events

```swift
let events = zulip.events()
```

## Functions

### events.register

Registers an event queue.

#### Parameters

 - `applyMarkdown`: Whether event content should be rendered as
   Markdown to HTML.
 - `clientGravatar`: Whether Gravatars should not be sent if a user
   does not have an avatar. (`true` means that `avatar_url` will be
   `nil` if the user does not have an avatar; `false` means that an
   `avatar_url` will be a Gravatar).
 - `eventTypes`: The types of events to receive, or an empty array
   for all events.
    - *example*: `["messages"]` for new messages
    - *example*: `["subscriptions"]` for changes in the current user's
      subscriptions
    - *example*: `["realm_user"]` for changes in the users in the
      current realm
    - *example*: `["pointer"]` for changes in the current user's
      pointer
    - *example*: `["subscriptions", "pointer"]` for a combination of
      multiple events
    - *example*: `[]` for all events
 - `allPublicStreams`: Whether events should be received from all
   public streams.
 - `includeSubscribers`: Whether events should be received for the
   subscribers of each stream.
 - `fetchEventTypes`: The same as `eventTypes`, but used to fetch
   initial data. If `fetchEventTypes` is not set, `eventTypes` is
   used, and if neither are set, then no events are used.
 - `narrow`: A Zulip narrow to search for messages in. `narrow`
   should be an array of arrays consisting of filters.
    - *example*: `[["stream", "test here"]]`
    - *example*:
      `[["stream", "zulip-swift"], ["sender", "theskunkmb@gmail.com"]]`
 - `callback`: A callback, which will be passed a dictionary
   containing `queue_id`, the ID of the new queue and
   `last_event_id`, the initial event ID to receive an event with,
   or an error if there is one.

### events.get

Gets events from a queue.

#### Parameters

 - `queueID`: The ID of the queue to get events from.
 - `lastEventID`: The last event ID to acknowledge. Events after the
   event with the `lastEventID` ID will be sent. `-1` can be used to
   receive all events.
 - `dontBlock`: Whether the response should be nonblocking. If
   `false`, the response will be sent after a new event is available
   or after a few minutes as a heartbeat.
 - `callback`: A callback, which will be passed a list of events, or
   an error, if there is one.

### events.deleteQueue

Deletes a queue.

#### Parameters

 - `queueID`: The ID of the queue to delete.
 - `callback`: A callback, which will be passed an error if there is
   one.

## Examples

### events.register

```swift
events.register(
    applyMarkdown: false,
    clientGravatar: false,
    eventTypes: ["messages"],
    allPublicStreams: false,
    includeSubscribers: false,
    narrow: [["stream", "test here"]],
    callback: { (queue, error) in
        // Prints the queue dictionary, containing `queue_id` and
        // `last_event_id`.
        print(queue)
    }
)
```

### events.get

```swift
events.get(
    queueID: "1300:400",
    lastEventID: 8,
    dontBlock: true,
    callback: { (events, error) in
        // Prints the events array.
        print(events)
    }
)
```

### events.deleteQueue

```swift
events.deleteQueue(
    queueID: "1301:200",
    callback: { (error) in
        // The queue has now been deleted.
    }
)
```
