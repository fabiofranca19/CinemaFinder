import Foundation

public enum MovieListEndpoint: ApiEndpoint {
    case popularMovies
    
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .popularMovies:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .popularMovies:
            return ["api_key": "fd53b471ee4e6f9340120a8595044e9e"]
        }
    }
}
