//
//  APIConfig.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

struct APIConfig {
    static let baseURL = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed"
    
    // Load API key from environment or use default for development
    static var apiKey: String {
        // In production, this should come from environment variables or secure storage
        #if DEBUG
        return "AV9UzMz8vcAXylRV5OOWtGzFpKlthyKq"
        #else
        // In production, load from environment variable
        return ProcessInfo.processInfo.environment["NYT_API_KEY"] ?? ""
        #endif
    }
    
    static let defaultPeriod = 7 //1, 7, 30 days
    static let defaultSection = "all-sections"
    
    // API endpoints
    static func articlesURL(section: String = defaultSection, period: Int = defaultPeriod) -> String {
        return "\(baseURL)/\(section)/\(period).json?api-key=\(apiKey)"
    }
}
