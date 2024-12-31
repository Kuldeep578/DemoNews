//
//  DemoNewsTests.swift
//  DemoNewsTests
//
//  Created by kuldeep Singh on 30/12/24.
//

import XCTest
@testable import DemoNews
import Combine


class NewsServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func testFetchArticles_Success() {
        // Mock Data
        let mockArticles = [
            Article(source: Source(id: "1", name: "BBC"),
                    author: "John Doe",
                    title: "Test Title",
                    description: "Test Description",
                    url: "https://example.com",
                    urlToImage: "https://example.com/image.jpg",
                    publishedAt: "2024-01-01T12:00:00Z",
                    content: "Test Content")
        ]

        let mockService = MockNewsService(shouldReturnError: false, mockArticles: mockArticles)
        let expectation = self.expectation(description: "Fetching articles")

        mockService.fetchArticles()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Should not fail")
                }
            }, receiveValue: { news in
                XCTAssertEqual(news.articles.count, 1)
                XCTAssertEqual(news.articles.first?.title, "Test Title")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testFetchArticles_Failure() {
        let mockService = MockNewsService(shouldReturnError: true)
        let expectation = self.expectation(description: "Fetching articles failure")

        mockService.fetchArticles()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive value")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
