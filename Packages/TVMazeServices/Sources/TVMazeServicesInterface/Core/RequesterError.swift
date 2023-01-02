import Foundation

public enum RequesterError: Error {
    case decodeError
    case invalidUrl
    case emptyData
    case requestError(status: HTTPStatus)
    case requestFailed(error: Swift.Error)
}
