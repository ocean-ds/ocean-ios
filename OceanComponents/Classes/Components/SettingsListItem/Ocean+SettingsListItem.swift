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
        case base
        case pending
        case activated
        case blockedActivate
        case blocked
    }
    
    public class SettingsListItem: UIView {
        public var type: SettingListStatus = .base {
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
        
        public var actionText: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var onTouchButton: (() -> Void)? {
            didSet {
                updateUI()
            }
        }
        
        lazy var titleLabel: UILabel = {
            Ocean.Typography.description { _ in }
        }()
        
        lazy var subtitleLabel: UILabel = {
            Ocean.Typography.paragraph { _ in }
        }()
        
        lazy var captionLabel: UILabel = {
            Ocean.Typography.caption { _ in }
        }()
        
        lazy var warningTag: Ocean.Tag = {
            Ocean.Tag { view in
                view.status = .warning
            }
        }()
        
        lazy var buttonPrimary: Ocean.ButtonPrimary = {
            Ocean.Button.primarySM { _ in }
        }()
        
        lazy var buttonSecundary: Ocean.ButtonSecondary = {
            Ocean.Button.secondarySM { _ in }
        }()
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = Ocean.icon.lockClosedSolid?.withRenderingMode(.alwaysTemplate)
            view.tintColor = Ocean.color.colorInterfaceDarkUp
            
            return view
        }()
        
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
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    captionLabel
                ])
            }
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    infoStack,
                    buttonPrimary,
                    buttonSecundary,
                    imageView,
                    warningTag,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
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
            warningTag.title = actionText
            buttonPrimary.text = actionText
            buttonPrimary.onTouch = onTouchButton
            buttonSecundary.text = actionText
            buttonSecundary.onTouch = onTouchButton
            
            switch type {
            case .pending:
                isPending()
            case .activated:
                isActivated()
            case .blockedActivate:
                isBlockedActivated()
            case .blocked:
                isBlocked()
            default:
                isDefault()
            }
        }
        
        private func isDefault() {
            buttonPrimary.isHidden = false
            buttonSecundary.isHidden = true
            imageView.isHidden = true
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func isPending() {
            buttonPrimary.isHidden = true
            buttonSecundary.isHidden = true
            imageView.isHidden = true
            warningTag.isHidden = false
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func isActivated() {
            buttonPrimary.isHidden = true
            buttonSecundary.isHidden = false
            imageView.isHidden = true
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkDown
        }
        
        private func isBlockedActivated() {
            buttonPrimary.isHidden = true
            buttonSecundary.isHidden = true
            imageView.isHidden = false
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func isBlocked() {
            buttonPrimary.isHidden = true
            buttonSecundary.isHidden = true
            imageView.isHidden = false
            warningTag.isHidden = true
            subtitleLabel.textColor = Ocean.color.colorInterfaceDarkDown
        }
    }
}
