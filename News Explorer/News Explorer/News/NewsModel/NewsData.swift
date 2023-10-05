//
//  NewsData.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 03.10.2023.
//

import Foundation

struct NewsData: Hashable, Codable {
    let articles: [News]
}

struct News: Hashable, Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let urlToImage: String?
    let publishedAt: String?
    
    struct Source: Hashable, Codable {
        let id: String?
        let name: String
    }
}
