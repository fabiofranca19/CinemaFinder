import Foundation

public protocol ApiEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
