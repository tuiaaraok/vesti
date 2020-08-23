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
    
     var url = "https://www.vesti.ru/vesti.rss"
    
    func fetchImage(rssItem: RSSItem, _ mainImage: UIImageView) {
        
        let url = NSURL(string: rssItem.images["image"]!)
        let data = NSData(contentsOf: url! as URL)
        let image = UIImage(data:data! as Data)
        mainImage.image = image
    }
    
    func fetchData(completion: @escaping ([RSSItem]) -> ()) {
        
        let feedParser = ParserManager()
        let _ : ParserManager = ParserManager().initWithURL(URL(string: url)!) as! ParserManager
        feedParser.parseFeed(url: url) { (rssItems) in
            completion(rssItems)
        }
    }
}

 
