//
//  ArticlesViewModelTests.swift
//  NY Times Most Popular ArticlesTests
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import XCTest
@testable import NY_Times_Most_Popular_Articles

final class ArticlesViewModelTests: XCTestCase {
    
    var viewModel: ArticlesViewModel!
    
    override func setUp() {
        super.setUp()
        let networkService = NetworkService()
        viewModel = ArticlesViewModel(networkService: networkService)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.articles.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.numberOfArticles, 0)
    }
    
    func testNumberOfArticles() {
        XCTAssertEqual(viewModel.numberOfArticles, 0)
    }
    
    func testGetArticleAtIndex() {
        XCTAssertNil(viewModel.getArticle(at: 0))
        XCTAssertNil(viewModel.getArticle(at: -1))
        XCTAssertNil(viewModel.getArticle(at: 100))
    }
    
    func testClearError() {
        viewModel.clearError()
        XCTAssertNil(viewModel.errorMessage)
    }
}
