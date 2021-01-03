//
//  ViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 22/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class NewsVCViewModel: NewsTableViewViewModelType {
   
    private var selectedTableViewIndexPath: IndexPath?
    static var filteredItems: [RSSItem]?
    var rssItems: [RSSItem]? {
        return DataFetcherService.shared.rssItems
    }
    
    func reload() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func numberOfRows() -> Int {
        guard let rssItems = rssItems else  { return 0 }
        return NewsVCViewModel.filteredItems?.count ?? rssItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelType? {
        if let rssItem = NewsVCViewModel.filteredItems?[indexPath.row] ?? rssItems?[indexPath.row] {
            return NewsTableViewCellViewModel(rssItem: rssItem)
       }
       return nil
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedTableViewIndexPath = indexPath
    }
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let rssItems = rssItems else { return nil }
        guard let selectedIndexPath = selectedTableViewIndexPath else { return nil }
        return DetailViewModel(rssItem: NewsVCViewModel.filteredItems?[selectedIndexPath.row] ?? rssItems[selectedIndexPath.row])
    }
}
