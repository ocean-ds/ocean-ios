//
//  Ocean+transectionFooter.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 26/07/22.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class TransactionFooterView: UIView {

        public var buttonTitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var transactionsItens: [TransactionFooterItemView] = [] {
            didSet {
                updateUI()
            }
        }

        lazy var button: Ocean.ButtonPrimary = {
            Ocean.Button.primaryBlockedMD { button in
                button.text = ""
            }
        }()

        lazy var buttonView: UIView = {
            let view = UIView()
            view.add(view: button)
            return view
        }()

        private func stackTransactionItems() -> Ocean.StackView {
            let stack = Ocean.StackView()

            transactionsItens.forEach { item in
                stack.add([item,
                           Ocean.Spacer(space: Ocean.size.spacingStackXxxs)])
            }

            return stack
        }

        lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = 0
            stack.axis = .vertical
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                stackTransactionItems(),
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                buttonView
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
            add(view: contentStack)
        }

        private func updateUI() {
            self.button.text = buttonTitle
        }
    }
}
