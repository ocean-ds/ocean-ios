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
    public class BadgeText: UIView {
        struct Constants {
            static let height: CGFloat = 17
        }
        
        public var text: String = "Novo" {
            didSet {
                updateUI()
            }
        }
        
        private lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseExtraBold(size: 10)
                label.text = self.text
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var mainStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0
            
            stack.add([
                label
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxxs,
                                        left: Ocean.size.spacingStackXxxs,
                                        bottom: Ocean.size.spacingStackXxxs,
                                        right: Ocean.size.spacingStackXxxs)
            
            return stack
        }()
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: frame.width, height: Constants.height)
            }
        }
        
        public convenience init(builder: BadgeTextBuilder) {
            self.init()
            setupUI()
            builder(self)
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorHighlightPure
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowRadius = 8
            self.layer.shadowColor = Ocean.color.colorHighlightPure.withAlphaComponent(0.24).cgColor
            self.layer.shadowOpacity = 1
            self.add(view: mainStack)
            
            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
        
        private func updateUI() {
            label.text = text
        }
    }
}
