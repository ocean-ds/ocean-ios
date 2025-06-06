//
//  Ocean+TransactionFooter.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 26/07/22.
//

import OceanTokens
import CoreGraphics
import UIKit

extension Ocean {
    public class TransactionFooterView: UIView {
        struct Constaint {
            static let height: CGFloat = 96
            static let spacingHeightItem: CGFloat = 4
            static let heightItem: CGFloat = 24
        }

        public var buttonTitle: String = "" {
            didSet {
                self.nextButton.text = buttonTitle
            }
        }

        public var onTouch: (() -> Void)? {
            didSet {
                self.nextButton.onTouch = onTouch
            }
        }

        public var transactionsItems: [TransactionItemModel] = [] {
            didSet {
                updateUI()
            }
        }

        public lazy var heightConstraint: NSLayoutConstraint = {
            self.heightAnchor.constraint(equalToConstant: Constaint.height)
        }()

        private lazy var nextButton: Ocean.ButtonPrimary = {
            Ocean.Button.primaryMD { button in
                button.text = ""
            }
        }()

        private lazy var transactionItemsStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = Ocean.size.spacingStackXxxs
            stack.alignment = .fill
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.translatesAutoresizingMaskIntoConstraints = false

            return stack
        }()

        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = Ocean.size.spacingStackXs
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                transactionItemsStack,
                nextButton
            ])

            stack.setMargins(top: Ocean.size.spacingStackXs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXs,
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

        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.addSubview(contentStack)

            contentStack.oceanConstraints
                .fill(to: self)
                .make()

            heightConstraint.isActive = true
        }

        private func updateUI() {
            setupTransactionItems()
            heightConstraint.constant = Constaint.height + (CGFloat(transactionsItems.count) * Constaint.heightItem) +
                                                           (CGFloat((transactionsItems.count - 1)) * Constaint.spacingHeightItem)
        }

        fileprivate func setupTransactionItems() {
            transactionItemsStack.removeAllArrangedSubviews()

            transactionsItems.forEach { item in
                let transactionItem = TransactionFooterItemView()
                transactionItem.title = item.title
                transactionItem.subtitleTextLabel = item.subtitleTextLabel
                transactionItem.tooltipMessage = item.tooltipMessage
                transactionItemsStack.addArrangedSubview(transactionItem)
            }
        }
    }
}
