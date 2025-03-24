//
//  Ocean+SettingsListItem.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 31/01/23.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    
    public enum SettingListStatus: String {
        case inactivePrimary
        case inactiveSecondary
        case pending
        case activated
        case blocked
        case blockedInactive
    }
    
    public class SettingsListItem: UIView {
        public var type: SettingListStatus = .inactivePrimary {
            didSet {
                updateUI()
            }
        }
        
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
        
        public var errorMessageText: String = ""{
            didSet {
                updateUI()
            }
        }
        
        public var actionText: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var hasDivider: Bool = true {
            didSet {
                updateUI()
            }
        }
        
        public var onTouchButton: (() -> Void)?
        
        lazy var titleLabel = Ocean.Typography.description()
        
        lazy var subtitleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.numberOfLines = 0
            }
        }()
        
        lazy var captionLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
            }
        }()
        
        lazy var errorMessageLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorStatusNegativePure
                label.isHidden = true
            }
        }()
        
        lazy var warningTag: Ocean.Tag = {
            Ocean.Tag { view in
                view.status = .warning
            }
        }()
        
        lazy var buttonPrimary: Ocean.ButtonPrimary = {
            Ocean.Button.primarySM { button in
                button.onTouch = { self.onTouchButton?() }
            }
        }()
        
        lazy var buttonSecondary: Ocean.ButtonSecondary = {
            Ocean.Button.secondarySM { button in
                button.onTouch = { self.onTouchButton?() }
            }
        }()
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = Ocean.icon.lockClosedSolid?.withRenderingMode(.alwaysTemplate)
            view.tintColor = Ocean.color.colorInterfaceDarkUp
            
            return view
        }()
        
        private lazy var divider = Ocean.Divider()
        
        private lazy var captionSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
        
        private lazy var errorMessageSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
        
        private lazy var infoStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading
                
                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    titleLabel,
                    subtitleLabel,
                    captionSpacer,
                    captionLabel,
                    errorMessageSpacer,
                    errorMessageLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    infoStack,
                    buttonPrimary,
                    buttonSecondary,
                    imageView,
                    warningTag,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill
                
                stack.add([
                    contentStack,
                    divider
                ])
            }
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            add(view: mainStack)
        }
        
        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            captionLabel.text = caption
            captionLabel.isHidden = caption.isEmpty
            captionSpacer.isHidden = caption.isEmpty
            errorMessageLabel.text = errorMessageText
            errorMessageLabel.isHidden = errorMessageText.isEmpty
            errorMessageSpacer.isHidden = errorMessageText.isEmpty
            warningTag.title = actionText
            buttonPrimary.text = actionText
            buttonSecondary.text = actionText
            divider.isHidden = !hasDivider
            
            switch type {
            case .inactivePrimary:
                isInactivePrimary()
            case .inactiveSecondary:
                isInactiveSecondary()
            case .pending:
                isPending()
            case .activated:
                isActivated()
            case .blocked:
                isBlocked()
            case .blockedInactive:
                isBlockedInactive()
            }
        }
        
        public func setSkeleton() {
            self.isSkeletonable = true
            self.infoStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            
            titleLabel.isSkeletonable = true
            subtitleLabel.isSkeletonable = true
            captionLabel.isSkeletonable = true
            errorMessageLabel.isSkeletonable = true
            buttonPrimary.isSkeletonable = true
            buttonSecondary.isSkeletonable = true
            warningTag.setSkeleton()
        }
        
        private func isInactivePrimary() {
            buttonPrimary.isHidden = false
            buttonSecondary.isHidden = true
            imageView.isHidden = true
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func isInactiveSecondary() {
            buttonPrimary.isHidden = true
            buttonSecondary.isHidden = false
            imageView.isHidden = true
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func isPending() {
            buttonPrimary.isHidden = true
            buttonSecondary.isHidden = true
            imageView.isHidden = true
            warningTag.isHidden = false
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func isActivated() {
            buttonPrimary.isHidden = true
            buttonSecondary.isHidden = false
            imageView.isHidden = true
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkPure
        }
        
        private func isBlocked() {
            buttonPrimary.isHidden = true
            buttonSecondary.isHidden = true
            imageView.isHidden = false
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkPure
        }
        
        private func isBlockedInactive() {
            buttonPrimary.isHidden = true
            buttonSecondary.isHidden = true
            imageView.isHidden = false
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
    }
}
