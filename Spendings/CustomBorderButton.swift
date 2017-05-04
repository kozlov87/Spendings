//
// Copyright (c) 2016 Козлов Егор. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomBorderButton: UIButton  {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.cornerRadius = 0.4 * self.bounds.size.width
        }
    }
    @IBInspectable var background: UIColor? {
        didSet {
            self.backgroundColor = background
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
