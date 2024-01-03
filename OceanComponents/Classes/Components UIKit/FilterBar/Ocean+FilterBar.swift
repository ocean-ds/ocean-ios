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

        public var onValueChange: (([Ocean.ChipModel]) -> Void)? = nil

        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

        private lazy var leftStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false

            return stack
        }()

        private lazy var divider: UIView = {
            let divider = Divider(heightConstraint: self.heightAnchor, axis: .vertical)
            divider.isHidden = true
            return divider
        }()

        private lazy var rightStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false

            return stack
        }()

        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                leftStack,
                divider,
                rightStack
            ])

            stack.setMargins(horizontal: Ocean.size.spacingStackXs)
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

        public func addFilters(leftItems: [BaseFilterBarChip] = [], rightItems: [BaseFilterBarChip] = []) {
            addFilters(leftItems, stack: leftStack)
            addFilters(rightItems, stack: rightStack)
        }

        private func addFilters(_ views: [BaseFilterBarChip], stack: Ocean.StackView) {
            stack.removeAllArrangedSubviews()
            stack.add(views)
            updateUI()

            views.compactMap { $0 as? FilterBarChipWithModal }
                .forEach {
                    $0.onValueChange = { [weak self ] _ in
                        guard let self = self else { return }
                        self.notifyChanges()
                    }
                }

            views.compactMap { $0 as? FilterBarBasicChip }
                .filter { $0.needChangeStatus }
                .forEach {
                    $0.onValueChange = { [weak self ] _ in
                        guard let self = self else { return }
                        self.notifyChanges()
                    }
                }
        }

        private func updateUI() {
            leftStack.isHidden = leftStack.arrangedSubviews.isEmpty
            divider.isHidden = leftStack.arrangedSubviews.isEmpty || rightStack.arrangedSubviews.isEmpty
            rightStack.isHidden = rightStack.arrangedSubviews.isEmpty
        }

        private func notifyChanges() {
            guard let onValueChange = onValueChange else {
                return
            }

            let withModalChipSelection = leftStack.arrangedSubviews
                .compactMap { $0 as? FilterBarChipWithModal }
                .flatMap { $0.optionsModel.options }
                .filter { $0.isSelected }
            + rightStack.arrangedSubviews
                .compactMap { $0 as? FilterBarChipWithModal }
                .flatMap { $0.optionsModel.options }
                .filter { $0.isSelected }

            let basicChipSelection = leftStack.arrangedSubviews
                .compactMap { $0 as? FilterBarBasicChip }
                .filter { $0.isSelected }
                .map { $0.chipModel }
            + rightStack.arrangedSubviews
                .compactMap { $0 as? FilterBarBasicChip }
                .filter { $0.isSelected }
                .map { $0.chipModel }

            onValueChange(withModalChipSelection + basicChipSelection)
        }
    }
}
