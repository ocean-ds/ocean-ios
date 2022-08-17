//
//  Ocean+GroupCTA.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 17/08/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class GroupCTA: UIView {
        struct Constants {
            static let height: CGFloat = 48
        }

        public var text: String = "" {
            didSet {
                updateUI()
            }
        }

        public var icon: UIImage? = Ocean.icon.chevronRightSolid {
            didSet {
                updateUI()
            }
        }

        public var isLoading: Bool = false {
            didSet {
                if isLoading {
                    startActivityIndicator()
                } else {
                    stopActivityIndicator()
                }
            }
        }

        public var onTouch: (() -> Void)?

        private lazy var textButton: Ocean.ButtonText = {
            Ocean.ButtonText { button in
                button.size = .small
                button.paddingLeft = Ocean.size.spacingStackXs
                button.paddingRight = Ocean.size.spacingStackXxs
                button.text = text
                button.rightIcon = icon?.withRenderingMode(.alwaysTemplate)
                button.isRounded = false
                button.onTouch = {
                    self.onTouch?()
                }
            }
        }()

        private lazy var spinner: Ocean.CircularProgressIndicator = {
            let view = Ocean.CircularProgressIndicator()
            view.style = .primary
            view.isHidden = true
            return view
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.addSubviews(textButton, spinner)
            textButton.setConstraints((.fillSuperView, toView: self))
            spinner.setConstraints(([.centerVertically,
                                     .centerHorizontally], toView: self))
            self.setConstraints((.height(Constants.height), toView: nil))
        }

        private func updateUI() {
            textButton.text = text
            textButton.rightIcon = icon
        }

        private func stopActivityIndicator() {
            self.isUserInteractionEnabled = true
            self.textButton.alpha = 1
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }

        private func startActivityIndicator() {
            self.isUserInteractionEnabled = false
            self.textButton.alpha = 0
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }
}
