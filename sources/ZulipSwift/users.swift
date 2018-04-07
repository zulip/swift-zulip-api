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

    /*:
        Gets all user profiles in the current realm.

         - Parameters:
            - clientGravatar: Whether Gravatars should not be send if the user
              does not have an avatar. (`true` means that `avatar_url` will be
              `nil` if the user does not have an avatar; `false` means that an
              `avatar_url` will be a Gravatar).
            - callback: A callback, which will be passed a list of users, or an
              error if there is one.
     */
    func getAll(
        clientGravatar: Bool = false,
        callback: @escaping ([[String: Any]]?, Error?) -> Void
    ) {
        let params = [
            "client_gravatar": clientGravatar ? "true" : "false",
        ]

        makeGetRequest(
            url: self.config.apiURL + "/users",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                guard
                    let members = getChildFromJSONResponse(
                        response: response,
                        childKey: "members"
                    ) as? [[String: Any]]
                else {
                    callback(
                        nil,
                        getZulipErrorFromResponse(response: response)
                    )
                    return
                }

                callback(members, nil)
            }
        )
    }
}
