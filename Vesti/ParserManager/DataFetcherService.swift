//
//  DataFetcheService.swift
//  Vesti
//
//  Created by Айсен Шишигин on 21/08/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import UIKit

class DataFetcherService {
    static var shared = DataFetcherService()
    
    var urlString = "https://www.vesti.ru/vesti.rss"
    var rssItems: [RSSItem]?
    var imageData: Data?
    
    func fetchImage(rssItem: RSSItem) {
        let url = NSURL(string: rssItem.images["image"]!)
        let data = NSData(contentsOf: url! as URL)
        imageData = data as Data?
    }
    
    func fetchData(completion: @escaping () -> ()) {
        let feedParser = ParserManager()
        guard let url = URL(string: urlString) else { return }
        let _ : ParserManager = ParserManager().initWithURL(url) as! ParserManager
        feedParser.parseFeed(url: url) { (rssItems) in
            self.rssItems = rssItems
            completion()
        }
    }
}

 
