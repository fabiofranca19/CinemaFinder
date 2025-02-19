import UIKit

protocol MovieListDisplaying: AnyObject {
    func showMovies(_ movies: [Movie])
    func showError()
}

final class MovieListViewController: UIViewController {
    private let interactor: MovieListInteracting
    private var movies: [Movie] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(interactor: MovieListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchMovies()
    }
}

extension MovieListViewController: ViewCode {
    func addSubviews() {
        view.addSubview(activityIndicator)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func additionalSetup() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MovieListViewController: MovieListDisplaying {
    func showMovies(_ movies: [Movie]) {
        activityIndicator.stopAnimating()
        self.movies = movies
        tableView.reloadData()
    }

    
    func showError() {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(
            title: "Erro",
            message: "Ocorreu um erro ao carregar os filmes",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.fetchMovies()
        }))
        present(alert, animated: true)
    }
}

private extension MovieListViewController {
    func fetchMovies() {
        activityIndicator.startAnimating()
        interactor.fetchMovies()
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieCell.identifier,
            for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(with: movie)
        return cell
    }
}

