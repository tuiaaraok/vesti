//
//  CategoryFilter.swift
//  Vesti
//
//  Created by Айсен Шишигин on 21/08/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import UIKit

class CategoryManager {
    
    func categoryFilter(_ rssItems: [RSSItem]?, by sender: Categories, _ errorLabel: UILabel, _ fetchData: (), _ tableView: UITableView) -> [RSSItem]{
           
        var filteredItems: [RSSItem] = []
        if sender.rawValue == "все" {
            fetchData
            return rssItems!
        } else {
            errorLabel.isHidden = true
            filteredItems = rssItems!.filter{$0.category == sender.rawValue}
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
               
            if filteredItems.count == 0 {
                errorLabel.isHidden = false
                errorLabel.text = "В этой категории пока нет новостей"
            }
            return filteredItems
            }
    }
}
