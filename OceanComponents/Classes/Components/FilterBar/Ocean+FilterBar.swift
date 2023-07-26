//
//  Ocean+FilterBar.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 26/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class FilterBar: UIView {
        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        
        private lazy var divider: UIView = {
            let divider = Divider(heightConstraint: self.heightAnchor, axis: .vertical)
            divider.isHidden = true
            return divider
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                stackFilterChipView,
                divider,
                stackBasicChipView
            ])
            
            stack.setMargins(horizontal: Ocean.size.spacingStackXs)
            return stack
        }()
        
        private lazy var stackFilterChipView: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            return stack
        }()
        
        private lazy var stackBasicChipView: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            return stack
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupScrollView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupScrollView() {
            addSubview(scrollView)
            scrollView.addSubview(mainStack)

            scrollView.oceanConstraints
                .fill(to: self)
                .height(constant: 64)
                .make()

            mainStack.oceanConstraints
                .topToTop(to: scrollView, constant: Ocean.size.spacingStackXs)
                .bottomToBottom(to: scrollView, constant: -Ocean.size.spacingStackXs)
                .leadingToLeading(to: scrollView)
                .trailingToTrailing(to: scrollView)
                .make()
        }
        
        public func addFilterChips(_ view: [FilterBarChipWithModal]) {
            stackFilterChipView.removeAllArrangedSubviews()
            stackFilterChipView.add(view)
        }
        
        public func addBasicChips(_ view: [FilterBarBasicChip]) {
            stackBasicChipView.removeAllArrangedSubviews()
            stackBasicChipView.add(view)
            divider.isHidden = false
        }
    }
}
