//
//  Ocean+ChipText.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 06/12/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class ChipChoice: UICollectionViewCell {
        static let cellId = "ChipCell"
        
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
        
        public lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.text = self.text
                label.textColor = Ocean.color.colorBrandPrimaryDown
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
            }
        }()
        
        public var onValueChange: ((Bool, ChipChoice) -> Void)? = nil
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0
            stack.alignment = .center
            
            stack.add([
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
        
        private func setupUI() {
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.layer.masksToBounds = true
            self.layer.borderColor = Ocean.color.colorStatusNegativePure.cgColor

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)
            contentView.add(view: mainStack)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInSide))
            self.contentView.addGestureRecognizer(tapGesture)
            
            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
        
        private func updateUI() {
            self.label.text = self.text
            
            switch status {
            case .normal:
                self.setNormalState()
            case .selected:
                self.setSelectedState()
            case .disabled:
                self.setDisabledState()
            default:
                self.setNormalState()
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
