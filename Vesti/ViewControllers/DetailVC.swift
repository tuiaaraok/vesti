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
    var dataFetcherService = DataFetcherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailScreen()
        dataFetcherService.fetchImage(rssItem: rssItem, mainImage)
    }
    
    private func setupDetailScreen() {
          
        let dateText = rssItem.pubDate
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
        let newStr = String(dateText[..<endIndex])

        dateLabel.text = newStr
        titleLabel.text = rssItem.title
        fullTextLabel.text = rssItem.fullText
        
        fullTextLabel.setLineSpacing(lineSpacing: 1.2, lineHeightMultiple: 1.2)
        fullTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
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

