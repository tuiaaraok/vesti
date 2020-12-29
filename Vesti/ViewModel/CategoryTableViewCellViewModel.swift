//
//  CategoryTableViewCellViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 26/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class CategoryTableViewCellViewModel {
    var category: Categories
    
    var categoryName: String {
        return category.rawValue
    }
    
    init(category: Categories) {
        self.category = category
    }
}
