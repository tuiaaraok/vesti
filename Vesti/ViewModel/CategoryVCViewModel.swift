//
//  CategoryVCViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 26/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class CategoryVCViewModel: CategoryTableViewViewModelType {
    
    static var category: Categories!
    
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
        CategoryVCViewModel.category = categories[indexPath.item]
        
        let newsVC = NewsVC()
        NewsVCViewModel.filteredItems = newsVC.categoryFilter(by: CategoryVCViewModel.category)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "configureErrorLabel"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
}
