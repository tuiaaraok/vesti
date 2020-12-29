//
//  TableViewCellViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 22/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    
    private var rssItem: RSSItem
    
    var date: String {
        let dateText = rssItem.pubDate
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
        let newStr = String(dateText[..<endIndex])
        return newStr
    }
    
    var title: String {
        return rssItem.title
    }
    
    init(rssItem: RSSItem) {
        self.rssItem = rssItem
    }
}
