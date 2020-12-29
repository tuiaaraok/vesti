//
//  CategoryVCViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 26/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class CategoryVCViewModel {
    
    var currentSelected: Int?
    var previousSelected : IndexPath?
    var category: Categories!
    
    var categories: [Categories] {
        return Categories.allCases
    }
    
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModel? {
        let category = categories[indexPath.row]
        return CategoryTableViewCellViewModel(category: category)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.previousSelected = indexPath
        self.currentSelected = indexPath.row
                
        category = categories[indexPath.item]
        
        let newsVC = NewsVC()
        ViewModel.filteredItems = newsVC.categoryFilter(by: category)
        if ViewModel.filteredItems?.count == 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "configureErrorLabel"), object: nil)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
}
