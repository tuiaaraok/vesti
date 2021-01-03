//
//  CategoryTableViewCellViewModelType.swift
//  Vesti
//
//  Created by Айсен Шишигин on 03/01/2021.
//  Copyright © 2021 Туйаара Оконешникова. All rights reserved.
//

import Foundation

protocol CategoryTableViewCellViewModelType: class {
    var category: Categories { get }
    var categoryName: String { get }
}
