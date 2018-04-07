# `zulip-swift` <img alt="Swift logo" src="assets/zulip-logo.png" height=50 /> <img alt="Swift logo" src="assets/swift-logo.png" height=50 />

A library to access the Zulip API with **Swift**.

## Installation

TODO: Fill in this section once `zulip-swift` is published.

## Usage

### Set-up

```swift
// Set up a Zulip configuration.
let config = Config(
    emailAddress: "email@example.com",
    apiKey: "yourapikey",
    realmURL: "https://example.com"
)

// Create the Zulip client.
let zulip = Zulip(config: config)
```

### Functions

`zulip-swift` is split into a few different namespaces, each with their own
functions:

**messages:**
```swift
let messages = zulip.messages()
```

[See the full `messages` docs.](docs/messages)

**streams:**
```swift
let streams = zulip.streams()
```

[See the full `streams` docs.](docs/streams)

**users:**
```swift
let users = zulip.users()
```

[See the full `users` docs.](docs/users)

**events:**
```swift
let events = zulip.events()
```

[See the full `events` docs.](docs/events)
