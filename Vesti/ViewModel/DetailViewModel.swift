//
//  DetailViewModel.swift
//  Vesti
//
//  Created by Айсен Шишигин on 22/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class DetailViewModel: DetailViewModelType {
    
    private var rssItem: RSSItem
    
    var date: String {
        return  rssItem.pubDate
    }
    
    var title: String {
        return  rssItem.title
    }
    
    var image: Data? {
        DataFetcherService.shared.fetchImage(rssItem: rssItem)
        guard let imageData = DataFetcherService.shared.imageData else { return nil }
        return imageData
    }
    
    var fullText: String {
        return  rssItem.fullText
    }

    init(rssItem: RSSItem) {
        self.rssItem = rssItem
    }
}

