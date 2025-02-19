import Foundation

protocol MovieDetailServicing: AnyObject {
//    func fetchMovies(completion: @escaping (Result<Movie, Error>) -> Void)
}

final class MovieDetailService: MovieDetailServicing {
//    func fetchMovies(completion: @escaping (Result<Movie, any Error>) -> Void) {
//        
//    }
    
    private let dependencyContainer: DependencyResolving
    
    init(dependencyContainer: DependencyResolving) {
        self.dependencyContainer = dependencyContainer
    }
}
