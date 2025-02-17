import Foundation

protocol MovieListCoordinating: AnyObject {
    func showMovieDetails(movie: Movie)
}

final class MovieListCoordinator: MovieListCoordinating {
    private let navigation: Navigating

    init(_ navigation: Navigating) {
        self.navigation = navigation
    }

    func showMovieDetails(movie: Movie) {
//        let detailsViewController = MovieDetailsFactory.make(movie: movie)
//        navigator.pushViewController(detailsViewController, animated: true)
    }
}
