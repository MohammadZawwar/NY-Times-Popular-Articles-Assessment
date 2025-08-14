//
//  NavigationCoordinator.swift
//  NY Times Most Popular Articles
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import UIKit

/// Protocol defining navigation actions
protocol NavigationCoordinatorProtocol {
    func showArticleDetail(_ article: Article, from viewController: UIViewController)
}

/// Navigation coordinator that handles all navigation logic
class NavigationCoordinator: NavigationCoordinatorProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigation Methods
    func showArticleDetail(_ article: Article, from viewController: UIViewController) {
        let detailView = ArticleDetailView(article: article)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
