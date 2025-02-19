import Foundation

protocol MovieListPresenting: AnyObject {
    func showMovies(_ movies: [Movie])
    func showError()
}

final class MovieListPresenter: MovieListPresenting {
    private let coordinator: MovieListCoordinating
    weak var viewController: MovieListDisplaying?
    
    init(coordinator: MovieListCoordinating) {
        self.coordinator = coordinator
    }
    
    func showMovies(_ movies: [Movie]) {
        viewController?.showMovies(movies)
    }
    
    func showError() {
        viewController?.showError()
    }
}
