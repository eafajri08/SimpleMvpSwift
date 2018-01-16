//
//  NewsListViewController.swift
//  MyNews
//
//  Created by eafajri on 12/18/17.
//  Copyright © 2017 Erric Alfajri. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    fileprivate let newsListPresenter = NewsListPresenter(newsListService: NewsListService())
    fileprivate var newsListDataToDisplay = [NewsListModel]()
    fileprivate var filteredNewsList = [NewsListModel]()
    
    var newsResource: HomeModel!
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = newsResource.name
        
        tableView.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        tableView.tableHeaderView = searchController.searchBar

        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        newsListPresenter.attachView(self)
        newsListPresenter.getNewsData(newsResource: newsResource.key)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
}

extension NewsListViewController: NewsListView {

    func startLoading() {
        tableView.reloadData()
        
        indicatorView.startAnimating()
        
    }
    
    func finishLoading() {
        
        
    }
    
    func setNewsList(_ newsList: [NewsListModel]) {
        DispatchQueue.main.async {
            self.newsListDataToDisplay = newsList
            
            self.tableView.isHidden = false
            self.tableView.reloadData()
            
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()

        }
    }
    
    func setEmptyList() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()
        }
    }
    
}

extension NewsListViewController: UISearchResultsUpdating {
    
    @available(iOS 8.0, *)
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only those countries that match the search text.
        filteredNewsList = newsListDataToDisplay.filter { news in
            return (news.title?.lowercased().range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
        }
        tableView.reloadData()

    }
    
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredNewsList.count
        }
        else {
            return newsListDataToDisplay.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dataToShow: NewsListModel
        if searchController.isActive && searchController.searchBar.text != "" {
            dataToShow = filteredNewsList[indexPath.row]
        }
        else {
            dataToShow = newsListDataToDisplay[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as! NewsListTableViewCell
        cell.setCellView(with: dataToShow)
        
        return cell
        
    }
    
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let currentItem = homeDataToDisplay[indexPath.row]
        
//        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "NewsListViewController_SB")
//        self.navigationController?.pushViewController(vc2!, animated: true)
        
    }
    
}


