//
//  DetailVC.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var fullTextLabel: UILabel!
    @IBOutlet var scroll: UIScrollView!
    
    var rssItem: RSSItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let dateText = rssItem.pubDate
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -15)
        let truncated = dateText.substring(to: endIndex)

        dateLabel.text = truncated
        titleLabel.text = rssItem.title
        fullTextLabel.text = rssItem.fullText
        
        fullTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
     
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        fullTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        createConstraints()
   
    }
    
    
    
    // create function to set the constraints
    func createConstraints() {
        
        
        mainImage.topAnchor.constraint(
            equalTo: scroll.topAnchor,
            constant: 20
            ).isActive = true

        mainImage.centerXAnchor.constraint(
            equalTo: scroll.centerXAnchor
            ).isActive = true

        mainImage.leadingAnchor.constraint(
            equalTo: scroll.leadingAnchor,
            constant: 15
            ).isActive = true
        
        
        let currentHeight = self.view.frame.size.height

        if currentHeight > 736 {
              mainImage.heightAnchor.constraint(
              equalTo: view.heightAnchor,
              multiplier: 243/1000
              ).isActive = true
          } else {
              mainImage.heightAnchor.constraint(
              equalTo: view.heightAnchor,
              multiplier: 243/830
              ).isActive = true
          }
        
        
        
        
        titleLabel.topAnchor.constraint(
            equalTo: mainImage.bottomAnchor,
            constant: 20
            ).isActive = true
                         
        titleLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true

        titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
            ).isActive = true
        
        
        
        
        dateLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: 20
            ).isActive = true
                                
        dateLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/30
            ).isActive = true

        dateLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
            ).isActive = true
               
        
        
        
        fullTextLabel.topAnchor.constraint(
            equalTo: dateLabel.bottomAnchor
            ).isActive = true
                                

        fullTextLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true

        fullTextLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
            ).isActive = true
        
        fullTextLabel.bottomAnchor.constraint(
                   equalTo: scroll.bottomAnchor
                   ).isActive = true
               }
}


