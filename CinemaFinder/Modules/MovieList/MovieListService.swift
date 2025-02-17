import Foundation

protocol MovieListServicing {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class MovieListService: MovieListServicing {
    private let dependencyContainer: DependencyResolving
    
    init(dependencyContainer: DependencyResolving) {
        self.dependencyContainer = dependencyContainer
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], any Error>) -> Void) {
        guard let serviceApi = dependencyContainer.resolve(Servicing.self) else {
            completion(.failure(NSError()))
            return
        }
        
        let endpoint = MovieListEndpoint.popularMovies
        
        serviceApi.execute(endpoint) { (result: Result<MovieList, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
