#!/usr/bin/swift

import Foundation

print("Which function would you like to test?")
print("(possible options: `messages.send`, `messages.get`, `messages.render`, `messages.update`, `streams.getAll`, `streams.getID`, `streams.getSubscribed`, `streams.subscribe`, `streams.unsubscribe`, `users.getAll`, `users.getCurrent`, `users.create`, `events.register`, `events.get`, or `events.deleteQueue`)")

guard let command = readLine(), command != "" else {
    print("Error: No command entered.")
    exit(0)
}

switch command {
case "messages.send":
    // TODO: Do something.
    break
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
    print("Error: Incorrect command.")
    exit(0)
}
