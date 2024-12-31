//
//  DetailView.swift
//  DemoNews
//
//  Created by kuldeep Singh on 30/12/24.
//

import SwiftUI
import Combine


struct ArticleDetailView: View {
    let article: Article
    @State private var likes: Int = 0
    @State private var comments: Int = 0
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ScrollView { // Enable scrolling
            VStack(alignment: .leading, spacing: 16) {
                Text(article.title)
                    .font(.largeTitle)
                
                Text("By \(article.author ?? "Unknown Author")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.gray)
                }
                .frame(height: 200)
                .cornerRadius(8)
                
                Text(article.description ?? "")
                    .font(.subheadline)
                    .lineLimit(nil) // Allow unlimited lines
                    .fixedSize(horizontal: false, vertical: true) // Ensure proper expansion
            }
            .padding()
        }
        .onAppear {
            // fetchAdditionalInfo()
        }
    }
}

//struct ArticleDetailView: View {
//    let article: Article
//    @State private var likes: Int = 0
//    @State private var comments: Int = 0
//    
//    // Use a private variable for cancellables
//    @State private var cancellables = Set<AnyCancellable>()
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text(article.title)
//                .font(.largeTitle)
//            Text("By \(article.author ?? "Unknown Author")")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
//                image.resizable()
//            } placeholder: {
//                Image(systemName: "photo")
//                    .resizable()
//                    .foregroundColor(.gray)
//            }
//            .frame(height: 200)
//            .cornerRadius(8)
//            
//            Text(article.description ?? "")
//                .font(.subheadline)
//                .lineLimit(0)
//         }
//        .padding()
//        .onAppear {
//            /// fetchAdditionalInfo()
//        }
//    }
//}
