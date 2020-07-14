//
//  ViewController.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit


 enum Categories: String, CaseIterable {
        
    case all = "все"
    case society = "общество"
    case politics = "политика"
    case sport = "спорт"
    case culture = "культура"
    case science = "наука"
    case ecinomics = "экономика"
    case acsident = "происшествия"
    case medicine = "медицина"
    case auto = "авто"
    case regions = "регионы"
    case hiTech = "hi-tech"
    case exclusive = "эксклюзив"
        
}

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    // MARK: - IB outlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    
    // MARK: - Private properties
          
    private let categories = Categories.allCases
    private var category: Categories?
    private var rssItems: [RSSItem]?
    private var currentItems: [RSSItem]?
    private var url = "https://www.vesti.ru/vesti.rss"
    
    
    var previousSelected : IndexPath?
    var currentSelected : Int?
    var myRefreshControl = UIRefreshControl()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        tableView.rowHeight = 107
        
        tableView.delegate = self
        tableView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        myRefreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        categoryFilter(.all)
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        fetchData()
//        categoryFilter(category!)
//    }
    
    
    // MARK: - Fetch data
    private func fetchData() {
        let feedParser = ParserManager()
        let _ : ParserManager = ParserManager().initWithURL(URL(string: url)!) as! ParserManager
        feedParser.parseFeed(url: url) { (rssItems) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
    
    
    
    
    // Filter by category
       
    private func categoryFilter(_ sender: Categories) {
        
        if sender.rawValue == "все" {
            fetchData()
        } else {
            currentItems = rssItems
            rssItems = rssItems!.filter{$0.category == sender.rawValue}
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            rssItems = currentItems
        }
    }
    
    
    // pull to refresh
    @objc private func refresh(sender: UIRefreshControl) {
        
           if category == nil {
            viewWillAppear(true)
           } else {
            categoryFilter(category!)
        }
        sender.endRefreshing()
        
    }
    
    
    
    
    
    // MARK: - Table view data sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else  {
            return 0
        }
        return rssItems.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if let rssItem = rssItems?[indexPath.row] {
            let dateText = rssItem.pubDate
            let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
            let truncated = dateText.substring(to: endIndex)
            
            cell.dateLabel.text = truncated
            cell.titleLabel.text = rssItem.title
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "detail" else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.rssItem = rssItems?[indexPath.row]
        }
    }
    
}








    // MARK: - Extension Collection View data sourse

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcell", for: indexPath) as! CollectionViewCell
                  
        cell.categoryLabel.text = categories[indexPath.item].rawValue
        cell.categoryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                 
                  
        // To set the font style on click
                  
        if currentSelected != nil && currentSelected == indexPath.row {
            cell.categoryLabel.font = UIFont(name: "Palatino-Bold", size: 15)
        } else {
            cell.categoryLabel.font = UIFont(name: "Palatino-Roman", size: 15)
        }
        return cell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // For remove previously selection
        if previousSelected != nil{
            if let cell = collectionView.cellForItem(at: previousSelected!) as! CollectionViewCell?{
                cell.categoryLabel.font = UIFont(name: "Palatino-Roman", size: 15)
            }
        }
        currentSelected = indexPath.row
        previousSelected = indexPath

        // For reload the selected cell
        collectionView.reloadItems(at: [indexPath])
               
           
        // Set action when clicking on a cell
        category = categories[indexPath.item]
        categoryFilter(category!)
     
        
          }
       
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 100, height: 40.0)
       }
}
