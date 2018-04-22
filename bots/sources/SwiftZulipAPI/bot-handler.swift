import Foundation
import SwiftZulipAPI

//: An error that occurs during bot handling.
public enum BotHandlerError: Error {
    /*:
        An error that occurs when the current user's full name cannot be
        determnied (for use in detecting mentions).
     */
    case invalidMention

    //: An error that occurs when a queue's ID cannot be determined.
    case invalidQueueID

    //: An error that occurs when an event's message cannot be determined.
    case invalidMessage

    //: An error that occurs when an event's ID cannot be determined.
    case invalidEventID

    //: An error that occurs when events are in an invalid format.
    case invalidEvents

    //: An error that occurs when a message content cannot be determined.
    case invalidMessageContent

    //: An error that occurs when a message type cannot be determined.
    case invalidMessageType

    //: An error that occurs when a message recipient cannot be determined.
    case invalidMessageTo

    //: An error that occurs when a message subject cannot be determined.
    case invalidMessageSubject
}

/*:
    Handles bots, including starting, stopping, and handling new messages.
 */
public class BotHandler {
    private var bot: Bot
    private var botFullName: String?
    private var zulip: Zulip

    /*:
        Initializes a bot handler.

         - Parameters:
            - bot: The `Bot` to handle.
     */
    public init(bot: Bot, zulipConfig: Config) {
        self.bot = bot
        self.zulip = Zulip(config: zulipConfig)
    }

    /*:
        Starts listening to and handling messages where the bot is mentioned.
     */
    public func startMentionedMessageHandling() {
        let users = self.zulip.users()
        let events = self.zulip.events()

        users.getCurrent(
            clientGravatar: false,
            callback: { (profile, error) in
                if let error = error {
                    self.handleError(error: error)
                    return
                }

                guard let botFullName = profile?["full_name"] as? String else {
                    self.handleError(error: BotHandlerError.invalidMention)
                    return
                }

                self.botFullName = botFullName

                events.register(
                    eventTypes: ["message"],
                    allPublicStreams: true,
                    narrow: [],
                    callback: { (queue, error) in
                        if let error = error {
                            self.handleError(error: error)
                            return
                        }

                        guard let queueID = queue?["queue_id"] as? String else {
                            self.handleError(
                                error: BotHandlerError.invalidQueueID
                            )
                            return
                        }

                        self.loopMentionedMessageHandling(
                            queueID: queueID,
                            lastEventID: -1
                        )
                    }
                )
            }
        )
    }


    /*:
        Listens to and handles messages on an event queue. Recursively loops
        until the process is stopped.

         - Parameters:
            - queueID: The queue ID to listen to messages on.
            - lastEventID: The ID of the last event to acknowledge.
     */
    private func loopMentionedMessageHandling(
        queueID: String,
        lastEventID: Int
    ) {
        self.zulip.events().get(
            queueID: queueID,
            lastEventID: lastEventID,
            dontBlock: true,
            callback: { (events, error) in
                if let error = error {
                    self.handleError(error: error)
                    return
                }

                guard let events = events else {
                    self.handleError(error: BotHandlerError.invalidEvents)
                    return
                }

                var newLastEventID = lastEventID

                for event in events {
                    if
                        let result = event["result"] as? String,
                        result == "error",
                        let errorMessage = event["msg"] as? String
                    {
                        self.handleError(
                            error: ZulipError.error(message: errorMessage)
                        )
                        continue
                    }

                    guard
                        let message = event["message"] as? [String: Any]
                    else {
                        // This means that it was likely a heartbeat event.
                        continue
                    }

                    guard
                        let messageContent = message["content"] as? String
                    else {
                        self.handleError(
                            error: BotHandlerError.invalidMessageContent
                        )
                        continue
                    }

                    guard let botFullName = self.botFullName else {
                        self.handleError(error: BotHandlerError.invalidMention)
                        continue
                    }

                    if (!messageContent.starts(
                        with: "@**" + botFullName + "**"
                    )) {
                        continue
                    }

                    guard let newEventID = event["id"] as? Int else {
                        self.handleError(
                            error: BotHandlerError.invalidEventID
                        )
                        continue
                    }

                    newLastEventID = max(lastEventID, newEventID)

                    self.handleMessage(message: message)
                }

                /*
                    Wait before the next call in order to not exceed the rate
                    limit.
                 */
                sleep(2)

                self.loopMentionedMessageHandling(
                    queueID: queueID,
                    lastEventID: newLastEventID
                )
            }
        )
    }

    /*:
        Handles a message using the bot's `handleMessage` method after some
        preparation.

         - Parameters:
            - message: The message to handle.
     */
    private func handleMessage(message: [String: Any]) {
        guard let botFullName = self.botFullName else {
            self.handleError(error: BotHandlerError.invalidMention)
            return
        }

        guard let content = message["content"] as? String else {
            self.handleError(error: BotHandlerError.invalidMessageContent)
            return
        }

        var contentWithoutMention = content

        // First check if there is a space after the mention.
        if content.hasPrefix("@**" + botFullName + "** ") {
            contentWithoutMention = String(
                content.dropFirst(botFullName.count + 6)
            )
        /*
            If not, check if there is a mention at all (there should be one no
            matter what, but it's better to be safe).
         */
        } else if content.hasPrefix("@**" + botFullName + "**") {
            contentWithoutMention = String(
                content.dropFirst(botFullName.count + 5)
            )
        }

        self.bot.handleMessage(
            message: message,
            contentWithoutMention: contentWithoutMention,
            callback: { (messageContent, error) in
                print(messageContent, error)

                if let error = error {
                    self.handleError(error: error)
                    return
                }

                guard let messageContent = messageContent else {
                    self.handleError(
                        error: BotHandlerError.invalidMessageContent
                    )
                    return
                }

                self.sendResponse(
                    content: messageContent,
                    originalMessage: message
                )
            }
        )
    }

    /*:
        Sends a response to a message.

         - Parameters:
            - content: The content of the response.
            - originalMessage: The message to respond to.
     */
    private func sendResponse(content: String, originalMessage: [String: Any]) {
        let messages = self.zulip.messages()

        guard let typeString = originalMessage["type"] as? String else {
            self.handleError(error: BotHandlerError.invalidMessageType)
            return
        }

        if typeString == "stream" {
            guard let subject = originalMessage["subject"] as? String else {
                self.handleError(error: BotHandlerError.invalidMessageSubject)
                return
            }

            guard
                let to = originalMessage["display_recipient"] as? String
            else {
                self.handleError(error: BotHandlerError.invalidMessageTo)
                return
            }

            messages.send(
                messageType: MessageType.streamMessage,
                to: to,
                subject: subject,
                content: content,
                callback: { (id, error) in
                    if let error = error {
                        self.handleError(error: error)
                    }
                }
            )
        } else {
            guard
                let to = originalMessage[
                    "display_recipient"
                ] as? [[String: Any]]
            else {
                self.handleError(error: BotHandlerError.invalidMessageTo)
                return
            }

            let toString = to.flatMap({ recipient in
                guard let email = recipient["email"] as? String else {
                    return nil
                }

                return email
            }).joined(separator: ",")

            messages.send(
                messageType: MessageType.privateMessage,
                to: toString,
                subject: nil,
                content: content,
                callback: { (id, error) in
                    if let error = error {
                        self.handleError(error: error)
                    }
                }
            )
        }
    }

    /*:
        Handles an error that occurs during bot handling.

         - Parameters:
            - error: The error to handle.
     */
    private func handleError(error: Error) {
        print("Error: " + String(describing: error))
    }
}
