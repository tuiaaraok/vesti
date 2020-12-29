//
//  TableViewCell.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            dateLabel.text = viewModel.date
            titleLabel.text = viewModel.title
        }
    }
}
