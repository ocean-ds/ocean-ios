//
//  Ocean+BadgeDot.swift
//  OceanComponents
//
//  Created by Vini on 03/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class BadgeDot: UIView {
        struct Constants {
            static let size: CGFloat = 8
        }
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: Constants.size, height: Constants.size)
            }
        }
        
        public convenience init(builder: BadgeDotBuilder) {
            self.init()
            setupUI()
            builder(self)
        }
        
        private func setupUI() {
            self.clipsToBounds = true
            self.layer.cornerRadius = Constants.size * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorHighlightPure
            self.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: Constants.size),
                self.heightAnchor.constraint(equalToConstant: Constants.size)
            ])
        }
    }
}
