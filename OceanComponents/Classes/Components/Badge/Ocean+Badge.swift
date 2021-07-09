//
//  Ocean+Badge.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class Badge: UIView {
        struct Constants {
            static let width: CGFloat = 46
            static let height: CGFloat = 20
        }
        
        lazy var label: UILabel = {
            Ocean.Typography.caption { label in
                label.text = "Novo"
                label.textColor = .white
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                label.backgroundColor = Ocean.color.colorHighlightPure
                label.clipsToBounds = true
                label.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            }
        }()
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: Constants.width, height: Constants.height)
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.add(view: label)
            
            label.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true
            label.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
    }
}
