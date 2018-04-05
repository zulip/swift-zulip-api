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

    func messages() -> Messages {
        return Messages(config: self.config)
    }

    /*
        Returns a `Streams` client with the current `Config`.

         - Returns: The `Streams` client.
     */
    func streams() -> Streams {
        return Streams(config: self.config)
    }
}
