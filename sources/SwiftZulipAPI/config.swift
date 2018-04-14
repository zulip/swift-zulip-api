/*:
    A Zulip configuration that must be created before using the Zulip API.
 */
public class Config {
    //: An email address that is signed up for Zulip.
    public var emailAddress: String

    //: An API key for a Zulip user.
    public var apiKey: String

    /*:
        The URL of a Zulip realm.

        - Example: https://chat.zulip.org/api/v1
     */
    public var apiURL: String

    /*:
        Initializes a Zulip configuration.

         - Parameters:
            - emailAddress: An email address that is signed up for Zulip.
            - apiKey: An API key for a Zulip user.
            - realmURL: The URL of a Zulip realm.
              - Example: https://chat.zulip.org
     */
    public init(
        emailAddress: String,
        apiKey: String,
        realmURL: String
    ) {
        self.emailAddress = emailAddress
        self.apiKey = apiKey
        self.apiURL = realmURL + "/api/v1"
    }
}
