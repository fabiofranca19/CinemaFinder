import Foundation

enum MovieListEndpoint: ApiEndpoint {
    case popularMovies(page: Int = 1)
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String : String]? {
        switch self {
        case let .popularMovies(page):
            return [
                "page": "\(page)"
            ]
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .popularMovies:
            return nil
        }
    }
    
    var headers: [String : String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDUzYjQ3MWVlNGU2ZjkzNDAxMjBhODU5NTA0NGU5ZSIsIm5iZiI6MTczOTc3NzQ4MC4xNTYsInN1YiI6IjY3YjJlNWM4MTY5ZTM2NWFmNjlmYzM5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uOEmEvelUn7EjvmXvFlD4-JJbNygM-46teqgx376L7U"
        ]
    }
}
