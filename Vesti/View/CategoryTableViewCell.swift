//
//  CategoryTableViewCell.swift
//  Vesti
//
//  Created by Айсен Шишигин on 26/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    weak var viewModel: CategoryTableViewCellViewModel? {
           willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            guard let textLabel = textLabel else { return }
            textLabel.text = viewModel.categoryName
            textLabel.font = UIFont(name: "Palatino-Roman", size: 15)
            print(viewModel.categoryName)
        }
    }
}
