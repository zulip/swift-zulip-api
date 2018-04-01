/*:
    A Zulip client. This is the primary way of interacting with Zulip through
    `zulip-swift`.
 */
public class Zulip {
    //: The Zulip `Config` that is used.
    public var config: Config

    /*
        Initializes a Zulip client.

         - Parameters:
            - config: The `Config` to use.
     */
    init(config: Config) {
        self.config = config
    }

    /*
        TODO: Add functions that return classes with their own functions for
              accessing Zulip.
     */
}
