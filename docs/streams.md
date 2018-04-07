# streams

```swift
let streams = zulip.streams()
```

## Functions

### streams.getAll

Gets all of the streams that a user can access.

#### Parameters

 - `includePublic` (optional, default `true`): Whether all public streams
   should be included.
 - `includeSubscribed` (optional, default `true`): Whether all subscribed-to
   streams should be included
 - `includeDefault` (optional, default `false`): Whether all default streams
   should be included.
 - `includeActive` (optional, default `false`): Whether all active streams
   should be included. This option will cause a `ZulipError` if the user not an
   admin.
 - `callback`: A callback, which will be passed the streams, or an
   error.

### streams.getID

Gets the ID of a stream.

#### Parameters

 - `name`: The name of the stream.
 - `callback`: A callback, which will be passed the ID, or an error.

### streams.getSubscribed

Gets the user's subscribed streams.

#### Parameters

- `callback`: A callback, which will be passed the streams, or an error.

### streams.subscribe

Subscribes a user to streams, or creates them if they do not exist yet.

#### Parameters

 - `streams`: The streams to subscribe a user to.
    - *example*: `[["name": "test here"]]`
    - *example*: `["name": "test here"], ["name": "announce"]]`
 - `inviteOnly` (optional, default `false`): Whether the streams are invite
   only or not.
 - `announce` (optional, default `false`): Whether an announcement should be
   made that a new stream is created, if it is.
 - `principals`: The users to subscribe to the streams. If
   `principals` is empty, the current user will be subscribed.
 - `authorizationErrorsFatal` (optional, default `false`): Whether
   authorization errors should be reported in the response.
 - `callback`: A callback, which will be passed

    - a dictionary where the key is user's email, and the value is a list of
      streams they were subscribed to;
    - a dictionary where the key is a user's email, and the value is a list of
      streams they were already subscribed to; and
    - a list of names of streams that could not be subscribed to because the
      user was unauthorized;

   or an error if there is one.

### streams.unsubscribe

Unsubscribes a user from streams.

#### Parameters

 - `streamNames`: The names of the streams to unsubscribe a user from.
    - *example*: `["test here"]`
    - *example*: `["test here", "announce"]`
 - `principals`: The users to unsubscribe from the streams. If
   `principals` is empty, the current user will be subscribed.
   Unsubscribing other users will cause a `ZulipError` if the
   current user is not an admin.
 - `callback`: A callback, which will be passed

    - a list of names of the streams that were unsubscribed from and
    - a list of names of the streams that could not be unsubscribed from
      because the user was already subscribed,

   or an error if there is one.
