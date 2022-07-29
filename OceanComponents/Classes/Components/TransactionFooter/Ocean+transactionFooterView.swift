//
//  Ocean+transectionFooter.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 26/07/22.
//

import OceanTokens

extension Ocean {
    public class TransactionFooterView: UIView {
        struct Constaint {
            static let height: CGFloat = 90
            static let heightItem: CGFloat = 30
        }

        public var buttonTitle: String = "" {
            didSet {
                updateUI()
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
            stack.distribution = .fill
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
            contentStack.setConstraints((.fillSuperView, toView: self))
            heightConstraint.isActive = true
        }

        private func updateUI() {
            self.nextButton.text = buttonTitle
            transactionItemsStack.removeAllArrangedSubviews()
            setupTransactionItems()
            heightConstraint.constant = Constaint.height + (CGFloat(transactionsItems.count) * Constaint.heightItem)
        }

        fileprivate func setupTransactionItems() {
            transactionsItems.forEach { item in
                let transactionItem = TransactionFooterItemView()
                if let title = item.title {
                    transactionItem.title = title
                }
                if let subtitle = item.subtitleTextLabel {
                    transactionItem.subtitleTextLabel = subtitle
                }
                if let tooltipMessage = item.tooltipMessage {
                    transactionItem.tooltipMessage = tooltipMessage
                }

                transactionItemsStack.addArrangedSubview(transactionItem)
            }
        }
    }
}
