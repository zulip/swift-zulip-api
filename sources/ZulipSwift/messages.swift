import Foundation
import Alamofire

//: A type of Zulip message.
public enum MessageType: String {
    //: A stream message.
    case streamMessage = "stream"

    //: A private message.
    case privateMessage = "private"
}

/*:
    A client for interacting with Zulip's messaging functionality.
 */
public class Messages {
    private var config: Config

    /*
        Initializes a Messaging client.

         - Parameters:
            - config: The `Config` to use.
     */
    init(config: Config) {
        self.config = config
    }

    /*
        Sends a message.

         - Parameters:
            - messageType: The type of message to send.
            - to: If `messageType` is `MessageType.stream`, then a string
              identifying a stream. If `messageType` is `MessageType.private`,
              then list of users' email addresses to send messages to.
               - Example: `StreamName`
               - Example: `user@example.com`
               - Example: `user1@example.com,user2@example.org`
            - subject: The subject of the message.
            - content: The content of the message, which will be formatted by
              Zulip's Markdown engine on the backend.
     */
    func send(
        messageType: MessageType,
        to: String,
        subject: String?,
        content: String,
        callback: @escaping (DataResponse<Any>) -> Void
    ) {
        var params = [
            "type": messageType.rawValue,
            "to": to,
            "content": content,
        ]

        if messageType == MessageType.streamMessage, let subject = subject {
            params["subject"] = subject
        }

        makePostRequest(
            url: self.config.apiURL + "/messages",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: callback
        )
    }

    /*
        Gets messages.

         - Parameters:
            - narrow: A JSON string of the Zulip narrow to search for messages
              in. `narrow` should be an array of arrays consisting of filters
              (represented by JSON).
               - Example: `[["is", "private"]]`
               - Example: `[["stream", "zulip-swift"]]`
               - Example: `[
                      ["stream", "zulip-swift"],
                      ["sender", "theskunkmb@gmail.com"]
                  ]`
            - anchor: The ID of a message to start with. `anchor` can also be
              an extremely large number in order to retrieve the newest message.
               - Example: 130
               - Example: 1000000000
            - amountBefore: The amount of messages before the `anchor` message
              to include.
            - amountAfter: The amount of messages after the `anchor` message
              to include.
            - callback: A callback, which will be passed an Alamofire
              `DataResponse`.
     */
    func get(
        narrow: String,
        anchor: Int,
        amountBefore: Int,
        amountAfter: Int,
        callback: @escaping (DataResponse<Any>) -> Void
    ) {
        let params = [
            "narrow": narrow,
            "anchor": String(anchor),
            "num_before": String(amountBefore),
            "num_after": String(amountAfter)
        ]

        makeGetRequest(
            url: self.config.apiURL + "/messages",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: callback
        )
    }
}
