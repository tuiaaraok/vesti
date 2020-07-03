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
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        createConstraints()
    }


    
    func createConstraints() {
        
        dateLabel.widthAnchor.constraint(
            equalTo: contentView.widthAnchor,
            multiplier: 1
        ).isActive = true
                     
        dateLabel.heightAnchor.constraint(
            equalTo: contentView.heightAnchor,
            multiplier: 1/9
        ).isActive = true

        dateLabel.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor,
            constant: -35
        ).isActive = true

        dateLabel.leftAnchor.constraint(
            equalTo: contentView.leftAnchor,
            constant: 15
        ).isActive = true
           
           
           
           
        titleLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: 5
        ).isActive = true

        titleLabel.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor,
            constant: 12
        ).isActive = true

        titleLabel.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor,
            constant: 12
        ).isActive = true
           
        titleLabel.leftAnchor.constraint(
            equalTo: contentView.leftAnchor,
            constant: 15
        ).isActive = true
           
        titleLabel.rightAnchor.constraint(
            equalTo: contentView.rightAnchor,
            constant: -15
        ).isActive = true
        
    }

}
