#!/usr/bin/swift

import Foundation
import SwiftZulipAPI

print("Which function would you like to test?")
print("(possible options: `messages.send`, `messages.get`, `messages.render`, `messages.update`, `streams.getAll`, `streams.getID`, `streams.getSubscribed`, `streams.subscribe`, `streams.unsubscribe`, `users.getAll`, `users.getCurrent`, `users.create`, `events.register`, `events.get`, or `events.deleteQueue`)")

guard let command = readLine(), command != "" else {
    print("Error: No command entered.")
    exit(0)
}

print("\nEmail address:")

guard let emailAddress = readLine(), emailAddress != "" else {
    print("\nError: No email address entered.")
    exit(0)
}

print("\nAPI key:")

guard let apiKey = readLine(), apiKey != "" else {
    print("\nError: No API key entered.")
    exit(0)
}

print("\nRealm URL:")

guard let realmURL = readLine(), realmURL != "" else {
    print("\nError: No realm URL entered.")
    exit(0)
}

let config = Config(
    emailAddress: emailAddress,
    apiKey: apiKey,
    realmURL: realmURL
)

let zulip = Zulip(config: config)

func getParam(name: String) -> String? {
    print("\n" + name + ":")

    guard let param = readLine(), param != "" else {
        print("Error: No " + name + " entered.")
        exit(0)
    }

    return param
}

func handleError(error: Error?) {
    guard let error = error else {
        return
    }

    printErrorString(string: String(describing: error))
}

func printErrorString(string: String) {
    print("\nError: " + string + ".")
    exit(0)
}

func printSuccess(name: String, value: Any?) {
    print("\n" + name + ": " + String(describing: value))
    exit(0)
}

switch command {
case "messages.send":
    guard
        let messageTypeString = getParam(name: "message type"),
        let to = getParam(name: "to"),
        let subject = getParam(name: "subject"),
        let content = getParam(name: "content")
    else {
        break
    }

    let messageType = (
        messageTypeString == "MessageType.streamMessage"
            ? MessageType.streamMessage
            : MessageType.privateMessage
    )

    zulip.messages().send(
        messageType: messageType,
        to: to,
        subject: subject,
        content: content,
        callback: { (id, error) in
            handleError(error: error)
            printSuccess(name: "id", value: id)
        }
    )
case "messages.get":
    // TODO: Do something.
    break
case "messages.render":
    // TODO: Do something.
    break
case "messages.update":
    // TODO: Do something.
    break
case "streams.getAll":
    // TODO: Do something.
    break
case "streams.getID":
    // TODO: Do something.
    break
case "streams.getSubscribed":
    // TODO: Do something.
    break
case "streams.subscribe":
    // TODO: Do something.
    break
case "streams.unsubscribe":
    // TODO: Do something.
    break
case "users.getAll":
    // TODO: Do something.
    break
case "users.getCurrent":
    // TODO: Do something.
    break
case "users.create":
    // TODO: Do something.
    break
case "events.register":
    // TODO: Do something.
    break
case "events.get":
    // TODO: Do something.
    break
case "events.deleteQueue":
    // TODO: Do something.
    break
default:
    print("\nError: Incorrect command.")
    exit(0)
}

RunLoop.main.run()
