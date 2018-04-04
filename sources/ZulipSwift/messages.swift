import Foundation
import Alamofire

//: A type of Zulip message.
public enum MessageType: String {
    //: A stream message.
    case streamMessage = "stream"

    //: A private message.
    case privateMessage = "private"
}

//: An error that occurs during messaging, before an HTTP request is made.
public enum MessageError: Error {
    //: An error that occurs when a Zulip `narrow` is invalid.
    case invalidNarrow
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
            - callback: A callback, which will be passed the ID of the new
              message, or an error.
     */
    func send(
        messageType: MessageType,
        to: String,
        subject: String?,
        content: String,
        callback: @escaping (Int?, Error?) -> Void
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
            callback: { (response) in
                guard
                    let id = getChildFromJSONResponse(
                        response: response,
                        childKey: "id"
                    ) as? Int
                else {
                    callback(
                        nil,
                        (response: response)
                    )
                    return
                }

                callback(id, nil)
            }
        )
    }

    /*
        Gets messages.

         - Parameters:
            - narrow: A Zulip narrow to search for messages in. `narrow`
              should be an array of arrays consisting of filters.
               - Example: `[["is", "private"]]`
               - Example: `[["stream", "zulip-swift"]]`
               - Example: `[
                      ["stream", "zulip-swift"],
                      ["sender", "theskunkmb@gmail.com"]
                  ]`
            - anchor: The ID of a message to start with. `anchor` can also be
              an extremely large number in order to retrieve the newest
              message.
               - Example: 130
               - Example: 1000000000
            - amountBefore: The amount of messages before the `anchor` message
              to include.
            - amountAfter: The amount of messages after the `anchor` message
              to include.
            - callback: A callback, which will be passed the messages, or an
              error.
     */
    func get(
        narrow: [Any],
        anchor: Int,
        amountBefore: Int,
        amountAfter: Int,
        callback: @escaping (
            Array<Dictionary<String, Any>>?,
            Error?
        ) -> Void
    ) {
        guard
            let narrowData = try? JSONSerialization.data(
                withJSONObject: narrow
            ),
            let narrowString = String(
                data: narrowData,
                encoding: String.Encoding.utf8
            )
        else {
            callback(nil, MessageError.invalidNarrow)
            return
        }

        let params = [
            "narrow": narrowString,
            "anchor": String(anchor),
            "num_before": String(amountBefore),
            "num_after": String(amountAfter)
        ]

        makeGetRequest(
            url: self.config.apiURL + "/messages",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                guard
                    let messages = getChildFromJSONResponse(
                        response: response,
                        childKey: "messages"
                    ) as? Array<Dictionary<String, Any>>
                else {
                    callback(
                        nil,
                        getZulipErrorFromResponse(response: response)
                    )
                    return
                }

                callback(messages, nil)
            }
        )
    }

    /*
        Renders a message.

         - Parameters:
            - content: The content of the message, which will be formatted by
              Zulip's Markdown engine on the backend.
            - callback: A callback, which will be passed the rendered HTML
              string, or an `Error`.
     */
    func render(
        content: String,
        callback: @escaping (String?, Error?) -> Void
    ) {
        let params = [
            "content": content,
        ]

        makePostRequest(
            url: self.config.apiURL + "/messages/render",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                guard
                    let rendered = getChildFromJSONResponse(
                        response: response,
                        childKey: "rendered"
                    ) as? String
                else {
                    callback(
                        nil,
                        (response: response)
                    )
                    return
                }

                callback(rendered, nil)
            }
        )
    }

    /*
        Updates a message.

         - Parameters:
            - content: The content of the message, which will be formatted by
              Zulip's Markdown engine on the backend.
            - callback: A callback, which will be passed an Error if
              there is one.
     */
    func update(
        messageID: Int,
        content: String,
        callback: @escaping (Error?) -> Void
    ) {
        let params = [
            "content": content,
        ]

        makePatchRequest(
            url: self.config.apiURL + "/messages/" + String(messageID),
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                guard
                    let errorMessage = getChildFromJSONResponse(
                        response: response,
                        childKey: "msg"
                    ) as? String
                else {
                    callback(nil)
                    return
                }

                callback(ZulipError.error(message: errorMessage))
            }
        )
    }
}
