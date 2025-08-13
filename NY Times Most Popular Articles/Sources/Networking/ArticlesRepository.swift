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
        let response = try await networkService.fetchArticles(section: section, period: period)
        return response.results
    }
}
