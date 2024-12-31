//
//  NewsViewModel.swift
//  DemoNews
//
//  Created by kuldeep Singh on 30/12/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var errorMessage: String?
    
    private let newsService = NewsService()
    private var cancellables = Set<AnyCancellable>()
    
    func loadArticles() {
        newsService.fetchArticles()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { articles in
                self.articles = articles.articles
            })
            .store(in: &cancellables)
    }
}
