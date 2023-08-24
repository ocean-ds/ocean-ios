//
//  Ocean+ModalMultipleChoiceCell.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 19/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    
    class ModalMultipleChoiceCell: UITableViewCell, ModalCellProtocol {
        
        public var model: Ocean.CellModel? {
            didSet {
                updateUI()
            }
        }
        
        static let identifier = "modalMultipleChoiceIdentifier"
        
        private lazy var optionCheckBox: Ocean.CheckBox = {
            let option = Ocean.CheckBox()
            
            return option
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .leading
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(optionCheckBox)
            stack.addArrangedSubview(Spacer(space: 16))
            
            return stack
        }()
        
        private func updateUI() {
            guard let model = self.model else { return }
        
            optionCheckBox.text = model.title
            optionCheckBox.isHidden = model.title.isEmpty
            optionCheckBox.isSelected = model.isSelected
        }
        
        private func setupUI() {
            contentView.addSubview(contentStack)
            self.selectionStyle = .none
            
            contentStack.oceanConstraints
                .topToTop(to: contentView)
                .bottomToBottom(to: contentView)
                .leadingToLeading(to: contentView, constant: Ocean.size.spacingStackSm)
                .trailingToTrailing(to: contentView, constant: -Ocean.size.spacingStackSm)
                .make()
        }
    }
}
