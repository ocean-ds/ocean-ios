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

        public var onValueSelected: ((Int, CellModel) -> Void)?

        var contentTitle: String?
        var contentValues: [CellModel]?

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

            totalSpacing += addTitleIfExist()

            if let contentValues = contentValues {
                let pureHeight = contentValues.first?.imageIcon != nil ? Constants.heightCellWithImages : Constants.heightCell
                let tableHeight = pureHeight * (CGFloat(contentValues.count))
                totalSpacing += tableHeight
            }

            spTransitionDelegate.customHeight = totalSpacing
        }

        fileprivate func addTitleIfExist() -> CGFloat {
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

        public override func viewDidLoad() {
            super.viewDidLoad()
            self.view.addSubview(tableView)
            addConstraintMainStack()
            addConstraintTableView()
        }

        private func addConstraintMainStack() {
            NSLayoutConstraint.activate([
                mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                constant: Ocean.size.spacingStackSm),
                mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                 constant: -Ocean.size.spacingStackSm)
            ])
        }

        private func addConstraintTableView() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
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
