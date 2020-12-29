//
//  TableViewViewModelType.swift
//  Vesti
//
//  Created by Айсен Шишигин on 22/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

protocol TableViewViewModelType {
    var rssItems: [RSSItem]? {get}
    func tableViewNumberOfRows() -> Int
    func tableViewCellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    func tableViewViewModelForSelectedRow() -> DetailViewModelType?
    func tableViewSelectRow(atIndexPath indexPath: IndexPath)
}
