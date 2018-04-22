/*:
    A bot that responds with the same content that is sent to it, for
    demonstration purposes.

    No `config` is necessary.
 */
public class EchoBot: Bot {
    private var config: [String: Any]

    public required init(config: [String: Any]) {
        self.config = config
    }

    public func handleMessage(
        message: [String: Any],
        contentWithoutMention: String,
        callback: (String?, Error?) -> Void
    ) {
        callback(contentWithoutMention, nil)
    }
}
