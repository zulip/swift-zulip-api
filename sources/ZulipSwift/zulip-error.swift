import Alamofire

//: An error that occurs during a Zulip HTTP request.
public enum ZulipError: Error {
    //: An unexpected error that occurs without a message.
    case unknownError

    //: An error that is sent by Zulip, with an accompanying message.
    case error(message: String)
}

/*
    Makes a `ZulipError` based on an Alamofire `DataResponse`.

     - Parameters:
        - response: An Alamofire `DataResponse` from a Zulip REST API request.
     - Returns: The `ZulipError`.
 */
internal func getZulipErrorFromResponse(
    response: DataResponse<Any>
) -> ZulipError {
    guard
        let errorMessage = getChildFromJSONResponse(
            response: response,
            childKey: "msg"
        ) as? String
    else {
        return ZulipError.unknownError
    }

    return ZulipError.error(message: errorMessage)
}
