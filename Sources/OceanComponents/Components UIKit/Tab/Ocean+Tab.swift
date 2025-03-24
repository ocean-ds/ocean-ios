//
//  Ocean+Tab.swift
//  FSCalendar
//
//  Created by Leticia Fernandes on 22/03/22.
//

import OceanTokens
import UIKit

extension Ocean {
    public class Tab: UIView {
        struct Constants {
            static let tabHeight: CGFloat = 56
            static let lineHeight: CGFloat = 2
            static var lineWidth: CGFloat = 180
        }

        public typealias TabViewBuilder = ((Tab) -> Void)?

        public var onTouch: ((Int) -> Void)?

        public var items: [OceanTabItem] = [] {
            didSet {
                Constants.lineWidth = UIScreen.main.bounds.width / CGFloat(self.items.count)
                updateUI()
            }
        }

        public var selectedIndex: Int = 0 {
            didSet {
                updateUI()
            }
        }

        public var tabTintColor: UIColor = Ocean.color.colorBrandPrimaryPure {
            didSet {
                updateUI()
            }
        }

        public var tabDefaultColor: UIColor = Ocean.color.colorInterfaceDarkUp {
            didSet {
                updateUI()
            }
        }
        
        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill
                stack.spacing = 0
                
                stack.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()

        private lazy var tabStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .fill
                
                stack.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var selectionLineView: UIView = {
            let view = UIView()
            return view
        }()
        
        private lazy var selectionLineViewWidthConstraint: NSLayoutConstraint = {
            return selectionLineView.widthAnchor.constraint(equalToConstant: Constants.lineWidth)
        }()
        
        private lazy var selectionLineViewLeadingConstraint: NSLayoutConstraint = {
            return selectionLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        }()

        private lazy var divider = Ocean.Divider()

        public convenience init(builder: TabViewBuilder = nil) {
            self.init()
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            backgroundColor = Ocean.color.colorInterfaceLightPure
            selectionLineView.backgroundColor = self.tabTintColor
            isSkeletonable = true
            addSubview(mainStack)
            setupConstraints()
        }

        private func setupConstraints() {
            mainStack.oceanConstraints
                .fill(to: self)
                .make()
            
            mainStack.add([containerView])
            containerView.addSubviews(tabStack, selectionLineView, divider)

            tabStack.oceanConstraints
                .topToTop(to: containerView)
                .leadingToLeading(to: containerView)
                .trailingToTrailing(to: containerView)
                .height(constant: Constants.tabHeight)
                .make()
            
            selectionLineView.oceanConstraints
                .topToBottom(to: tabStack)
                .height(constant: Constants.lineHeight)
                .make()
            
            divider.oceanConstraints
                .topToBottom(to: selectionLineView)
                .leadingToLeading(to: containerView)
                .trailingToTrailing(to: containerView)
                .bottomToBottom(to: containerView)
                .make()

            selectionLineViewWidthConstraint.isActive = true
            selectionLineViewLeadingConstraint.isActive = true
        }

        private func updateUI() {
            self.tabStack.removeAllArrangedSubviews()
            for index in 0..<self.items.count {
                let itemView = self.setupItemView(index: index)
                self.tabStack.addArrangedSubview(itemView)
            }

            selectionLineViewWidthConstraint.constant = Constants.lineWidth
            let xPointLine = Constants.lineWidth * CGFloat(self.selectedIndex)
            selectionLineViewLeadingConstraint.constant = xPointLine
        }

        private func setupItemView(index: Int) -> UIView {
            let item = self.items[index]

            let itemStack = Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .fill
                stack.spacing = Ocean.size.spacingInsetXs
            }

            let titleLabel = Ocean.Typography.heading4 { label in
                label.text = item.title
                label.textColor = self.selectedIndex == index ? self.tabTintColor : self.tabDefaultColor
                label.textAlignment = .center
                label.numberOfLines = 1
                label.setContentHuggingPriority(.required, for: .horizontal)
            }
            itemStack.addArrangedSubview(titleLabel)

            if let badgeNumberValue = item.badgeNumber {
                let badgeNumberView = Ocean.Badge.number { view in
                    view.status = self.selectedIndex == index ? .primary : .neutral
                    view.size = .small
                    view.number = badgeNumberValue
                    view.status = item.status
                }
                itemStack.addArrangedSubview(badgeNumberView)
            }

            let button = UIButton(frame: .zero)
            button.tag = index
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(self.itemTapped(_:)), for: .touchUpInside)

            let itemView = UIView()
            itemView.backgroundColor = .clear
            itemView.addSubview(itemStack)

            let containerItemView = UIView()
            containerItemView.backgroundColor = .clear
            containerItemView.addSubviews(itemView, button)

            containerItemView.oceanConstraints
                .width(constant: Constants.lineWidth)
                .make()

            itemView.oceanConstraints
                .center(to: containerItemView)
                .make()

            itemStack.oceanConstraints
                .fill(to: itemView)
                .make()

            button.oceanConstraints
                .fill(to: containerItemView)
                .make()

            return containerItemView
        }

        @objc func itemTapped(_ sender: Any?) {
            if let button = sender as? UIButton, button.tag < self.items.count {
                self.selectedIndex = button.tag
                self.onTouch?(selectedIndex)
            }
        }

        public func getTabItemView(at index: Int) -> UIView? {
            if let mainStack = subviews.first,
               let containerView = mainStack.subviews.first,
               let tabStack = containerView.subviews.first,
               index < tabStack.subviews.count {
                
                return tabStack.subviews[index]
            }
            
            return nil
        }
    }
}
