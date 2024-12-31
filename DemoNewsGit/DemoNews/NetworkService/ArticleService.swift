//
//  ArticleService.swift
//  DemoNews
//
//  Created by kuldeep Singh on 30/12/24.
//


import Foundation
import Combine


protocol NewsServiceProtocol {
    func fetchArticles() -> AnyPublisher<News, Error>
}

class NewsService : NewsServiceProtocol {
    private let apiKey = "9bdeefb6e2384b9d9995c8cf3513d792"
    private let baseUrl = "https://newsapi.org/v2/top-headlines"
    
    func fetchArticles() -> AnyPublisher<News, Error> {
        let url = URL(string: "\(baseUrl)?country=us&apiKey=\(apiKey)")!
        return URLSession.shared.dataTaskPublisher(for: url)

            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    

}
// Test case for API
class MockNewsService: NewsServiceProtocol {
    var shouldReturnError: Bool
    var mockArticles: [Article]

    init(shouldReturnError: Bool = false, mockArticles: [Article] = []) {
        self.shouldReturnError = shouldReturnError
        self.mockArticles = mockArticles
    }

    func fetchArticles() -> AnyPublisher<News, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.notConnectedToInternet)).eraseToAnyPublisher()
        } else {
            let mockNews = News(status: "ok", totalResults: mockArticles.count, articles: mockArticles)
            return Just(mockNews)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
