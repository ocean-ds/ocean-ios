//
//  ChartCardGroup.swift
//  Charts
//
//  Created by Acassio Mendonça on 18/09/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class CheckBoxGroup: UIView {
        private lazy var selectAllCheckBox: Ocean.CheckBox = {
            let checkBox = Ocean.CheckBox()
            checkBox.onTouch = { [weak self] in
                guard let self = self else { return }
                self.onTouchSelectAll()
                self.model.onChange(model.checkboxes)
            }
            
            return checkBox
        }()
        
        private var model: CheckboxesModel
        
        private var allSelected: Bool = false

        private lazy var groupCheckBoxStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            stack.spacing = Ocean.size.spacingStackXs
             
            return stack
        }()

        public init(frame: CGRect = .zero, model: CheckboxesModel) {
            self.model = model
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            addSubviews(groupCheckBoxStack)
            setupLayout()
            setupListCheckBox()
            setupContraints()
            layoutIfNeeded()
        }
        
        private func setupLayout() {
            backgroundColor = .white
            layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            ocean.radius.applyMd()
            ocean.borderWidth.applyHairline()
        }
        
        private func setupListCheckBox() {
            groupCheckBoxStack.removeAllArrangedSubviews()
            
            selectAllCheckBox.text = model.selectAllLabel
            
            groupCheckBoxStack.add([selectAllCheckBox.addMargins(horizontal: Ocean.size.spacingStackXs),
                                    Ocean.Divider(widthConstraint: widthAnchor)])
            
            for (index, item) in model.checkboxes.enumerated() {
                let checkBox = Ocean.CheckBox()
                checkBox.id = index
                checkBox.text = item.title
                checkBox.descriptionText = item.subtitle
                checkBox.isSelected = item.isSelected
                checkBox.onTouch = { [weak self] in
                    guard let self = self else { return }
                    self.updateUI(checkBox)
                    self.model.onChange(model.checkboxes)
                }
                
                groupCheckBoxStack.add([checkBox.addMargins(horizontal: Ocean.size.spacingStackXs)])
                
                if model.checkboxes.count != index + 1 {
                    groupCheckBoxStack.add([Ocean.Divider(widthConstraint: widthAnchor)])
                }
            }
            
            updateSelectAllCheckboxState()
        }
        
        private func setupContraints() {
            groupCheckBoxStack.oceanConstraints
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingStackXs)
                .topToTop(to: self, constant: Ocean.size.spacingStackXs)
                .make()
        }
        
        private func updateUI(_ touchedCheckBox: Ocean.CheckBox? = nil) {
            guard let touchedCheckBox = touchedCheckBox else { return }
            
            let id = touchedCheckBox.id
            
            if id < model.checkboxes.count {
                model.checkboxes[id].isSelected = touchedCheckBox.isSelected
            }
            
            updateSelectAllCheckboxState()
        }
        
        private func updateSelectAllCheckboxState() {
            let selectedAllItems = model.checkboxes.allSatisfy { $0.isSelected }
            let unselectedAllitems = model.checkboxes.allSatisfy { !$0.isSelected }
            
            if selectedAllItems {
                selectAllCheckBox.setupIconType(.check)
                selectAllCheckBox.isSelected = true
            } else if unselectedAllitems {
                selectAllCheckBox.isSelected = false
            } else {
                selectAllCheckBox.setupIconType(.minus)
                selectAllCheckBox.isSelected = true
            }
        }
        
        private func onTouchSelectAll() {
            let selectedAllItems = model.checkboxes.allSatisfy { $0.isSelected }
            
            if selectedAllItems {
                toogleSelectionAll(statusAllItems: false)
            } else {
                selectAllCheckBox.setupIconType(.check)
                toogleSelectionAll(statusAllItems: true)
            }
        }
        
        private func toogleSelectionAll(statusAllItems selected: Bool) {
            
            for index in model.checkboxes.indices {
                model.checkboxes[index].isSelected = selected
            }
            
            for view in groupCheckBoxStack.arrangedSubviews {
                if let checkBox = view.subviews.first as? Ocean.CheckBox {
                    checkBox.isSelected = selected
                }
            }
            
        }
    }
}
