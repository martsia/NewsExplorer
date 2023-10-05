//
//  NewsCell.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 04.10.2023.
//

import SwiftUI

struct NewsCell: View {
    let news: News
    let searchText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            highlightedText(text: news.title)
                .font(.headline)
                .padding(.leading)
            highlightedText(text: news.description)
                .font(.subheadline)
                .padding(.leading)
        }
        .padding(2)
    }
    
    private func highlightedText(text: String) -> some View {
        if searchText.isEmpty {
            return Text(text)
        }
        
        let components = text.components(separatedBy: searchText)
        
        return components.enumerated().map { index, component in
            if index < components.count - 1 {
                return Text(component) + Text(searchText).foregroundColor(.red)
            } else {
                return Text(component)
            }
        }.reduce(Text(""), +)
    }
}

