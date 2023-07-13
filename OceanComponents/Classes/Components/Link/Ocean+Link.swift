//
//  Ocean+Link.swift
//  Charts
//
//  Created by Acassio Mendonça on 13/07/23.
//

import Foundation
import OceanTokens

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
        
        private lazy var linkContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubviews(linkTitleLabel, linkIconImageView)
            view.addTapGesture(target: self, selector: #selector(onLinkTouch))
            
            return view
        }()
        
        public override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            addSubviews(linkContainer)
            setupConstraints()
        }
        
        private func setupConstraints() {
            linkContainer.oceanConstraints
                .fill(to: self)
                .make()
            
            linkTitleLabel.oceanConstraints
                .topToTop(to: linkContainer)
                .bottomToBottom(to: linkContainer)
                .leadingToLeading(to: linkContainer)
                .make()
            
            linkIconImageView.oceanConstraints
                .centerY(to: linkContainer)
                .leadingToTrailing(to: linkTitleLabel)
                .trailingToTrailing(to: linkContainer)
                .width(constant: 16)
                .height(constant: 16)
                .make()
        }
        
        private func updateUI() {
            let size = size == .medium ? Ocean.font.fontSizeXs : Ocean.font.fontSizeXxs
            
            if let attributedTitle = attributedTitle {
                linkTitleLabel.attributedText = attributedTitle
            } else if let title = title {
                linkTitleLabel.attributedText = "<u>\(title)</u>".htmlToAttributedText(
                    size: size,
                    color: Ocean.color.colorBrandPrimaryPure
                )
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
            linkIconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        }
        
        @objc
        private func onLinkTouch() {
            onTouch()
        }
    }
}
