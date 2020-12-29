//
//  RSSItem.swift
//  Vesti
//
//  Created by Айсен Шишигин on 21/08/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

struct RSSItem {
    var title: String
    var fullText: String
    var pubDate: String
    var category: String
    var images: [String : String]
 
    
enum CodingKeys: String, CodingKey {   
    case title = "title"
    case fullText = "yandex:full-text"
    case pubDate = "pubDate"
    case category = "category"
    case images = "enclosure url="
      }
}
