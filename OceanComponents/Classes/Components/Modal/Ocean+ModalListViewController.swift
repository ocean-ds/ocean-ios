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
            static let heightCellWithImages: CGFloat = 73
        }
        
        public var onValueSelected: ((Int, CellModel) -> Void)?
        
        var contentTitle: String?
        var contentValues: [CellModel]?
        var onPrimaryAction: (() -> Void)?
        var onSecondaryAction: (() -> Void)?

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
        
//        lazy var bottomPrimaryButton: Ocean.ButtonPrimary = {
//            Ocean.Button.primaryMD { button in
//                button.translatesAutoresizingMaskIntoConstraints = false
//                button.text = "Primary"
//                button.isHidden = true
//                button.onTouch = { [weak self] in
//                    guard let self = self else { return }
//                    self.dismiss(animated: true) {
//                        self.onPrimaryAction?()
//                    }
//                }
//            }
//        }()
//
//        lazy var bottomSecondaryButton: Ocean.ButtonSecondary = {
//            Ocean.Button.secondaryMD { button in
//                button.translatesAutoresizingMaskIntoConstraints = false
//                button.text = "Secondary"
//                button.isHidden = true
//                button.onTouch = { [weak self] in
//                    guard let self = self else { return }
//                    self.dismiss(animated: true) {
//                        self.onSecondaryAction?()
//                    }
//                }
//            }
//        }()
        
        private lazy var bottomStack: Ocean.StackView = {
            Ocean.StackView { stackView in
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .vertical
                stackView.distribution = .fill
                stackView.alignment = .fill
                stackView.spacing = Ocean.size.spacingStackXs
                stackView.layoutMargins = UIEdgeInsets(top: Ocean.size.spacingInsetSm,
                                                       left: Ocean.size.spacingInsetSm,
                                                       bottom: 0,
                                                       right: Ocean.size.spacingInsetSm)
                stackView.isLayoutMarginsRelativeArrangement = true
                
//                stackView.add([
//                    bottomPrimaryButton,
//                    bottomSecondaryButton
//                ])
            }
        }()

        override func makeView() {
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
            totalSpacing += addBottomIfExists()

            if let contentValues = contentValues {
                let pureHeight = contentValues.first?.imageIcon != nil ? Constants.heightCellWithImages : Constants.heightCell
                let tableHeight = pureHeight * (CGFloat(contentValues.count))
                totalSpacing += tableHeight
            }

            spTransitionDelegate.customHeight = totalSpacing
        }

        fileprivate func addTitleIfExists() -> CGFloat {
            guard let title = contentTitle else {
                return 0
            }

            let label = Ocean.Typography.heading3 { label in
                label.text = title
                label.textAlignment = .left
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorBrandPrimaryPure
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
        
        fileprivate func addBottomIfExists() -> CGFloat {
            var totalSpacing = 0.0
            
//            if !bottomPrimaryButton.isHidden {
//                totalSpacing += bottomPrimaryButton.height
//                totalSpacing += Ocean.size.spacingStackXs
//            }
//
//            if !bottomSecondaryButton.isHidden {
//                totalSpacing += bottomSecondaryButton.height
//                totalSpacing += Ocean.size.spacingStackXs
//            }
            
            bottomStack.subviews.forEach {
                if let subview = $0 as? ButtonPrimary {
                    totalSpacing += subview.height
                } else if let subview = $0 as? ButtonSecondary {
                    totalSpacing += subview.height
                }
            }
            
            if bottomStack.subviews.contains(where: { !$0.isHidden }) {
                totalSpacing += bottomStack.spacing
            }

            if totalSpacing > 0 {
                divider.isHidden = false
            }
            
            return totalSpacing
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
        
        public func addPrimaryButton(text: String, icon: UIImage? = nil, action: (() -> Void)? = nil) {
            let button = Ocean.Button.primaryMD { button in
                button.translatesAutoresizingMaskIntoConstraints = false
                button.text = text
                button.icon = icon
                button.onTouch = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.onPrimaryAction?()
                    }
                }
            }
            
            bottomStack.add([button])
        }
        
        public func addSecondaryButton(text: String, icon: UIImage? = nil, action: (() -> Void)? = nil) {
            let button = Ocean.Button.secondaryMD { button in
                button.translatesAutoresizingMaskIntoConstraints = false
                button.text = text
                button.icon = icon
                button.onTouch = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.onSecondaryAction?()
                    }
                }
            }
            
            bottomStack.add([button])
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
                .leadingToLeading(to: view, safeArea: true)
                .trailingToTrailing(to: view, safeArea: true)
                .make()
        }
        
        private func addConstraintDivider() {
            divider.oceanConstraints
                .topToTop(to: bottomStack)
                .leadingToLeading(to: view, safeArea: true)
                .trailingToTrailing(to: view, safeArea: true)
                .make()
        }

        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contentValues?.count ?? 0
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Ocean.ModalCell()

            cell.model = contentValues?[indexPath.row]

            return cell
        }

        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let hasImageIcon = self.contentValues?[indexPath.row].imageIcon != nil
            return hasImageIcon ? Constants.heightCellWithImages : Constants.heightCell
        }

        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let value = contentValues?[indexPath.row] {
                self.dismiss(animated: true, completion: nil)
                self.onValueSelected?(indexPath.row, value)
            }
        }
    }
}
