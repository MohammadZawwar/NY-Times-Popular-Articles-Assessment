//
//  ArticlesRepository.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

protocol ArticlesRepositoryProtocol {
    func fetchArticles(section: String, period: Int) async throws -> [Article]
}

class ArticlesRepository: ArticlesRepositoryProtocol {
    
    // MARK: - Properties
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initialization
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    func fetchArticles(section: String, period: Int) async throws -> [Article] {
        guard !APIConfig.apiKey.isEmpty else {
            throw NetworkError.invalidAPIKey
        }
        
        guard let url = URL(string: APIConfig.articlesURL(section: section, period: period)) else {
            throw NetworkError.invalidURL
        }
        
        let response: ArticleResponse = try await networkService.get(url: url)
        
        return response.results
    }
}
