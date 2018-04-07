import Foundation
import Alamofire

/*:
    A client for interacting with Zulip's user functionality.
 */
public class Users {
    private var config: Config

    /*
        Initializes a Users client.

         - Parameters:
            - config: The `Config` to use.
     */
    init(config: Config) {
        self.config = config
    }
}
