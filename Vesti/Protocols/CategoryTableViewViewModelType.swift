//
//  CategoryTableViewViewModelType.swift
//  Vesti
//
//  Created by Айсен Шишигин on 03/01/2021.
//  Copyright © 2021 Туйаара Оконешникова. All rights reserved.
//

import Foundation

protocol CategoryTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModel?
    func selectRow(atIndexPath indexPath: IndexPath)
}
