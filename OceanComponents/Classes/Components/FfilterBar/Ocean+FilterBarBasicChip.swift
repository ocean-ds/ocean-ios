//
//  Ocean+FilterBarBasicChip.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 26/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class FilterBarBasicChip: BaseFilterBarChip {
        public var onValueChange: ((Bool, String) -> Void)?
        
        private var isSelected: Bool = false
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXxxs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                imageView,
                label,
                badge
            ])
            
            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private func setupUI() {
            type = .basicChip
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
        
        @objc override func didTapButton() {
            super.didTapButton()
            updateBasicChip()
            onValueChange?(isSelected, text)
        }
        
        private func updateBasicChip() {
            switch status {
            case .inactive, .normal:
                status = .selected
                isSelected = true
            case .selected:
                status = .inactive
                isSelected = false
            default:
                break
            }
        }
    }
}
