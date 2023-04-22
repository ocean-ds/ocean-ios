//
//  Ocean+ModelMultipleChoiceViewController.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 18/04/23.
//

import Foundation
import OceanTokens


extension Ocean {

    public class ModelMultipleChoiceViewController: BaseModalViewController {
        
        struct Constants {
            static let heightCell: CGFloat = 36
        }
    
        var contentTitle: String?
        var contenteMultipleOptions: [CellModel] = []
        var actions: [UIControl] = []
        
        public func getMultipleOptions() -> [CellModel] {
                return contenteMultipleOptions
            }
        
        private lazy var divider: Ocean.Divider = {
            let divider = Ocean.Divider()
            divider.translatesAutoresizingMaskIntoConstraints = true
            divider.isHidden = true
            return divider
        }()
        
        private lazy var bottomStack: Ocean.StackView = {
            Ocean.StackView { stackView in
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.distribution = .fillEqually
                stackView.alignment = .fill
                stackView.spacing = Ocean.size.spacingStackXs
                stackView.layoutMargins = UIEdgeInsets(top: Ocean.size.spacingInsetSm,
                                                       left: 0,
                                                       bottom: 0,
                                                       right: 0)
                stackView.isLayoutMarginsRelativeArrangement = true
            }
        }()
        
        override func makeView() {
            var totalSpacing = heightSpacing
            
            let topSpacing = Ocean.size.spacingStackMd
            totalSpacing += topSpacing

            if swipeDismiss {
                mainStack.addArrangedSubview(closeView)
            } else {
                mainStack.addArrangedSubview(Spacer(space: topSpacing))
            }
            
            totalSpacing += addTitleIfExists()
            totalSpacing += addActionsIfExist()
            
        
            let tableHeight = Constants.heightCell * (CGFloat(contenteMultipleOptions.count))
            totalSpacing += tableHeight - 8
            
            
            spTransitionDelegate.customHeight = totalSpacing
        }
        
        fileprivate func addTitleIfExists() -> CGFloat {
            guard let title = contentTitle else {
                return 0
            }

            let label = Ocean.Typography.heading4 { label in
                label.text = title
                label.textAlignment = .left
                label.numberOfLines = 0
                label.translatesAutoresizingMaskIntoConstraints = false
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.82
                label.sizeToFit()
            }

            let bottomSpacing = Ocean.size.spacingStackXs

            mainStack.addArrangedSubview(label)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))

            let widthWithoutSpacing = view.frame.width - Ocean.size.spacingInsetLg
            let totalLines = (label.frame.width / widthWithoutSpacing).rounded()
            return (totalLines * label.frame.height) + bottomSpacing
        }
        
        fileprivate func addActionsIfExist() -> CGFloat {
            guard !actions.isEmpty else {
                return 0
            }

            let topSpacing = bottomStack.layoutMargins.top
            let bottomSpacing = bottomStack.layoutMargins.bottom

            divider.isHidden = actions.isEmpty
            actions.forEach { control in
                bottomStack.addArrangedSubview(control)
            }
            
            let actionsHeight: CGFloat =  48

            return actionsHeight + topSpacing + bottomSpacing
        }
        
        private lazy var optionsListCheckBox: [Ocean.CheckBox] = []
        
        lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXxs

            stack.add(optionsListCheckBox)

            return stack
        }()
        
//        private lazy var buttonSecudary: Ocean.ButtonSecondary = {
//            Ocean.Button.secondaryMD { button in
//                button.text = "Cancelar"
//                button.onTouch = optionSelected
//            }
//        }()
//
//        private lazy var buttonPrimary: Ocean.ButtonPrimary = {
//            Ocean.Button.primaryMD { button in
//                button.text = "Filtrar"
//                button.onTouch = optionSelected
//            }
//        }()
//
//        private lazy var buttonStack: Ocean.StackView = {
//            let stack = Ocean.StackView()
//            stack.axis = .horizontal
//            stack.distribution = .fill
//            stack.spacing = Ocean.size.spacingStackXxs
//
//            stack.add([
//                buttonPrimary,
//                buttonSecudary
//            ])
//
//            return stack
//        }()
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            view.addSubview(contentStack)
            view.addSubview(bottomStack)
            view.addSubview(divider)
            addConstraintMainStack()
            addConstraintContentStack()
            addConstraintBottomStack()
            addConstraintDivider()
        }
        
        private func addConstraintMainStack() {
            mainStack.oceanConstraints
                .topToTop(to: view, safeArea: true)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackSm, safeArea: true)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackSm, safeArea: true)
                .make()
        }

        private func addConstraintContentStack() {
            contentStack.oceanConstraints
                .topToBottom(to: mainStack)
                .bottomToTop(to: bottomStack, constant: -8)
                .leadingToLeading(to: mainStack)
                .trailingToTrailing(to: mainStack)
                .make()
        }
        
        private func addConstraintBottomStack() {
            bottomStack.oceanConstraints
                .topToBottom(to: contentStack)
                .bottomToBottom(to: view, safeArea: true)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackSm, safeArea: true)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackSm, safeArea: true)
                .make()
        }
        
        private func addConstraintDivider() {
            divider.oceanConstraints
                .topToTop(to: bottomStack)
                .leadingToLeading(to: view, safeArea: true)
                .trailingToTrailing(to: view, safeArea: true)
                .make()
        }
        
        private func configureView() {
            mainStack.addArrangedSubview(closeView)
        }
        
        public func optionSelected() -> [CellModel] {
            return contenteMultipleOptions
        }
        
        private func setupUI() {
            contenteMultipleOptions.enumerated().forEach { index, item in
                let itemCheckBox = Ocean.CheckBox()
                itemCheckBox.text = item.title
                itemCheckBox.isSelected = item.isSelected
                itemCheckBox.onTouch = {
                    self.contenteMultipleOptions[index].isSelected = !self.contenteMultipleOptions[index].isSelected
                }
                optionsListCheckBox.append(itemCheckBox)
            }
        }
    }
}
