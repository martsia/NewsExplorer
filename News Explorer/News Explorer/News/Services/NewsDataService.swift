//
//  NewsDataService.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 05.10.2023.
//

import Foundation

protocol NewsDataService {
    func fetchNews(q: String, completion: @escaping ([News]?) -> Void)
}

class NewsDataServiceImpl: NewsDataService {
    func fetchNews(q: String, completion: @escaping ([News]?) -> Void) {
        let apiKey = "6b97ba32151f4bc583ee37ca3c8de889"
        guard let url = URL(string: "https://newsapi.org/v2/everything?apiKey=\(apiKey)&q=\(q)") else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let news = try JSONDecoder().decode(NewsData.self, from: data).articles
                completion(news)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
}

