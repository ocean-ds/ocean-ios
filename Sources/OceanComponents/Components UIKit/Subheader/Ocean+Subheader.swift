//
//  Ocean+Subheader.swift
//  OceanComponents
//
//  Created by Vini on 13/09/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class Subheader: UIView {
        struct Constants {
            static let heightMd: CGFloat = 40
            static let heightSm: CGFloat = 32
            static let iconSize: CGFloat = 16
        }
        
        public typealias SubheaderBuilder = (Subheader) -> Void
        
        public enum Size {
            case medium
            case small
        }
        
        public var size: Size = .medium {
            didSet {
                if size == .medium {
                    heightConstraint.constant = Constants.heightMd
                } else {
                    heightConstraint.constant = Constants.heightSm
                }
            }
        }
        
        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }
        
        public var title: String = ""{
            didSet {
                updateUI()
            }
        }
        
        public var titleAttributedString: NSAttributedString? {
            didSet {
                updateUI()
            }
        }
        
        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var subtitleAttributedString: NSAttributedString? {
            didSet {
                updateUI()
            }
        }
        
        private lazy var heightConstraint: NSLayoutConstraint = {
            return self.heightAnchor.constraint(equalToConstant: Constants.heightMd)
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    iconImageView,
                    iconSpacer,
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    subtitleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()
        
        private lazy var iconImageView: UIImageView = {
            UIImageView { view in
                view.contentMode = .scaleAspectFit
                view.tintColor = Ocean.color.colorInterfaceDarkUp
                view.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: Constants.iconSize),
                    view.heightAnchor.constraint(equalToConstant: Constants.iconSize)
                ])
            }
        }()
        
        private lazy var iconSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
        
        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
                label.textAlignment = .left
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var subtitleLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
                label.textAlignment = .right
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        public convenience init(builder: SubheaderBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            backgroundColor = Ocean.color.colorInterfaceLightUp
            isSkeletonable = true
            addSubview(mainStack)
            
            NSLayoutConstraint.activate([
                mainStack.topAnchor.constraint(equalTo: topAnchor),
                mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
                mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                mainStack.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            
            heightConstraint.isActive = true
        }
        
        private func updateUI() {
            iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
            iconImageView.isHidden = image == nil
            iconSpacer.isHidden = image == nil
            titleLabel.text = title
            if let titleAttributedString = self.titleAttributedString {
                titleLabel.attributedText = titleAttributedString
            }
            subtitleLabel.text = subtitle
            if let subtitleAttributedString = self.subtitleAttributedString {
                subtitleLabel.attributedText = subtitleAttributedString
            }
            subtitleLabel.isHidden = subtitle.isEmpty && subtitleAttributedString == nil
        }
    }
}
