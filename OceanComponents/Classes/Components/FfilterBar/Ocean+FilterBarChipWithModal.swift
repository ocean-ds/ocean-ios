//
//  Ocean+FilterBarChipWithModal.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 27/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    
    public class FilterBarChipWithModal: BaseFilterBarChip {
        
        public var filterOptionsModel: FilterOptionsModel? = nil {
            didSet {
                updateUI()
            }
        }
        
        public weak var rootViewController: UIViewController?
        
        public var onValuesChange: ((FilterBarChipWithModal, [Ocean.CellModel]) -> Void)? = nil
        
        public var onCancel: (() -> Void)? = nil
        
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
            configureAparence()
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

        private func setupFilterOptions() {
            if let rootViewController = rootViewController,
               let filterOptionsModel = filterOptionsModel {
                Ocean.ModalMultiChoice(rootViewController)
                    .withTitle(filterOptionsModel.modalTitle)
                    .withDismiss(true)
                    .withMultipleOptions(setupOptionsCheckBox())
                    .withAction(textNegative: filterOptionsModel.secondaryButtonTitle, actionNegative: {
                        self.onCancel?()
                    }, textPositive: filterOptionsModel.primaryButtonTitle, actionPositive: { selectedOption in
                        self.configureBadge(options: selectedOption)
                        self.updateCellModel(options: selectedOption)
                        self.onValuesChange?(self, selectedOption)
                    })
                    .build()
                    .show()
            }
        }
        
        private func configureBadge(options: [Ocean.CellModel]) {
            let selectedCount = options.filter { $0.isSelected }.count
            status = selectedCount > 0 ? .selected : .inactive
            number = selectedCount > 0 ? selectedCount : nil
        }
        
        private func setupOptionsCheckBox() -> [Ocean.CellModel] {
            if let filterOptionsModel = filterOptionsModel {
                return filterOptionsModel.multipleChoiceOptions.map { option in
                    Ocean.CellModel(title: option.title, isSelected: option.isSelected)
                }
            }
            return []
        }
        
        @objc override func didTapButton() {
            super.didTapButton()
            updateFilterChip()
        }
        
        private func updateFilterChip() {
            switch status {
            case .inactive, .normal, .selected:
                setupFilterOptions()
            default:
                break
            }
        }
        
        private func updateCellModel(options: [Ocean.CellModel]) {
            filterOptionsModel?.multipleChoiceOptions = options
        }
        
        override func updateUI() {
            super.updateUI()
        }
    }
}
