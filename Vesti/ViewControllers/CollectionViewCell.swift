//
//  CollectionViewCell.swift
//  Vesti
//
//  Created by Айсен Шишигин on 03/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    
    func configure(_ indexPath: IndexPath, _ currentSelected: Int?) {
       
        var newsVC = NewsVC()
        categoryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        categoryLabel.text = newsVC.categories[indexPath.item].rawValue
    
        if currentSelected != nil && currentSelected == indexPath.row {
            categoryLabel.font = UIFont(name: "Palatino-Bold", size: 15)
        } else {
            categoryLabel.font = UIFont(name: "Palatino-Roman", size: 15)
        }
    }
}
