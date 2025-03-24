//
//  Ocean+BalanceWithoutValueCell.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 22/06/23.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    public class BalanceWithoutValueCell: UICollectionViewCell {
        static let identifier = "BalanceWithoutValueCellIdentifier"
        
        public var onStateChanged: ((BalanceState) -> Void)?

        public var model: BalanceModel = .empty() {
            didSet {
                updateUI()
            }
        }

        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorBrandPrimaryUp
            }
        }()

        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceLightDown
                label.numberOfLines = 2
                label.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
        }()

        private lazy var footerButton: Ocean.ButtonSecondary = {
            Ocean.Button.secondarySM { button in
                button.isBlocked = false
                button.onTouch = { self.model.action?() }
            }
        }()

        private lazy var contentContainerView: UIView = {
            let view = UIView()
            view.isSkeletonable = true
            view.addSubviews(titleLabel, descriptionLabel, footerButton)
            titleLabel.oceanConstraints
                .topToTop(to: view)
                .leadingToLeading(to: view)
                .trailingToTrailing(to: view)
                .make()

            descriptionLabel.oceanConstraints
                .topToBottom(to: titleLabel, constant: Ocean.size.spacingStackXxxs)
                .leadingToLeading(to: view)
                .trailingToTrailing(to: view)
                .make()

            footerButton.oceanConstraints
                .leadingToLeading(to: view)
                .bottomToBottom(to: view)
                .make()

            return view
        }()

        private lazy var contentContainer: UIView = {
            let view = UIView()
            view.backgroundColor = Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)
            view.clipsToBounds = true
            view.ocean.radius.applyMd()
            view.isSkeletonable = true
            
            self.skeletonCornerRadius = Float(view.layer.cornerRadius)
            return view
        }()

        private lazy var mainView: UIView = {
            let view = UIView()
            view.isSkeletonable = true

            return view
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            self.backgroundColor = .clear

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.contentView.addSubviews(mainView)
            mainView.addSubview(contentContainer)
            contentContainer.addSubview(contentContainerView)
        }

        private func setupConstraints() {
            mainView.oceanConstraints
                .fill(to: contentView)
                .make()
            
            contentContainer.oceanConstraints
                .topToTop(to: mainView)
                .leadingToLeading(to: mainView)
                .trailingToTrailing(to: mainView)
                .height(constant: 130, type: .greaterThanOrEqualTo)
                .make()
            
            contentContainerView.oceanConstraints
                .fill(to: contentContainer, constant: Ocean.size.spacingStackXs)
                .make()
        }

        private func updateUI() {
            self.titleLabel.text = model.title
            self.descriptionLabel.text = model.description
            self.footerButton.text = model.actionCTA
        }
    }
}
