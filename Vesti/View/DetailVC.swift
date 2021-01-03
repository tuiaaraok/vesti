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
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    var viewModel: DetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailScreen()
        configureScreen()
    }
    
    private func setupDetailScreen() {
        imageActivityIndicator.startAnimating()
        imageActivityIndicator.hidesWhenStopped = true
        fullTextLabel.setLineSpacing(lineSpacing: 1.2, lineHeightMultiple: 1.2)
        fullTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                    height: UIScreen.main.bounds.height+fullTextLabel.bounds.height)
    }
    
    private func configureScreen() {
        guard let viewModel = viewModel else { return }
        let dateText = viewModel.date
        let endIndex = dateText.index(dateText.endIndex , offsetBy: -9)
        let newStr = String(dateText[..<endIndex])
        
        let dateManager = DateManager()
        dateLabel.text = dateManager.translatePubdate(from: newStr)
        titleLabel.text = viewModel.title
        fullTextLabel.text = viewModel.fullText
        guard let imageData = viewModel.image else { return }
        mainImage.image = UIImage(data: imageData) 
        imageActivityIndicator.stopAnimating()
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

extension String {

  var length: Int {
    return count
  }

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                        upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}
