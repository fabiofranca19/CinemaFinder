import Foundation

protocol MovieDetailInteracting: AnyObject {

}

final class MovieDetailInteractor: MovieDetailInteracting {
    private let dependencyContainer: DependencyResolving
    private let presenter: MovieDetailPresenting
    private let service: MovieDetailServicing
    
    init(
        presenter: MovieDetailPresenting,
        dependencyContainer: DependencyResolving,
        service: MovieDetailServicing
    ) {
        self.presenter = presenter
        self.dependencyContainer = dependencyContainer
        self.service = service
    }
}
