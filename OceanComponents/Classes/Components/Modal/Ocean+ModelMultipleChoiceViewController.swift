//
//  Ocean+ModelMultipleChoiceViewController.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 18/04/23.
//

import Foundation
import OceanTokens


extension Ocean {

    public class ModelMultipleChoiceViewController: BaseModalViewController, UITableViewDelegate, UITableViewDataSource {
        
        struct Constants {
            static let heightCell: CGFloat = 48
            static let heightCellWithImages: CGFloat = 73
        }
    
        var contentTitle: String?
        var actionsAxis: NSLayoutConstraint.Axis = .vertical
        var contenteMultipleOptions: [CellModel]?
        var actions: [UIControl] = []
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.tableHeaderView = UIView()
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.bounces = false
            tableView.separatorStyle =  .none
            return tableView
        }()
        
        private lazy var divider: Ocean.Divider = {
            let divider = Ocean.Divider()
            divider.translatesAutoresizingMaskIntoConstraints = true
            divider.isHidden = true
            return divider
        }()
        
        private lazy var bottomStack: Ocean.StackView = {
            Ocean.StackView { stackView in
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = actionsAxis
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
            totalSpacing += Ocean.size.spacingStackXxs
            
            let topSpacing = Ocean.size.spacingStackMd
            totalSpacing += topSpacing

            if swipeDismiss {
                mainStack.addArrangedSubview(closeView)
            } else {
                mainStack.addArrangedSubview(Spacer(space: topSpacing))
            }
            
            totalSpacing += addTitleIfExists()
            totalSpacing += addActionsIfExist()
            
            if let contenteMultipleOptions = contenteMultipleOptions {
                let tableHeight = Constants.heightCell * (CGFloat(contenteMultipleOptions.count))
                totalSpacing += tableHeight
            }
            
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
            actions.forEach { (control) in
                bottomStack.addArrangedSubview(control)
            }
            
            let actionsHeight: CGFloat = actionsAxis == .horizontal ? 48 : actions.count > 1 ? 112 : 48

            return actionsHeight + topSpacing + bottomSpacing
        }
        
//        private lazy var optionsListCheckBox: [Ocean.CheckBox] = []
        
//        override lazy var mainStack: Ocean.StackView = {
//            let stack = Ocean.StackView()
//            stack.axis = .vertical
//            stack.distribution = .fill
//            stack.spacing = Ocean.size.spacingStackXs
//
//            stack.add(optionsListCheckBox)
//
//            stack.add([
//                titleLabel,
//                Divider.init(),
//                buttonStack
//            ])
//
//            return stack
//        }()
        
//        private lazy var buttonSecudary: Ocean.ButtonSecondary = {
//            Ocean.Button.secondaryMD { button in
//
//            }
//        }()
//
//        private lazy var buttonPrimary: Ocean.ButtonPrimary = {
//            Ocean.Button.primaryMD { button in
//
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
            view.addSubview(tableView)
            view.addSubview(bottomStack)
            view.addSubview(divider)
            addConstraintMainStack()
            addConstraintTableView()
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

        private func addConstraintTableView() {
            tableView.oceanConstraints
                .topToBottom(to: mainStack)
                .leadingToLeading(to: view, safeArea: true)
                .trailingToTrailing(to: view, safeArea: true)
                .make()
        }
        
        private func addConstraintBottomStack() {
            bottomStack.oceanConstraints
                .topToBottom(to: tableView)
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
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let contenteMultipleOptions = contenteMultipleOptions {
                return contenteMultipleOptions.count
            }
            
            return 0
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = ModalMultipleChoiceCell()
            
            if let contenteMultipleOptions = contenteMultipleOptions {
                cell.model = contenteMultipleOptions[indexPath.row]
            }
            
            return cell
        }
    }
}
