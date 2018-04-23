# `swift-zulip-api` <img alt="Swift logo" src="https://raw.githubusercontent.com/skunkmb/swift-zulip-api/master/assets/zulip-logo.png" height=50 /> <img alt="Swift logo" src="https://raw.githubusercontent.com/skunkmb/swift-zulip-api/master/assets/swift-logo.png" height=50 />

[![Travis CI build status](https://img.shields.io/travis/skunkmb/swift-zulip-api.svg)](https://travis-ci.org/skunkmb/swift-zulip-api)
[![GitHub tag](https://img.shields.io/github/tag/skunkmb/swift-zulip-api.svg)](https://github.com/skunkmb/swift-zulip-api)
[![language badge](https://img.shields.io/badge/language-Swift-orange.svg)](https://swift.org)

A library to access the Zulip API with **Swift**.

## Installation

### Swift Package Manager

`swift-zulip-api` can be installed with the
[Swift Package Manager](https://is.gd/aRdTkN).

In your `dependencies`, add
[`https://github.com/skunkmb/swift-zulip-api.git`](https://is.gd/by9epF):

```swift
dependencies: [
    .package(
        url: "https://github.com/skunkmb/swift-zulip-api.git",
        from: "0.2.1"
    )
]
```

### CocoaPods

`swift-zulip-api` can also be installed with [CocoaPods](https://is.gd/iMgFFg).

In your `Podfile`, add `swift-zulip-api`.

```ruby
pod 'swift-zulip-api'
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

`swift-zulip-api` is split into a few different namespaces, each with their own
functions:

**messages:**
```swift
let messages = zulip.messages()
```

[See the full `messages` docs.](https://github.com/skunkmb/swift-zulip-api/blob/master/docs/messages.md)

**streams:**
```swift
let streams = zulip.streams()
```

[See the full `streams` docs.](https://github.com/skunkmb/swift-zulip-api/blob/master/docs/streams.md)

**users:**
```swift
let users = zulip.users()
```

[See the full `users` docs.](https://github.com/skunkmb/swift-zulip-api/blob/master/docs/users.md)

**events:**
```swift
let events = zulip.events()
```

[See the full `events` docs.](https://github.com/skunkmb/swift-zulip-api/blob/master/docs/events.md)

### Examples

Each of the function docs has examples for how to use the functions. There is
also a [full Swift example file](https://github.com/skunkmb/swift-zulip-api/blob/master/example/SwiftZulipAPI/main.swift)
if you want to see every function being used in an actual example program.
The example can be run by using

```bash
swift run SwiftZulipAPIExample
```

from the terminal.

### Bots

`swift-zulip-api` supports writing Bots to automatically respond to users. Each
bot will respond when it is mentioned in a message.

[See the full bots docs.](https://github.com/skunkmb/swift-zulip-api/blob/master/docs/bots.md)
