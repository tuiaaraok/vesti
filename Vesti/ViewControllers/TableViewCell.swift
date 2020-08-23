//
//  TableViewCell.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    func configure(_ rssItem: RSSItem, _ indexPath: IndexPath) {
        let dateText = rssItem.pubDate
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
        let newStr = String(dateText[..<endIndex])
                  
        dateLabel.text = newStr
        titleLabel.text = rssItem.title
    }
}
