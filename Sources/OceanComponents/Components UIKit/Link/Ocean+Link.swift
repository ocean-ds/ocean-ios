//
//  Ocean+Link.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 13/07/23.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {

    public class Link: UIView {

        public enum Size {
            case medium, small
        }

        public enum IconType {
            case none, chevron, external
        }

        public var title: String? {
            didSet {
                updateUI()
            }
        }

        public var size: Size? = .medium {
            didSet {
                updateUI()
            }
        }

        public var attributedTitle: NSAttributedString? {
            didSet {
                updateUI()
            }
        }

        public var iconType: IconType = .none {
            didSet {
                updateUI()
            }
        }

        public var onTouch: (() -> Void) = {  }

        private lazy var linkTitleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorBrandPrimaryPure
            }
        }()

        private lazy var linkIconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = Ocean.color.colorBrandPrimaryPure

            return imageView
        }()

        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            stack.spacing = Ocean.size.spacingStackXxs

            stack.add([
                linkTitleLabel,
                linkIconImageView
            ])

            stack.addTapGesture(target: self, selector: #selector(onLinkTouch))

            return stack
        }()

        public override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            addSubviews(mainStack)
            setupConstraints()
        }

        private func setupConstraints() {
            mainStack.oceanConstraints
                .fill(to: self)
                .make()

            linkIconImageView.oceanConstraints
                .leadingToTrailing(to: linkTitleLabel, constant: Ocean.size.spacingStackXxs)
                .width(constant: Ocean.size.spacingStackXs)
                .height(constant: Ocean.size.spacingStackXs)
                .make()
        }

        private func updateUI() {
            let size = size == .medium ? Ocean.font.fontSizeXs : Ocean.font.fontSizeXxs

            linkTitleLabel.font = .baseSemiBold(size: size)

            if let attributedTitle = attributedTitle {
                linkTitleLabel.attributedText = attributedTitle
            } else if let title = title {
                linkTitleLabel.underlineText(fullText: title,
                                             underlinedText: title,
                                             underlinedTextColor: Ocean.color.colorBrandPrimaryPure)
            }
            changeIcon()
        }

        private func changeIcon() {
            let icon: UIImage?
            switch iconType {
            case .chevron:
                icon = Ocean.icon.chevronRightSolid
            case .external:
                icon = Ocean.icon.externalLinkSolid
            case .none:
                icon = nil
            }
            linkIconImageView.isHidden = icon == nil
            linkIconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        }

        @objc
        private func onLinkTouch() {
            onTouch()
        }
    }
}
