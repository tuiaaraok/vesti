//
//  ViewController.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var errorLabel: UILabel!
    
    let categories = Categories.allCases
    var rssItems: [RSSItem]?
   
    var previousSelected : IndexPath?
    var currentSelected : Int?
    
    private var myRefreshControl = UIRefreshControl()
    private var dataFetcherService = DataFetcherService()
    private var categoryManager = CategoryManager()
    private var filteredItems: [RSSItem]?
    private var category: Categories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        tableView.rowHeight = 107
        
        myRefreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        dataFetcherService.fetchData(completion: fetch(rssItems:))
    
    }
    
    private func fetch(rssItems: [RSSItem]) {
        self.rssItems = rssItems
         OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        
        dataFetcherService.fetchData(completion: fetch(rssItems:))
           if category != nil {
            filteredItems = rssItems!.filter{$0.category == category!.rawValue}
            tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    // MARK: - Table view data sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else  { return 0 }
        return filteredItems?.count ?? rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if let rssItem = filteredItems?[indexPath.row] ?? rssItems?[indexPath.row] {
            cell.configure(rssItem, indexPath)
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "detail" else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.rssItem = filteredItems?[indexPath.row] ?? rssItems?[indexPath.row]
        }
    }
}

    // MARK: - Extension Collection View data sourse

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcell", for: indexPath) as! CategoryCollectionViewCell
    
        cell.configure(indexPath, currentSelected)
                 
        return cell
    }
    
    // MARK: - Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if previousSelected != nil{
            if let cell = collectionView.cellForItem(at: previousSelected!) as! CategoryCollectionViewCell?{
                cell.categoryLabel.font = UIFont(name: "Palatino-Roman", size: 15)
            }
        }
        currentSelected = indexPath.row
        previousSelected = indexPath

        collectionView.reloadItems(at: [indexPath])
               
        category = categories[indexPath.item]
        filteredItems = categoryManager.categoryFilter(rssItems,
                                                       by: category!,
                                                       errorLabel,
                                                       dataFetcherService.fetchData(completion: fetch(rssItems:)),
                                                       tableView)
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 100, height: 40.0)
       }
}
