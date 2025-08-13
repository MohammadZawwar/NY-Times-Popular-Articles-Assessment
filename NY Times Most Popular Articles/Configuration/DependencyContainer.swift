//
//  DependencyContainer.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import Foundation
import UIKit

/// Centralized dependency container following the Dependency Injection pattern
/// This ensures all dependencies are properly managed and testable
class DependencyContainer {
    
    // MARK: - Shared Instance
    static let shared = DependencyContainer()
    
    // MARK: - Services
    lazy var networkService: NetworkServiceProtocol = {
        return NetworkService()
    }()
    
    lazy var articlesRepository: ArticlesRepositoryProtocol = {
        return ArticlesRepository(networkService: networkService)
    }()
    
    // MARK: - ViewModels
    func makeArticlesViewModel() -> ArticlesViewModel {
        return ArticlesViewModel(articlesRepository: articlesRepository)
    }
    
    // MARK: - ViewControllers
    func makeViewController() -> ViewController {
        let viewController = ViewController()
        let viewModel = makeArticlesViewModel()
        viewController.configure(with: viewModel)
        return viewController
    }
    
    // MARK: - Navigation
    func makeNavigationCoordinator(for navigationController: UINavigationController) -> NavigationCoordinatorProtocol {
        return NavigationCoordinator(navigationController: navigationController)
    }
    
    private init() {}
}
