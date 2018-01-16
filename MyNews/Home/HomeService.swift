//
//  HomeService.swift
//  MyNews
//
//  Created by eafajri on 12/18/17.
//  Copyright © 2017 Erric Alfajri. All rights reserved.
//

import Foundation

class HomeService {

    func getHome(_ callBack:@escaping ([HomeModel]) -> Void){
        let homeData = [HomeModel(name: "ABC News", key: "abc-news"),
                        HomeModel(name: "Bloomberg", key: "bloomberg"),
                        HomeModel(name: "BBC News", key: "bbc-news"),
                        HomeModel(name: "CNN", key: "cnn"),
                        HomeModel(name: "Google News", key: "google-news"),
                        HomeModel(name: "National Geographic", key: "national-geographic"),
                        HomeModel(name: "The Huffington Post", key: "the-huffington-post"),
                        HomeModel(name: "The Wall Street Journal", key: "google-news")
        ]

        callBack(homeData)
    }
    
}

