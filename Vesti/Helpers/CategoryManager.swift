//
//  CategoryFilter.swift
//  Vesti
//
//  Created by Айсен Шишигин on 21/08/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import UIKit

extension NewsVC {
    
    func categoryFilter(by sender: Categories) -> [RSSItem]?{
        var filteredItems: [RSSItem] = []
        if let rssItems = DataFetcherService.shared.rssItems {
            if sender.rawValue == "Главная" {
                return rssItems
            } else {
                filteredItems = rssItems.filter{$0.category == sender.rawValue}
                if filteredItems.count == 0 {
                    return []
                }
                return filteredItems
            }
        }
        return filteredItems
    }
}
