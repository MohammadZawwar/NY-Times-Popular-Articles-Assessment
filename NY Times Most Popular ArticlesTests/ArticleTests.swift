//
//  ArticleTests.swift
//  NY Times Most Popular ArticlesTests
//
//  Created by Mohammad Zawwar on 12/08/2025.
//

import XCTest
@testable import NY_Times_Most_Popular_Articles

final class ArticleTests: XCTestCase {
    
    func testArticleCreation() {
        let article = Article(
            uri: "test-uri",
            url: "https://example.com",
            id: 123,
            assetId: 456,
            source: "Test Source",
            publishedDate: "2025-01-15",
            updated: "2025-01-15",
            section: "Test Section",
            subsection: "Test Subsection",
            nytdsection: "test",
            adxKeywords: "test",
            column: nil,
            byline: "By Test Author",
            type: "Article",
            title: "Test Title",
            abstract: "Test Abstract",
            desFacet: ["Test"],
            orgFacet: ["TestOrg"],
            perFacet: ["TestPerson"],
            geoFacet: ["TestLocation"],
            media: [],
            etaId: 0
        )
        
        XCTAssertEqual(article.title, "Test Title")
        XCTAssertEqual(article.abstract, "Test Abstract")
        XCTAssertEqual(article.byline, "By Test Author")
        XCTAssertEqual(article.id, 123)
    }
    
    func testArticleProperties() {
        let article = Article(
            uri: "test-uri",
            url: "https://example.com",
            id: 123,
            assetId: 456,
            source: "Test Source",
            publishedDate: "2025-01-15",
            updated: "2025-01-15",
            section: "Test Section",
            subsection: "Test Subsection",
            nytdsection: "test",
            adxKeywords: "test",
            column: nil,
            byline: "By Test Author",
            type: "Article",
            title: "Test Title",
            abstract: "Test Abstract",
            desFacet: ["Test"],
            orgFacet: ["TestOrg"],
            perFacet: ["TestPerson"],
            geoFacet: ["TestLocation"],
            media: [],
            etaId: 0
        )
        
        XCTAssertFalse(article.title.isEmpty)
        XCTAssertFalse(article.abstract.isEmpty)
        XCTAssertFalse(article.byline.isEmpty)
        XCTAssertFalse(article.url.isEmpty)
        XCTAssertGreaterThan(article.id, 0)
    }
}
