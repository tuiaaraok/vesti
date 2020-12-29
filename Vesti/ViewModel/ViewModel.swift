//
//  ViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 22/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class ViewModel: TableViewViewModelType {
   
    private var selectedTableViewIndexPath: IndexPath?
    static var filteredItems: [RSSItem]?
    var category: Categories?
    var rssItems: [RSSItem]? {
        return DataFetcherService.shared.rssItems
    }
    
    func tableViewNumberOfRows() -> Int {
        guard let rssItems = rssItems else  { return 0 }
        return ViewModel.filteredItems?.count ?? rssItems.count
    }
    
    func tableViewCellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        if let rssItem = ViewModel.filteredItems?[indexPath.row] ?? rssItems?[indexPath.row] {
            return TableViewCellViewModel(rssItem: rssItem)
       }
       return nil
    }
    
    func tableViewViewModelForSelectedRow() -> DetailViewModelType? {
        guard let rssItems = rssItems else { return nil }
        guard let selectedIndexPath = selectedTableViewIndexPath else { return nil }
        return DetailViewModel(rssItem: ViewModel.filteredItems?[selectedIndexPath.row] ?? rssItems[selectedIndexPath.row])
    }
    
    func tableViewSelectRow(atIndexPath indexPath: IndexPath) {
        self.selectedTableViewIndexPath = indexPath
    }
}
