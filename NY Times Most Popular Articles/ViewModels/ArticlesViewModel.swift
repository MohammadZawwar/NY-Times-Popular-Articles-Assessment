//
//  ArticlesViewModel.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

// MARK: - Delegate Protocol
/// Protocol defining the contract for view model updates
/// This follows the Interface Segregation Principle
protocol ArticlesViewModelDelegate: AnyObject {
    func articlesDidUpdate(_ articles: [Article])
    func loadingStateChanged(_ isLoading: Bool)
    func errorOccurred(_ error: String?)
}

// MARK: - Articles View Model
/// ViewModel responsible for managing article data and business logic
/// This follows the Single Responsibility Principle by focusing on article management
class ArticlesViewModel {
    
    // MARK: - Properties
    weak var delegate: ArticlesViewModelDelegate?
    
    private(set) var articles: [Article] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private let articlesRepository: ArticlesRepositoryProtocol
    
    // MARK: - Initialization
    init(articlesRepository: ArticlesRepositoryProtocol) {
        self.articlesRepository = articlesRepository
    }
    
    // MARK: - Public Methods
    func fetchArticles(section: String = "all-sections", period: Int = 7) {
        guard !isLoading else { return } // Prevent multiple simultaneous requests
        
        isLoading = true
        errorMessage = nil
        delegate?.loadingStateChanged(true)
        
        Task {
            do {
                let articles = try await articlesRepository.fetchArticles(section: section, period: period)
                await MainActor.run {
                    self.articles = articles
                    self.isLoading = false
                    self.delegate?.articlesDidUpdate(self.articles)
                    self.delegate?.loadingStateChanged(false)
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    self.delegate?.errorOccurred(error.localizedDescription)
                }
            }
        }
    }
    
    func refreshArticles() {
        fetchArticles()
    }
    
    func getArticle(at index: Int) -> Article? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
    
    func clearError() {
        errorMessage = nil
        delegate?.errorOccurred(nil)
    }
    
    // MARK: - Computed Properties
    var numberOfArticles: Int {
        return articles.count
    }
    
    var hasArticles: Bool {
        return !articles.isEmpty
    }
}
