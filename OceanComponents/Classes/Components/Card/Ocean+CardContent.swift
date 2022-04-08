//
//  Ocean+CardContent.swift
//  OceanComponents
//
//  Created by Vini on 08/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class CardContent: Card {
        public typealias CardContentBuilder = (CardContent) -> Void
        
        public var onTouch: (() -> Void)?
        
        struct Constants {
            static let imageSize: CGFloat = 24
            static let arrowSize: CGFloat = 20
        }
        
        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }
        
        public var title: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var badgeStatus: BadgeNumber.Status = .alert {
            didSet {
                updateUI()
            }
        }
        
        public var badgeNumber: Int = 0 {
            didSet {
                updateUI()
            }
        }
        
        public var actionTitle: String = "" {
            didSet {
                updateUI()
            }
        }
        
        private lazy var imageView: UIImageView = {
            UIImageView { view in
                view.contentMode = .scaleAspectFit
                view.tintColor = Ocean.color.colorInterfaceDarkDeep
                view.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: Constants.imageSize),
                    view.heightAnchor.constraint(equalToConstant: Constants.imageSize)
                ])
            }
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.text = ""
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var badgeView = Ocean.Badge.number()
        
        private lazy var topStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                imageView,
                titleLabel,
                badgeView
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private lazy var topDivider = Ocean.Divider(widthConstraint: self.widthAnchor)
        
        private lazy var actionTitleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.text = ""
                label.textColor = Ocean.color.colorBrandPrimaryPure
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var arrowView: UIImageView = {
            UIImageView { view in
                view.contentMode = .scaleAspectFit
                view.image = Ocean.icon.chevronRightSolid?.withRenderingMode(.alwaysTemplate)
                view.tintColor = Ocean.color.colorBrandPrimaryPure
                view.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: Constants.arrowSize),
                    view.heightAnchor.constraint(equalToConstant: Constants.arrowSize)
                ])
            }
        }()
        
        private lazy var bottomStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                actionTitleLabel,
                arrowView
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private lazy var bottomView: UIView = {
            let view = UIView()
            view.ocean.radius.applyMd()
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            view.add(view: bottomStack)
            
            view.isUserInteractionEnabled = true
            view.addTapGesture(target: self, selector: #selector(tapped(sender:)))
            view.addLongPressGesture(target: self, selector: #selector(longPressed(sender:)))
            
            return view
        }()
        
        private lazy var bottomDivider = Ocean.Divider(widthConstraint: self.widthAnchor)
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                topStack,
                topDivider,
                self.view,
                bottomDivider,
                bottomView
            ])
            
            return stack
        }()
        
        public convenience init(builder: CardContentBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        override func setupUI() {
            withShadow = true
            super.setupUI()
            self.add(view: mainStack)
        }
        
        override func updateView() {
            
        }
        
        private func updateUI() {
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = image == nil
            titleLabel.text = title
            badgeView.status = badgeStatus
            badgeView.number = badgeNumber
            badgeView.isHidden = badgeNumber == 0
            actionTitleLabel.text = actionTitle
            bottomView.isHidden = actionTitle.isEmpty
            bottomDivider.isHidden = actionTitle.isEmpty
        }
        
        @objc func tapped(sender: UITapGestureRecognizer){
            bottomView.backgroundColor = .clear
            onTouch?()
        }

        @objc func longPressed(sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                bottomView.backgroundColor = Ocean.color.colorInterfaceLightDeep
            } else if sender.state == .ended {
                bottomView.backgroundColor = .clear
                onTouch?()
            }
        }
    }
}
