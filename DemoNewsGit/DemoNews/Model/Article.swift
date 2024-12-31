//
//  Article.swift
//  DemoNews
//
//  Created by kuldeep Singh on 30/12/24.
//

import Foundation

import Foundation

// Top-level response model
struct News: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// Article model
struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// Source model
struct Source: Decodable {
    let id: String?
    let name: String
}


