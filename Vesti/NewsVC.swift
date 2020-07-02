//
//  ViewController.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit


 enum Categories: String, CaseIterable {
        
    case all = "Все"
    case society = "Общество"
    case politics = "Политика"
    case sport = "Спорт"
    case culture = "Культура"
    case science = "Наука"
    case ecinomics = "Экономика"
    case acsident = "Происшествия"
    case medicine = "Медицина"
    case auto = "Авто"
    case regions = "Регионы"
    case hiTech = "Hi-tech"
    case exclusive = "Эксклюзив"
        
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        tableView.rowHeight = 107
        
        tableView.delegate = self
        tableView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        

        
    }
    
    
    
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

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
