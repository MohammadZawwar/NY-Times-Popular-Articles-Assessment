//
//  DateFormatterUtility.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

/// Utility class for shared date formatters to avoid creating multiple instances
struct DateFormatterUtility {
    
    // MARK: - Shared Date Formatters
    
    /// Formatter for parsing date strings from API (yyyy-MM-dd format)
    static let inputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    /// Formatter for displaying full date style
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    /// Formatter for displaying medium date style
    static let mediumDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    // MARK: - Utility Methods
    
    /// Format date string to full date display
    static func formatToFullDate(_ dateString: String) -> String? {
        guard let date = inputFormatter.date(from: dateString) else { return nil }
        return fullDateFormatter.string(from: date)
    }
    
    /// Format date string to medium date display
    static func formatToMediumDate(_ dateString: String) -> String? {
        guard let date = inputFormatter.date(from: dateString) else { return nil }
        return mediumDateFormatter.string(from: date)
    }
}
