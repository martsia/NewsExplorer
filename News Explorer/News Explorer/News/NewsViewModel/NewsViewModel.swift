//
//  NewsViewModel.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 03.10.2023.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var news: [News] = []
    
    private var dataService: NewsDataService
    
    init(dataService: NewsDataService = NewsDataServiceImpl()) {
        self.dataService = dataService
    }
    
    func fetch(q: String) {
        dataService.fetchNews(q: q) { [weak self] news in
            if let news = news {
                self?.news = news
            } else {
                print("Failed to fetch news data.")
            }
        }
    }
}
