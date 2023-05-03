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
        
        public enum ModalTypeChoice {
            case multipleChoice
            case singleChoice
        }
        
        public var filterOptionsModel: FilterBarOptionsModel? = nil {
            didSet {
                updateUI()
            }
        }
        
        public weak var rootViewController: UIViewController?
  
        public var onValuesChange: ((FilterBarChipWithModal, [Ocean.ChipModel]) -> Void)? = nil
        
        public var onCancel: (() -> Void)? = nil
        
        public var modalType: ModalTypeChoice = .multipleChoice {
            didSet {
                updateUI()
            }
        }
        
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
        
        private func setupSingleChoiceModal() {
            if let rootViewController = rootViewController,
               let filterOptionsModel = filterOptionsModel {
                let modal = Ocean.ModalList(rootViewController)
                    .withTitle(filterOptionsModel.modalTitle)
                    .withValues(getMultipleOptions())
                    .build()

                modal.onValueSelected = { [weak self] _, value in
                    guard let self = self else { return }
                    
                    var chipModel = self.translate(to: value)
                    chipModel.isSelected = true
                    
                    self.onValuesChange?(self, [chipModel])
                    self.text = value.title
                    self.updateFilterChipSingleChoice()
                }
                modal.show()
            }
        }
        
        private func setupMultipleChoiceModal() {
            if let rootViewController = rootViewController,
               let filterOptionsModel = filterOptionsModel {
                Ocean.ModalMultiChoice(rootViewController)
                    .withTitle(filterOptionsModel.modalTitle)
                    .withDismiss(true)
                    .withMultipleOptions(getMultipleOptions())
                    .withAction(textNegative: filterOptionsModel.secondaryButtonTitle, actionNegative: {
                        self.onCancel?()
                    }, textPositive: filterOptionsModel.primaryButtonTitle, actionPositive: { [weak self] selectedOptions in
                        guard let self = self else { return }
                        
                        let chipModels = selectedOptions.map {
                            self.translate(to: $0)
                        }
                        
                        self.updateCellModel(options: chipModels)
                        self.configureBadge(options: chipModels)
                        self.onValuesChange?(self, chipModels)
                    })
                    .build()
                    .show()
            }
        }
        
        private func configureBadge(options: [Ocean.ChipModel]) {
            let selectedCount = options.filter { $0.isSelected ?? false }.count
            status = selectedCount > 0 ? .selected : .inactive
            number = selectedCount > 0 ? selectedCount : nil
        }
        
        private func getMultipleOptions() -> [Ocean.CellModel] {
            if let filterOptionsModel = filterOptionsModel {
                return filterOptionsModel.multipleChoiceOptions.map { option in
                    translate(to: option)
                }
            }
            return []
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
        
        private func updateCellModel(options: [Ocean.ChipModel]) {
            filterOptionsModel?.multipleChoiceOptions = options
        }
        
        override func updateUI() {
            super.updateUI()
        }
        
        private func translate(to cellModel: CellModel) -> ChipModel {
            return ChipModel(title: cellModel.title,
                             isSelected: cellModel.isSelected)
        }
        
        private func translate(to chipModel: ChipModel) -> CellModel {
            return CellModel(title: chipModel.title,
                             isSelected: chipModel.isSelected ?? false)
        }
    }
}
