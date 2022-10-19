//
//  Ocean+CardListItem.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 18/10/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class CardListItem: UIView {
        struct Constants {
            static let minHeight: CGFloat = 96
            static let roundedViewHeightWidthLg: CGFloat = 40
            static let squareSizeLeadingIcon: CGFloat = 16
            static let squareSizeTrailingIcon: CGFloat = 14
        }
        
        public typealias CardListItemBuilder = ((CardListItem) -> Void)?
        
        public var title: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var caption: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var leadingIcon: UIImage? {
            didSet {
                updateUI()
            }
        }
        
        public var trailingIcon: UIImage? {
            didSet {
                updateUI()
            }
        }
        
        public var onTouch: (() -> Void)?
        
        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .center
                stack.distribution = .fill
                stack.ocean.radius.applyMd()
                stack.ocean.borderWidth.applyHairline()
                stack.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
                stack.addTapGesture(target: self, selector: #selector(handleOnTouch))

                stack.add([
                    roundedIconView,
                    leadingIconSpacer,
                    infoVerticalStack,
                    trailingIconSpacer,
                    trailingIconView
                ])
                
                stack.setConstraints((.height(Constants.minHeight), toView: nil))
                stack.setMargins(allMargins: Ocean.size.spacingStackXs)
            }
        }()
        
        private lazy var leadingIconSpacer = Ocean.Spacer(space: Ocean.size.spacingInsetSm)
        private lazy var trailingIconSpacer = Ocean.Spacer(space: Ocean.size.spacingInsetXs)
        
        private lazy var infoVerticalStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill

                stack.add([
                    titleLabel,
                    subtitleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingInsetXxs),
                    captionLabel
                ])
            }
        }()
        
        private lazy var roundedIconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidthLg / 2
            view.backgroundColor = Ocean.color.colorInterfaceLightUp
            view.addSubview(leadingIconView)

            NSLayoutConstraint.activate([
                leadingIconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                leadingIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                
            ])
            
            view.setConstraints((.squareSize(Constants.roundedViewHeightWidthLg), toView: nil))

            return view
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.numberOfLines = 0
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = 0
            }
        }()
        
        private lazy var captionLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
            }
        }()

        private lazy var leadingIconView: UIImageView = {
            let view = UIImageView()
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            
            view.setConstraints((.squareSize(Constants.squareSizeLeadingIcon), toView: nil))
            return view
        }()

        private lazy var trailingIconView: UIImageView = {
            let view = UIImageView()
            view.tintColor = Ocean.color.colorInterfaceDarkDown
            
            view.setConstraints((.squareSize(Constants.squareSizeTrailingIcon), toView: nil))
            return view
        }()
        
        public convenience init(builder: CardListItemBuilder = nil) {
            self.init()
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.add(view: mainStack)
            mainStack.setConstraints((.marginEqual(0), toView: superview))
        }

        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.isSkeletonable = !subtitle.isEmpty
            captionLabel.text = caption
            captionLabel.isHidden = caption.isEmpty
            captionLabel.isSkeletonable = !caption.isEmpty
            leadingIconView.image = leadingIcon?.withRenderingMode(.alwaysTemplate)
            trailingIconView.image = trailingIcon?.withRenderingMode(.alwaysTemplate)
            leadingIconSpacer.isHidden = leadingIcon == nil
            roundedIconView.isHidden = leadingIcon == nil
            trailingIconView.isHidden = trailingIcon == nil
            trailingIconSpacer.isHidden = trailingIcon == nil
        }
        
        @objc func handleOnTouch() {
            self.onTouch?()
        }
    }
}
