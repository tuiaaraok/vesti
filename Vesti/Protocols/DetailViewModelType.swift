//
//  DetailViewModelType.swift
//  Vesti
//
//  Created by Айсен Шишигин on 22/12/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

protocol DetailViewModelType {
    var date: String { get }
    var title: String { get }
    var image: Data? { get }
    var fullText: String { get }
}
