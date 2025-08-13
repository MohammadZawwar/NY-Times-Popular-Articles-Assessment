//
//  ViewController.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar  on 12/08/2025.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ArticlesViewModel!
    
    // MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    // MARK: - Configuration
    func configure(with viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
        fetchArticles()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "NY Times Most Popular"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
        
        setupConstraints()
        setupRefreshControl()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupBindings() {
        // Set the delegate to receive updates from the ViewModel
        viewModel.delegate = self
    }
    
    // MARK: - Data Fetching
    private func fetchArticles() {
        viewModel.fetchArticles()
    }
    
    @objc private func refreshData() {
        viewModel.refreshArticles()
    }
    
    @objc private func retryTapped() {
        viewModel.clearError()
        fetchArticles()
    }
    
    // MARK: - Error Handling
    private func showErrorUI(with message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        retryButton.isHidden = false
        retryButton.removeTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }
    
    private func hideErrorUI() {
        errorLabel.isHidden = true
        retryButton.isHidden = true
        retryButton.removeTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }
}

// MARK: - ArticlesViewModelDelegate
extension ViewController: ArticlesViewModelDelegate {
    func articlesDidUpdate(_ articles: [Article]) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadingStateChanged(_ isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
            hideErrorUI()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func errorOccurred(_ error: String?) {
        if let error = error {
            showErrorUI(with: error)
            refreshControl.endRefreshing()
        } else {
            hideErrorUI()
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        if let article = viewModel.getArticle(at: indexPath.row) {
            cell.configure(with: article)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let article = viewModel.getArticle(at: indexPath.row) else { return }
        
        let detailViewController = ArticleDetailViewController(article: article)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

