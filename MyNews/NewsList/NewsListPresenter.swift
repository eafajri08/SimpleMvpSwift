//
//  NewsListPresenter.swift
//  MyNews
//
//  Created by eafajri on 12/18/17.
//  Copyright © 2017 Erric Alfajri. All rights reserved.
//

import Foundation

protocol NewsListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setNewsList(_ newsList: [NewsListModel])
    func setEmptyList()
}

class NewsListPresenter {
    
    fileprivate let newsListService: NewsListService
    weak fileprivate var newsListView : NewsListView?
    
    init(newsListService: NewsListService){
        self.newsListService = newsListService
    }
    
    func attachView(_ view: NewsListView){
        newsListView = view
    }
    
    func detachView() {
        newsListView = nil
    }
    
    func getNewsData(newsResource: String) {
        self.newsListView?.startLoading()
        newsListService.getNewsList(newsResource: newsResource){ [weak self] newsData in
            self?.newsListView?.finishLoading()
            
            if newsData.count == 0 {
                self?.newsListView?.setEmptyList()
            }
            else {
                
                let mappedData = newsData.map{
                    return NewsListModel(source: $0.source!,
                                         author: $0.author,
                                         title: $0.title,
                                         description: $0.description,
                                         url: $0.url,
                                         urlToImage: $0.urlToImage,
                                         publishedAt: $0.publishedAt
                                        )
                }

                self?.newsListView?.setNewsList(mappedData)
            }
            
            
        }
        
    }
    
}
