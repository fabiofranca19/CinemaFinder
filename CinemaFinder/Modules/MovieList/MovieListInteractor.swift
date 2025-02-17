import Foundation

protocol MovieListInteracting: AnyObject {
    func fetchMovies()
}

final class MovieListInteractor: MovieListInteracting {
    private let dependencyContainer: DependencyResolving
    private let presenter: MovieListPresenting
    private let service: MovieListServicing
    
    init(
        presenter: MovieListPresenting,
        service: MovieListServicing,
        dependencyContainer: DependencyResolving
    ) {
        self.presenter = presenter
        self.service = service
        self.dependencyContainer = dependencyContainer
    }
    
    func fetchMovies() {
        service.fetchMovies { [weak self] result in
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                    self?.presenter.showMovies(model)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.presenter.showError()
                }
            }
        }
    }
}
