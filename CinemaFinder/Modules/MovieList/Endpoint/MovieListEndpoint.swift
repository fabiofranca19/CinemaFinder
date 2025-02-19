import Foundation

public enum MovieListEndpoint: ApiEndpoint {
    case popularMovies(language: String = "en-US", page: Int = 1)
    
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
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .popularMovies(let language, let page):
            return [
                "language": language,
                "page": page
            ]
        }
    }
    
    public var headers: [String : String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDUzYjQ3MWVlNGU2ZjkzNDAxMjBhODU5NTA0NGU5ZSIsIm5iZiI6MTczOTc3NzQ4MC4xNTYsInN1YiI6IjY3YjJlNWM4MTY5ZTM2NWFmNjlmYzM5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uOEmEvelUn7EjvmXvFlD4-JJbNygM-46teqgx376L7U"
        ]
    }
}
