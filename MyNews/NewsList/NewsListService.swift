//
//  NewsListService.swift
//  MyNews
//
//  Created by eafajri on 12/18/17.
//  Copyright © 2017 Erric Alfajri. All rights reserved.
//

import Foundation


class NewsListService {
    
    func getNewsList(newsResource: String, _ callBack:@escaping ([NewsListModel]) -> Void){
        
        var newsList: [NewsListModel] = []
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=\(newsResource)&apiKey=522da0d9c8be4275a05b342714a29d76")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            let json = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if (json == nil) {
                print("error parsing JSON")
            }
            else {
                let listOfNews = json!["articles"] as? NSArray
                for item in listOfNews! {

                    let newsItem = item as? NSDictionary
                    let news = NewsListModel(
                        source: String(describing: newsItem!["source"]),
                        author: newsItem!["author"] as? String,
                        title: newsItem!["title"] as? String,
                        description: newsItem!["description"] as? String,
                        url: newsItem!["url"] as? String,
                        urlToImage: newsItem!["urlToImage"] as? String,
                        publishedAt: newsItem!["publishedAt"] as? String
                    )
                    newsList.append(news)
                }
                callBack(newsList)
            }
            
        }
        task.resume()

    }
    
}
