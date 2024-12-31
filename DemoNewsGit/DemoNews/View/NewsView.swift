//
//  ContentView.swift
//  DemoNews
//
//  Created by kuldeep Singh on 30/12/24.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles , id: \.publishedAt) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    ArticleRowView(article: article)
                }
            }
            .navigationTitle("Top Headlines")
            .onAppear {
                viewModel.loadArticles()
            }
        }
    }
}

#Preview {
    ArticleListView()
}


struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.gray)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.description ?? "No description available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}


