import Foundation
import Alamofire

/*:
    A client for interacting with Zulip's event functionality.
 */
public class Events {
    private var config: Config

    /*
        Initializes an Events client.

         - Parameters:
            - config: The `Config` to use.
     */
    init(config: Config) {
        self.config = config
    }
}
