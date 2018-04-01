import Foundation
import Alamofire

private func makeRequest(
    method: HTTPMethod,
    url: String,
    params: [String: String],
    username: String?,
    password: String?,
    callback: @escaping (DataResponse<Any>) -> Void
) {
    let request = Alamofire.request(
        url,
        method: method,
        parameters: params
    )

    let completionHandler = { (response: DataResponse<Any>) in
        callback(response)
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

/*:
    Makes an HTTP GET request.

     - Parameters:
        - urlString: The URL to make the request to.
        - params: The dictionary of parameters for the GET request's query.
        - username: A username for authentication, if necessary.
        - password: A password for authentication, if necessary.
        - callback: The callback to pass the response to.
 */
internal func makeGetRequest(
    url: String,
    params: [String: String],
    username: String?,
    password: String?,
    callback: @escaping (DataResponse<Any>) -> Void
) {
    makeRequest(
        method: HTTPMethod.get,
        url: url,
        params: params,
        username: username,
        password: password,
        callback: callback
    )
}

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
    callback: @escaping (DataResponse<Any>) -> Void
) {
    makeRequest(
        method: HTTPMethod.post,
        url: url,
        params: params,
        username: username,
        password: password,
        callback: callback
    )
}
