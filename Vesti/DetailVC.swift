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
        
        fullTextLabel.setLineSpacing(lineSpacing: 1.2, lineHeightMultiple: 1.2)
        
        let dateText = rssItem.pubDate
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
        let newStr = String(dateText[..<endIndex])

        dateLabel.text = newStr
        titleLabel.text = rssItem.title
        fullTextLabel.text = rssItem.fullText
        
        fullTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        createConstraints()
        fetchImage()
    }
    
    func fetchImage() {
        
        let url = NSURL(string: rssItem.images["image"]!)
        let data = NSData(contentsOf:url! as URL)
        let image = UIImage(data:data! as Data)
        mainImage.image = image
    }

    // create function to set the constraints
    func createConstraints() {
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        fullTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
              multiplier: 320/1000
              ).isActive = true
          } else {
              mainImage.heightAnchor.constraint(
              equalTo: view.heightAnchor,
              multiplier: 325/830
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

extension UILabel {

    //create a function to set the interval
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
    
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

