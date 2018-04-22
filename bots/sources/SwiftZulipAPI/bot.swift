/*:
    A bot.
 */
public protocol Bot {
    /*
        Initializes a bot.

         - Parameters:
            - config: A dictionary of config settings, which can be used for
              different things by different bots.
     */
    init(config: [String: Any])

    /*
        Handles and makes a response to a message.

         - Parameters:
            - message: The message to respond to.
            - contentWithoutMention: The content of `message`, but with the
              bot's mention removed as well as a space between the mention and
              the main content (if there is one).
               - Example: `example` if the full content is
                 `@**Some Bot** example`.
            - callback: A callback, which will be passed the content of the
              response, or an error if there is one.
.     */
    func handleMessage(
        message: [String: Any],
        contentWithoutMention: String,
        callback: (String?, Error?) -> Void
    )
}
