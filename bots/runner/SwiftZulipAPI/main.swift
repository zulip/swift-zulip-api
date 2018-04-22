#!/usr/bin/swift

import Foundation
import SwiftZulipAPI
import SwiftZulipAPIBots

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

let zulipConfig = Config(
    emailAddress: emailAddress,
    apiKey: apiKey,
    realmURL: realmURL
)

print("\nBot name (file name in `bots/`):")

guard let botName = readLine(), botName != "" else {
    print("\nError: No bot name entered.")
    exit(0)
}

print("\nBot configuration options as JSON (or `{}` for none):")

guard let botConfigString = readLine(), botConfigString != "" else {
    print("\nError: No bot config entered.")
    exit(0)
}

guard let botConfigData = botConfigString.data(
    using: String.Encoding.utf8
) else {
    print("\nError: Bot config data could not be parsed.")
    exit(0)
}

guard
    let botConfig = try? JSONSerialization.jsonObject(
        with: botConfigData,
        options: []
    ) as? [String: Any]
else {
    print("\nError: Bot config JSON could not be parsed.")
    exit(0)
}

var bot: Bot

switch botName {
case "echo-bot":
    bot = EchoBot(config: [:])
default:
    print("\nError: Incorrect bot.")
    exit(0)
}

let botHandler = BotHandler(bot: bot, zulipConfig: zulipConfig)
botHandler.startMentionedMessageHandling()

RunLoop.main.run()
