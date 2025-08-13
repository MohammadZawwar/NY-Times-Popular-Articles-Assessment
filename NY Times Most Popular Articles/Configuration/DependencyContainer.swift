//
//  DependencyContainer.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation

/// Centralized dependency container following the Dependency Injection pattern
/// This ensures all dependencies are properly managed and testable
class DependencyContainer {
    
    // MARK: - Shared Instance
    static let shared = DependencyContainer()
    
    // MARK: - Services
    lazy var networkService: NetworkServiceProtocol = {
        return NetworkService()
    }()
    
    // MARK: - ViewModels
    func makeArticlesViewModel() -> ArticlesViewModel {
        return ArticlesViewModel(networkService: networkService)
    }
    
    // MARK: - ViewControllers
    func makeViewController() -> ViewController {
        let viewController = ViewController()
        let viewModel = makeArticlesViewModel()
        viewController.configure(with: viewModel)
        return viewController
    }
    
    private init() {}
}
