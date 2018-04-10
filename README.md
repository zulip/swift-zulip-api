# `zulip-swift` <img alt="Swift logo" src="https://raw.githubusercontent.com/skunkmb/zulip-swift/master/assets/zulip-logo.png" height=50 /> <img alt="Swift logo" src="https://raw.githubusercontent.com/skunkmb/zulip-swift/master/assets/swift-logo.png" height=50 />

[![Travis CI build status](https://img.shields.io/travis/skunkmb/zulip-swift.svg)](https://travis-ci.org/skunkmb/zulip-swift)
[![GitHub tag](https://img.shields.io/github/tag/skunkmb/zulip-swift.svg)](https://github.com/skunkmb/zulip-swift)
[![language badge](https://img.shields.io/badge/language-Swift-orange.svg)](https://swift.org)

A library to access the Zulip API with **Swift**.

## Installation

### Swift Package Manager

`zulip-swift` can be installed with the
[Swift Package Manager](https://is.gd/aRdTkN).

In your `dependencies`, add
[`https://github.com/skunkmb/zulip-swift.git`](https://is.gd/by9epF):

```swift
dependencies: [
    .package(
        url: "https://github.com/skunkmb/zulip-swift.git",
        from: "0.1.1"
    )
]
```

### CocoaPods

`zulip-swift` can also be installed with [CocoaPods](https://is.gd/iMgFFg).

In your `Podfile`, add `zulip-swift`.

```ruby
pod 'zulip-swift'
```

Then run `pod install` from the terminal.

```bash
pod install
```

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

[See the full `messages` docs.](https://github.com/skunkmb/zulip-swift/blob/master/docs/messages.md)

**streams:**
```swift
let streams = zulip.streams()
```

[See the full `streams` docs.](https://github.com/skunkmb/zulip-swift/blob/master/docs/streams.md)

**users:**
```swift
let users = zulip.users()
```

[See the full `users` docs.](https://github.com/skunkmb/zulip-swift/blob/master/docs/users.md)

**events:**
```swift
let events = zulip.events()
```

[See the full `events` docs.](https://github.com/skunkmb/zulip-swift/blob/master/docs/events.md)
