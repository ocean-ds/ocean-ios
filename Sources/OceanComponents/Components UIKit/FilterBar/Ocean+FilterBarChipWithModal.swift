//
//  Ocean+FilterBarChipWithModal.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 27/04/23.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    public class FilterBarChipWithModal: BaseFilterBarChip {

        public enum ModalTypeChoice {
            case multipleChoice
            case singleChoice
        }

        public var optionsModel: FilterBarOptionsModel = .empty() {
            didSet {
                updateUI()
            }
        }

        public weak var rootViewController: UIViewController?

        public var onCancel: (() -> Void)? = nil

        public var modalType: ModalTypeChoice = .singleChoice {
            didSet {
                updateUI()
            }
        }

        var onValueChange: (([Ocean.ChipModel]) -> Void)? = nil

        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXxxs
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                label,
                badge,
                imageView
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXxs)

            return stack
        }()

        private func setupUI() {
            type = .filterChip
            icon = Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate)
            addSubview(mainStack)
            configureApearence()
            addGestureRecognizer()
            setupConstraints()
        }

        override func setupConstraints() {
            super.setupConstraints()
            mainStack.oceanConstraints
                .fill(to: self)
                .make()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupSingleChoiceModal() {
            if let rootViewController = rootViewController {
                let modal = Ocean.ModalList(rootViewController)
                    .withTitle(optionsModel.modalTitle)
                    .withValues(getOptions(optionsModel: optionsModel))
                    .build()

                modal.onValueSelected = { [weak self] _, option in
                    guard let self = self else { return }

                    self.updateFilterOptionsModel(selectedItem: option)
                    self.text = option.title
                    self.updateFilterChipSingleChoice()
                    self.onValueChange?(self.optionsModel.options)
                }
                modal.show()
            }
        }

        private func setupMultipleChoiceModal() {
            if let rootViewController = rootViewController {
                Ocean.ModalMultipleChoice(rootViewController)
                    .withTitle(optionsModel.modalTitle)
                    .withDismiss(true)
                    .withMultipleOptions(getOptions(optionsModel: optionsModel))
                    .withAction(textNegative: optionsModel.secondaryButtonTitle, actionNegative: {
                        self.onCancel?()
                    }, textPositive: optionsModel.primaryButtonTitle, actionPositive: { [weak self] options in
                        guard let self = self else { return }

                        self.updateFilterOptionsModel(selectedItems: options)
                        self.configureBadge()
                        self.onValueChange?(self.optionsModel.options)
                    })
                    .build()
                    .show()
            }
        }

        private func configureBadge() {
            let selectedCount = optionsModel.options.filter { $0.isSelected }.count
            status = selectedCount > 0 ? .selected : .inactive
            number = selectedCount > 0 ? selectedCount : nil
        }

        @objc override func didTapButton() {
            super.didTapButton()
            updateFilterChip()
        }

        private func updateFilterChip() {
            switch modalType {
            case .multipleChoice:
                setupMultipleChoiceModal()
            case .singleChoice:
                setupSingleChoiceModal()
            }
        }

        private func updateFilterChipSingleChoice() {
            switch status {
            case .inactive, .normal:
                status = .selected
            default:
                break
            }
        }

        private func updateFilterOptionsModel(selectedItems: [CellModel]) {
            let originalModel = optionsModel

            optionsModel.options = originalModel.options.compactMap {
                var item = $0
                item.isSelected = selectedItems.contains(where: { item.title == $0.title && $0.isSelected })
                return item
            }
        }

        private func updateFilterOptionsModel(selectedItem: CellModel) {
            let originalModel = optionsModel

            optionsModel.options = originalModel.options.compactMap {
                var item = $0
                item.isSelected = item.title == selectedItem.title
                return item
            }
        }

        override func updateUI() {
            super.updateUI()
        }

        private func getOptions(optionsModel: FilterBarOptionsModel) -> [Ocean.CellModel] {
            var cellModels: [Ocean.CellModel] = []
            optionsModel.options.forEach { item in
                cellModels.append(CellModel(title: item.title,
                                            isSelected: item.isSelected))
            }

            return cellModels
        }
    }
}
