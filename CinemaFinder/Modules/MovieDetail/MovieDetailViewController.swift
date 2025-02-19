import UIKit

protocol MovieDetailDisplaying: AnyObject {
    
}

final class MovieDetailViewController: UIViewController {
    private let interactor: MovieDetailInteracting
    
    init(interactor: MovieDetailInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension MovieDetailViewController: ViewCode {
    func addSubviews() {
    }
    
    func setupConstraints() {
    }
}

extension MovieDetailViewController: MovieDetailDisplaying {
    
}
