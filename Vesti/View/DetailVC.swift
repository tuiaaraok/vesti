//
//  DetailVC.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet private var mainImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var fullTextLabel: UILabel!
    @IBOutlet private var scroll: UIScrollView!
    
    var viewModel: DetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailScreen()
        configureScreen()
    }
    
    private func setupDetailScreen() {
        fullTextLabel.setLineSpacing(lineSpacing: 1.2, lineHeightMultiple: 1.2)
        fullTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+fullTextLabel.bounds.height)
    }
    
    private func configureScreen() {
        guard let viewModel = viewModel else { return }
                 
        let dateText = viewModel.date
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
        let newStr = String(dateText[..<endIndex])

        dateLabel.text = newStr
        titleLabel.text = viewModel.title
        fullTextLabel.text = viewModel.fullText
        guard let imageData = viewModel.image else { return }
        mainImage.image = UIImage(data: imageData)
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

