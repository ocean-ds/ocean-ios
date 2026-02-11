//
//  Ocean+ModalListViewController.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 22/06/22.
//

import UIKit
import SPStorkController
import OceanTokens

extension Ocean {
    public class ModalListViewController: BaseModalViewController, UITableViewDelegate, UITableViewDataSource {
        
        struct Constants {
            static let heightCell: CGFloat = 48
        }
        
        public var onValueSelected: ((Int, CellModel) -> Void)?
        public var isLoading: Bool = false {
            didSet {
                actions.map { $0 as? ButtonPrimary }
                    .forEach { $0?.isLoading = isLoading }
                
                actions.map { $0 as? ButtonSecondary }
                    .forEach { $0?.isLoading = isLoading }
            }
        }
        
        var contentTitle: String?
        var contentValues: [CellModel]?
        var actionsAxis: NSLayoutConstraint.Axis = .vertical
        var actions: [UIControl] = []
        var contentMultipleOptions: [CellModel]?
        var buttonStackDistribution: UIStackView.Distribution = .fill

        private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.tableHeaderView = UIView()
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.bounces = false
            tableView.separatorStyle =  .none
            
            tableView.register(ModalSingleChoiceCell.self, forCellReuseIdentifier: ModalSingleChoiceCell.identifier)
            tableView.register(ModalMultipleChoiceCell.self, forCellReuseIdentifier: ModalMultipleChoiceCell.identifier)
            
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
                stackView.distribution = buttonStackDistribution
                stackView.alignment = .fill
                stackView.spacing = Ocean.size.spacingStackXs
                stackView.layoutMargins = UIEdgeInsets(top: Ocean.size.spacingInsetSm,
                                                       left: 0,
                                                       bottom: 0,
                                                       right: 0)
                stackView.isLayoutMarginsRelativeArrangement = true
            }
        }()

        public override func makeView() {
            var totalSpacing = heightSpacing
            totalSpacing += Ocean.size.spacingStackXxs
            
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))

            let topSpacing = Ocean.size.spacingStackMd
            totalSpacing += topSpacing

            if swipeDismiss {
                mainStack.addArrangedSubview(closeView)
            } else {
                mainStack.addArrangedSubview(Spacer(space: topSpacing))
            }

            totalSpacing += addTitleIfExists()
            totalSpacing += addActionsIfExist()

            if let contentValues = contentValues {
                let tableHeight = Constants.heightCell * (CGFloat(contentValues.count))
                totalSpacing += tableHeight
            }

            if let contentValues = contentMultipleOptions {
                let tableHeight = Constants.heightCell * (CGFloat(contentValues.count))
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
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs, safeArea: true)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs, safeArea: true)
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
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs, safeArea: true)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs, safeArea: true)
                .make()
        }
        
        private func addConstraintDivider() {
            divider.oceanConstraints
                .topToTop(to: bottomStack)
                .leadingToLeading(to: view, safeArea: true)
                .trailingToTrailing(to: view, safeArea: true)
                .make()
        }

        public func tableView(_ tableView: UITableView,
                              numberOfRowsInSection section: Int) -> Int {
            if let contentValues = contentValues {
                return contentValues.count
            }
            
            if let contentMultipleOptions = contentMultipleOptions {
                return contentMultipleOptions.count
            }
            
            return 0
        }

        public func tableView(_ tableView: UITableView,
                              cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: ModalCellProtocol
            
            cell = ModalSingleChoiceCell()
            
            if let contentValues = contentValues {
                cell = tableView.dequeueReusableCell(withIdentifier: ModalSingleChoiceCell.identifier, for: indexPath) as! ModalSingleChoiceCell
                cell.model = contentValues[indexPath.row]
                
            } else if let contentMultipleOptions = contentMultipleOptions {
                cell = tableView.dequeueReusableCell(withIdentifier: ModalMultipleChoiceCell.identifier, for: indexPath) as! ModalMultipleChoiceCell
                cell.model = contentMultipleOptions[indexPath.row]
            }
            
            return cell
        }

        public func tableView(_ tableView: UITableView,
                              heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  Constants.heightCell
        }

        public func tableView(_ tableView: UITableView,
                              didSelectRowAt indexPath: IndexPath) {
            
            if let value = contentValues?[indexPath.row] {
                self.dismiss(animated: true, wasClosed: false, completion: nil)
                self.onValueSelected?(indexPath.row, value)
            }
        }
    }
}
