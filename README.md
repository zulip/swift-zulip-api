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
