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
        
        public var icon: UIImage? = Ocean.icon.zoomOutOutline?.withRenderingMode(.alwaysTemplate) {
            didSet {
                updateUI()
            }
        }
        
        public var onValueChange: ((Bool, BasicChip) -> Void)? = nil
        
        internal lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = self.icon
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        internal lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.text = self.text
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.textAlignment = .center
                label.sizeToFit()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        internal lazy var badge: Ocean.BadgeNumber = {
            Ocean.Badge.number { view in
                view.size = .small
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        internal lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXxxs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                imageView,
                label,
                badge
            ])
            
            stack.setMargins(top: Ocean.size.spacingStackXxs + 1,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs + 1,
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
        
        private func configureAparence() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.layer.masksToBounds = true
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderColor = Ocean.color.colorStatusNegativePure.cgColor
            self.layer.borderWidth = 0
        }
        
        private func addGestureRecognizer() {
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(self.didTapButton))
            self.addGestureRecognizer(tapGesture)
        }
        
        @objc func didTapButton() {
            switch status {
            case .inactive, .normal:
                self.status = .selected
                onValueChange?(true, self)
            case .selected:
                if self.allowDeselect {
                    self.status = .inactive
                    onValueChange?(false, self)
                }
            default:
                break
            }
        }
        
        private func addSubviews() {
            contentView.addSubview(mainStack)
            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)
        }
        
        private func setupConstraints() {
            imageView.oceanConstraints
                .width(constant: 16)
                .height(constant: 16)
                .make()
            
            mainStack.oceanConstraints
                .fill(to: contentView)
                .make()
        }
        
        private func setupUI() {
            configureAparence()
            addGestureRecognizer()
            addSubviews()
            setupConstraints()
        }
        
        private func updateUI() {
            self.label.text = self.text
            
            updateUIWithStatus()
            updateUIWithImageView()
            updateUIWithBadge()
        }
        
        private func updateUIWithStatus() {
            switch status {
            case .normal, .inactive:
                self.setNormalState()
            case .selected:
                self.setSelectedState()
            case .disabled:
                self.setDisabledState()
            }
        }
        
        private func updateUIWithImageView() {
            if let icon = self.icon {
                self.imageView.image = icon
            }

            self.imageView.isHidden = self.icon == nil
        }
        
        private func updateUIWithBadge() {
            if let numberValue = self.number {
                self.badge.number = numberValue
            }

            self.badge.isHidden = self.number == nil
        }
        
        private func setNormalState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.label.textColor = Ocean.color.colorBrandPrimaryPure
            self.badge.status = .primary
            self.imageView.tintColor = Ocean.color.colorBrandPrimaryPure
        }

        private func setSelectedState() {
            self.backgroundColor = Ocean.color.colorBrandPrimaryPure
            self.label.textColor = Ocean.color.colorInterfaceLightPure
            self.badge.status = .primaryInverted
            self.imageView.tintColor = Ocean.color.colorInterfaceLightPure
        }

        private func setDisabledState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightDown
            self.label.textColor = Ocean.color.colorInterfaceDarkUp
            self.badge.status = .disabled
            self.imageView.tintColor = Ocean.color.colorInterfaceDarkUp
        }
    }
}
