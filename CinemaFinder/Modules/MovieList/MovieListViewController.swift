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
        interactor.fetchMovies()
    }
}

extension MovieListViewController: ViewCode {
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
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
        self.movies = movies
        tableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(
            title: "Erro",
            message: "Ocorreu um erro ao carregar os filmes",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.interactor.fetchMovies()
        }))
        present(alert, animated: true)
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

