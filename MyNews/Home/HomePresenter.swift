//
//  HomePresenter.swift
//  MyNews
//
//  Created by eafajri on 12/18/17.
//  Copyright © 2017 Erric Alfajri. All rights reserved.
//

import Foundation
import UIKit

protocol HomeView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setHome(_ home: [HomeModel])
    func setEmptyHome()

}

class HomePresenter {
    
    fileprivate let homeService: HomeService
    weak fileprivate var homeView : HomeView?
    
    init(homeService:HomeService){
        self.homeService = homeService
    }
    
    func attachView(_ view:HomeView){
        homeView = view
    }
    
    func detachView() {
        homeView = nil
    }
    func getHomeData() {
        self.homeView?.startLoading()
        homeService.getHome{ [weak self] homeData in
            self?.homeView?.finishLoading()
            if homeData.count == 0 {
                self?.homeView?.setEmptyHome()
            }
            else {
                let mappedHomeData = homeData.map{
                    return HomeModel(name: "\($0.name)", key: "\($0.key)")
                }
                self?.homeView?.setHome(mappedHomeData)
            }
            
        }
    }
    
    func present(inContext context: UINavigationController, selecetedHomeData: HomeModel) {
        // create the BViewController here
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController_SB") as! NewsListViewController
        
        vc2.newsResource = selecetedHomeData
        context.pushViewController(vc2, animated: true)
        
    }
    
}
