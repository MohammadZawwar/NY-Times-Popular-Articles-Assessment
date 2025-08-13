//
//  NetworkService.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case networkError(Error)
    case invalidAPIKey
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let message):
            return "Server error: \(message)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidAPIKey:
            return "Invalid API key"
        }
    }
}

// MARK: - Network Service Protocol
/// Protocol defining the contract for network operations
/// This follows the Interface Segregation Principle by keeping it focused
protocol NetworkServiceProtocol {
    func fetchArticles(section: String, period: Int) async throws -> ArticleResponse
}

// MARK: - Network Service Implementation
class NetworkService: NetworkServiceProtocol {
    
    func fetchArticles(section: String, period: Int) async throws -> ArticleResponse {
        guard !APIConfig.apiKey.isEmpty else {
            throw NetworkError.invalidAPIKey
        }
        
        guard let url = URL(string: APIConfig.articlesURL(section: section, period: period)) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError("Invalid response")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkError.serverError("HTTP \(httpResponse.statusCode)")
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            do {
                let articleResponse = try JSONDecoder().decode(ArticleResponse.self, from: data)
                return articleResponse
            } catch {
                throw NetworkError.decodingError
            }
        } catch {
            if error is NetworkError {
                throw error
            } else {
                throw NetworkError.networkError(error)
            }
        }
    }
}
