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
}
