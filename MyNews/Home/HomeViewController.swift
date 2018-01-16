//
//  HomeViewController.swift
//  MyNews
//
//  Created by eafajri on 12/18/17.
//  Copyright © 2017 Erric Alfajri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate let homePresenter = HomePresenter(homeService: HomeService())
    fileprivate var homeDataToDisplay = [HomeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        homePresenter.attachView(self)
        homePresenter.getHomeData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController: HomeView {
    
    func startLoading() {
        tableView.reloadData()
        
    }
    
    func finishLoading() {
        
        
    }
    
    func setHome(_ home: [HomeModel]) {
        homeDataToDisplay = home
        tableView.isHidden = false
        tableView.reloadData()
        
    }
    
    func setEmptyHome() {
        
        tableView.isHidden = true
        
    }
    
}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeDataToDisplay.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let dataToShow = homeDataToDisplay[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataToShow.name
        
        return cell
        
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        homePresenter.present(inContext: navigationController!, selecetedHomeData: homeDataToDisplay[indexPath.row])
        
    }
    
}


