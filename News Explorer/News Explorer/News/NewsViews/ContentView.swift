//
//  ContentView.swift
//  News Explorer
//
//  Created by Marta Kalichynska on 03.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var searchText = ""
    @State private var dateFilterEnabled = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    searchTextField
                    Button(action: {
                        viewModel.fetch(q: searchText)
                    }) {
                        Text("Search")
                    }
                    .frame(width: 80, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                DateFilterView(startDate: $startDate, endDate: $endDate, dateFilterEnabled: $dateFilterEnabled)
                newsList
            }
            .navigationTitle("News")
            .background(Color.orange)
        }
    }
    
    private var searchTextField: some View {
        VStack {
            TextField("Search News", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
        }
    }
    
    private var newsList: some View {
        List {
            ForEach(filteredNews, id: \.self) { news in
                NavigationLink(destination: NewsDetails(news: news)) {
                    NewsCell(news: news, searchText: searchText)
                }
            }
        }
    }
    
    private var filteredNews: [News] {
        let titleContainsSearchText = { (news: News) in
            searchText.isEmpty || news.title.localizedCaseInsensitiveContains(searchText)
        }
        
        let descriptionContainsSearchText = { (news: News) in
            searchText.isEmpty || news.description.localizedCaseInsensitiveContains(searchText)
        }
        
        let isDateInRange = { (news: News) in
            dateFilterEnabled ? startDate...endDate ~= parseDate(news.publishedAt) : true
        }
        
        return viewModel.news.filter { news in
            titleContainsSearchText(news) && descriptionContainsSearchText(news) && isDateInRange(news)
        }
    }
    
    private func parseDate(_ dateString: String?) -> Date {
        guard let dateString = dateString, let date = ISO8601DateFormatter().date(from: dateString) else {
            return Date()
        }
        return date
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
