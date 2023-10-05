//
//  NewsDetailsView.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 04.10.2023.
//

import SwiftUI

struct NewsDetails: View {
    let news: News
    @State private var zoomed: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                newsTitle
                newsImage
                newsInfo
            }
            .background(Color.yellow)
            .cornerRadius(30)
        }
    }
    
    private var newsTitle: some View {
        Text(news.title)
            .multilineTextAlignment(.center)
            .font(.title)
            .padding(.horizontal, 10)
            .padding(.top, 10)
    }
    
    private var newsImage: some View {
        AsyncImage(url: URL(string: news.urlToImage ?? "not found")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: self.zoomed ? .fill : .fit)
                    .onTapGesture {
                        withAnimation {
                            self.zoomed.toggle()
                        }
                    }
            case .failure:
                Text("Error loading image")
            case .empty:
                ProgressView()
            @unknown default:
                ProgressView()
            }
        }
        .cornerRadius(60)
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    private var newsInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description: \(news.description)")
            Text("Author: \(news.author ?? "")")
            Text("Source name: \(news.source.name)")
            Text("Source id: \(news.source.id ?? "")")
            Text("Published at: \(news.publishedAt ?? "")")
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 10)
    }
}
