//
//  NetworkService.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

// MARK: - HTTP Methods
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

// MARK: - Network Error
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case networkError(Error)
    case invalidAPIKey
    case invalidResponse
    case unauthorized
    case forbidden
    case notFound
    case rateLimited
    
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
        case .invalidResponse:
            return "Invalid response from server"
        case .unauthorized:
            return "Unauthorized access"
        case .forbidden:
            return "Access forbidden"
        case .notFound:
            return "Resource not found"
        case .rateLimited:
            return "Rate limit exceeded"
        }
    }
    
    static func from(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 429:
            return .rateLimited
        case 500...599:
            return .serverError("HTTP \(statusCode)")
        default:
            return .serverError("HTTP \(statusCode)")
        }
    }
}

// MARK: - Request Configuration
struct RequestConfiguration {
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?
    let timeoutInterval: TimeInterval
    
    init(
        method: HTTPMethod = .GET,
        headers: [String: String] = [:],
        body: Data? = nil,
        timeoutInterval: TimeInterval = 30.0
    ) {
        self.method = method
        self.headers = headers
        self.body = body
        self.timeoutInterval = timeoutInterval
    }
}

// MARK: - Generic Network Service Protocol
protocol NetworkServiceProtocol {
    // Simple GET request
    func get<T: Decodable>(url: URL) async throws -> T
    
    // POST request with body
    func post<T: Decodable>(url: URL, body: Data) async throws -> T
    
    // PUT request with body
    func put<T: Decodable>(url: URL, body: Data) async throws -> T
    
    // DELETE request
    func delete(url: URL) async throws
    
    // Generic request with custom configuration
    func request<T: Decodable>(
        url: URL,
        configuration: RequestConfiguration
    ) async throws -> T
    
    func request(
        url: URL,
        configuration: RequestConfiguration
    ) async throws -> Data
}

// MARK: - Generic Network Service Implementation
class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Initialization
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - Convenience Methods
    func get<T: Decodable>(url: URL) async throws -> T {
        let configuration = RequestConfiguration(
            method: .GET,
            headers: defaultHeaders
        )
        return try await request(url: url, configuration: configuration)
    }
    
    func post<T: Decodable>(url: URL, body: Data) async throws -> T {
        let configuration = RequestConfiguration(
            method: .POST,
            headers: defaultHeaders,
            body: body
        )
        return try await request(url: url, configuration: configuration)
    }
    
    func put<T: Decodable>(url: URL, body: Data) async throws -> T {
        let configuration = RequestConfiguration(
            method: .PUT,
            headers: defaultHeaders,
            body: body
        )
        return try await request(url: url, configuration: configuration)
    }
    
    func delete(url: URL) async throws {
        let configuration = RequestConfiguration(
            method: .DELETE,
            headers: defaultHeaders
        )
        _ = try await request(url: url, configuration: configuration)
    }
    
    // MARK: - Generic Request Method
    func request<T: Decodable>(
        url: URL,
        configuration: RequestConfiguration
    ) async throws -> T {
        let data = try await request(url: url, configuration: configuration)
        return try decoder.decode(T.self, from: data)
    }
    
    func request(
        url: URL,
        configuration: RequestConfiguration
    ) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = configuration.method.rawValue
        request.httpBody = configuration.body
        request.timeoutInterval = configuration.timeoutInterval
        
        // Add headers
        configuration.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            // Handle HTTP status codes
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                throw NetworkError.from(statusCode: httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            return data
        } catch {
            if error is NetworkError {
                throw error
            } else {
                throw NetworkError.networkError(error)
            }
        }
    }
    
    // MARK: - Private Properties
    private var defaultHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
