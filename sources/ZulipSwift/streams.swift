import Foundation
import Alamofire

//: A client for interacting with Zulip's messaging functionality.
public class Streams {
    private var config: Config

    /*
        Initializes a `Streams` client.

         - Parameters:
            - config: The `Config` to use.
     */
    init(config: Config) {
        self.config = config
    }
}
