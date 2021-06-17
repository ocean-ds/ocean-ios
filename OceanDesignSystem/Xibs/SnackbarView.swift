//
//  SnackbarView.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 20/08/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

@IBDesignable class SnackbarViewWrapper : NibWrapperView<SnackbarView> { }

class SnackbarView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageIcon: UIImageView!

    var message : String = "" {
        didSet { messageLabel.text = message }
    }
    
    var symbol : String = "" {
        didSet { messageIcon.image = Ocean.icon.informationCircleOutline }
    }
    
    
}

extension UIView {
    /// Load the view from a nib file called with the name of the class
    ///
    /// - Note: The first object of the nib file **must** be of the matching class
    static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}
