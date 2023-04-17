//
//  Ocean+BasicChip.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 17/04/23.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class BasicChip: UICollectionViewCell {
        static let cellId = "BasicChipCell"
        
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
        
        public var icon: UIImage? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var onValueChange: ((Bool, BasicChip) -> Void)? = nil
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.image = self.icon
            view.contentMode = .scaleAspectFit
            view.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorInterfaceLightPure
            return view
        }()
        
        private lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.text = self.text
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.textAlignment = .center
                label.sizeToFit()
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
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXxxs
            
            stack.add([
                imageView,
                label,
                badge
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
            
        }
        
        private func updateUI() {
            self.label.text = self.text
            updateUIBadge()
            updateUIStatus()
        }
        
        private func updateUIBadge() {
            if let numberValue = self.number {
                self.badge.number = numberValue
            }
            
            self.badge.isHidden = !(self.number == nil)
        }
        
        private func updateUIStatus() {
            switch status {
            case .normal:
                self.setNormalState()
            case .selected:
                self.setSelectedState()
            case .disabled:
                self.setDisabledState()
            }
        }

        private func setNormalState() {
            self.backgroundColor = Ocean.color.colorBrandPrimaryPure
//            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceLightPure
            
            // setar cor do badge
            self.badge.status = .primary
            
            // setar cor do icone
            self.imageView.tintColor = Ocean.color.colorInterfaceLightPure
        }

        private func setSelectedState() {
            self.backgroundColor = Ocean.color.colorBrandPrimaryDown
//            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceLightPure
            
            // setar cor do badge
            self.badge.status = .chipSelected
            
            // setar cor do icone
            self.imageView.tintColor = Ocean.color.colorInterfaceLightPure
        }

        private func setDisabledState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightDown
//            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceDarkUp
            
            // setar cor do badge
            self.badge.status = .disabled
            
            // setar cor do icone
            self.imageView.tintColor = Ocean.color.colorInterfaceDarkUp
        }
        
        @objc func didTapButton() {
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
