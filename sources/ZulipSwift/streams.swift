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

    /*
        Gets all streams that a user can access.

         - Parameters:
            - includePublic: Whether all public streams should be included.
            - includeSubscribed: Whether all subscribed-to streams should be
              included
            - includeDefault: Whether all default streams should be included.
            - includeActive: Whether all active streams should be included.
              This option will cause a `ZulipError` if the user not an admin.
            - callback: A callback, which will be passed the streams, or an
              error.
     */
    func getAll(
        includePublic: Bool = true,
        includeSubscribed: Bool = true,
        includeDefault: Bool = false,
        includeActive: Bool = false,
        callback: @escaping (
            Array<Dictionary<String, Any>>?,
            Error?
        ) -> Void
    ) {
        let params = [
            "include_public": includePublic,
            "include_subscribed": includeSubscribed,
            "include_default": includeDefault,
            "include_active": includeActive,
        ]

        makeGetRequest(
            url: self.config.apiURL + "/streams",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                guard
                    let streams = getChildFromJSONResponse(
                        response: response,
                        childKey: "streams"
                    ) as? Array<Dictionary<String, Any>>
                else {
                    callback(
                        nil,
                        getZulipErrorFromResponse(response: response)
                    )
                    return
                }

                callback(streams, nil)
            }
        )
    }
}
