//
//  LabeledImageCollectionViewCell.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit

class LabeledImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textLable: UILabel!
    
    var bordered: Bool = false {
        didSet {
            if bordered {
                self.layer.borderColor = UIColor.white.cgColor
                self.layer.cornerRadius = 10.0
                self.layer.borderWidth = 1
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
}
