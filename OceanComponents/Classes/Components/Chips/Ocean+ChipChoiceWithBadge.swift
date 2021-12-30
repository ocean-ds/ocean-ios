//
//  Ocean+ChoiceWithBadge.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 07/12/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class ChipChoiceWithBagde: UICollectionViewCell {
        static let cellId = "ChipWithBadgeCell"
        
        struct Constants {
            static let height: CGFloat = 32
        }
        
        public var index: Int = 0
        
        public var allowDeselect = false
        
        public var text: String = "Label" {
            didSet {
                updateUI()
            }
        }
        
        public var status: ChipStatus = .normal {
            didSet {
                updateUI()
            }
        }
        
        public var number: Int? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var onValueChange: ((Bool, ChipChoiceWithBagde) -> Void)? = nil
        
        private lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: 14)
                label.text = self.text
                label.textColor = Ocean.color.colorBrandPrimaryDown
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var badge: Ocean.BadgeNumber = {
            Ocean.Badge.number { view in
                view.status = .alert
                view.size = .small
                if let value = self.number {
                    view.number = value
                }
            }
        }()
        
        private lazy var mainStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 6
            
            stack.add([
                badge,
                label
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func prepareForReuse() {
            super.prepareForReuse()
            self.badge.status = .alert
        }

        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderColor = Ocean.color.colorStatusNegativePure.cgColor
            self.layer.borderWidth = 0

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)
            
            contentView.add(view: mainStack)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInSide))
            self.addGestureRecognizer(tapGesture)
            
            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
        
        private func updateUI() {
            self.label.text = self.text

            self.badge.isHidden = true
            if let numberValue = self.number {
                self.badge.number = numberValue
                self.badge.isHidden = false
                if numberValue == 0 {
                    self.badge.status = .neutral
                }
            }
            
            switch status {
            case .normal:
                self.setNormalState()
            case .selected:
                self.setSelectedState()
            case .disabled:
                self.setDisabledState()
            case .error:
                self.setErrorState()
            }
        }
        
        private func setNormalState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorBrandPrimaryDown
        }
        
        private func setSelectedState() {
            self.backgroundColor = Ocean.color.colorBrandPrimaryDown
            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceLightPure
        }
        
        private func setDisabledState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func setErrorState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderWidth = 1
            self.label.textColor = Ocean.color.colorBrandPrimaryDown
        }
        
        @objc func touchUpInSide() {
            switch status {
            case .normal:
                self.status = .selected
                onValueChange?(true, self)
            case .selected:
                if self.allowDeselect {
                    self.status = .normal
                    onValueChange?(false, self)
                }
            default:
                break
            }
        }
    }
}
