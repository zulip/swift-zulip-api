import Foundation
import Alamofire

/*:
    Makes an HTTP POST request.

     - Parameters:
        - urlString: The URL to make the request to.
        - params: The dictionary of parameters for the POST request's body.
        - username: A username for authentication, if necessary.
        - password: A password for authentication, if necessary.
        - callback: The callback to pass the response to.
 */
internal func makePostRequest(
    url: String,
    params: [String: String],
    username: String?,
    password: String?,
    callback: @escaping (Dictionary<String, Any>?) -> Void
) {
    let request = Alamofire.request(
        url,
        method: HTTPMethod.post,
        parameters: params,
        encoding: URLEncoding.httpBody
    )

    let completionHandler = { (response: DataResponse<Any>) in
        guard
            let responseValue = response.result.value
                as? Dictionary<String, Any>
        else {
            callback(nil)
            return
        }

        callback(responseValue)
    }

    if let username = username, let password = password {
        request.authenticate(
            user: username,
            password: password
        ).responseJSON(completionHandler: completionHandler)
    } else {
        request.responseJSON(completionHandler: completionHandler)
    }
}
