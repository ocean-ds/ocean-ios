//
//  Ocean+BadgeNumber.swift
//  OceanComponents
//
//  Created by Vini on 03/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class BadgeNumber: UIView {
        struct Constants {
            static let height: CGFloat = 24
            static let heightSmall: CGFloat = 16
        }
        
        public enum Status {
            case primary
            case complementary
            case highlight
            case alert
            case neutral
        }
        
        public var status: Status = .primary {
            didSet {
                updateStatus()
            }
        }
        
        public enum Size {
            case medium
            case small
        }
        
        public var size: Size = .medium {
            didSet {
                updateSize()
            }
        }
        
        public var number: Int = 0 {
            didSet {
                updateUI()
            }
        }
        
        private lazy var widthConstraint: NSLayoutConstraint = {
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.size == .medium ? Constants.height : Constants.heightSmall)
        }()
        
        private lazy var heightConstraint: NSLayoutConstraint = {
            self.heightAnchor.constraint(equalToConstant: self.size == .medium ? Constants.height : Constants.heightSmall)
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
        
        private lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseExtraBold(size: self.size == .medium ? 12 : 10)
                label.text = self.number.description
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: frame.width, height: Constants.height)
            }
        }
        
        public convenience init(builder: BadgeNumberBuilder) {
            self.init()
            setupUI()
            builder(self)
        }
        
        private func setupUI() {
            self.clipsToBounds = true
            let height = self.size == .medium ? Constants.height : Constants.heightSmall
            self.layer.cornerRadius = height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorBrandPrimaryPure
            self.translatesAutoresizingMaskIntoConstraints = false
            self.add(view: mainStack)
            
            widthConstraint.isActive = true
            heightConstraint.isActive = true
        }
        
        private func updateUI() {
            label.text = self.size == .medium ?
                number > 99 ? "99+" : number.description :
                number > 9 ? "9+" : number.description
        }
        
        private func updateSize() {
            label.font = .baseExtraBold(size: self.size == .medium ? 12 : 10)
            let height = self.size == .medium ? Constants.height : Constants.heightSmall
            self.layer.cornerRadius = height * Ocean.size.borderRadiusCircular
            widthConstraint.constant = height
            heightConstraint.constant = height
        }
        
        private func updateStatus() {
            switch self.status {
            case .complementary:
                self.backgroundColor = Ocean.color.colorComplementaryPure
            case .highlight:
                self.backgroundColor = Ocean.color.colorHighlightPure
            case .alert:
                self.backgroundColor = Ocean.color.colorStatusNeutralDeep
            case .neutral:
                self.backgroundColor = Ocean.color.colorInterfaceDarkUp
            default:
                self.backgroundColor = Ocean.color.colorBrandPrimaryPure
            }
        }
    }
}
