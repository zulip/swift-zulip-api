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

    /*:
        Gets the current user's profile.

         - Parameters:
            - callback: A callback, which will be passed the profile, or an
              error if there is one.
     */
    func getCurrent(
        clientGravatar: Bool = false,
        callback: @escaping ([String: Any]?, Error?) -> Void
    ) {
        makeGetRequest(
            url: self.config.apiURL + "/users/me",
            params: [:],
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                if let errorMessage = getChildFromJSONResponse(
                    response: response,
                    childKey: "msg"
                ) as? String, errorMessage != "" {
                    callback(
                        nil,
                        ZulipError.error(message: errorMessage)
                    )
                    return
                }

                guard
                    var profile = getDictionaryFromJSONResponse(
                        response: response
                    )
                else {
                    callback(
                        nil,
                        getZulipErrorFromResponse(response: response)
                    )
                    return
                }

                // These keys are unrelated to the actual profile.
                profile.removeValue(forKey: "msg")
                profile.removeValue(forKey: "result")

                callback(profile, nil)
            }
        )
    }

    /*:
        Creates a new user. `create` will send a `ZulipError` if the user not
        an admin.

         - Parameters:
            - email: The new user's email address.
            - password: The new user's password.
            - fullName: The new user's full name.
            - shortName: The new user's short name.
            - callback: A callback, which will be passed an error if there is
              one.
     */
    func create(
        email: String,
        password: String,
        fullName: String,
        shortName: String,
        callback: @escaping (Error?) -> Void
    ) {
        let params = [
            "email": email,
            "password": password,
            "full_name": fullName,
            "short_name": shortName,
        ]

        makePostRequest(
            url: self.config.apiURL + "/users",
            params: params,
            username: config.emailAddress,
            password: config.apiKey,
            callback: { (response) in
                if let errorMessage = getChildFromJSONResponse(
                    response: response,
                    childKey: "msg"
                ) as? String, errorMessage != "" {
                    callback(
                        ZulipError.error(message: errorMessage)
                    )
                    return
                }

                callback(nil)
            }
        )
    }
}
