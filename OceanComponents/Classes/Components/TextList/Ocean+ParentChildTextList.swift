//
//  Ocean+ParentChildTextList.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/03/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class ParentChildTextList: UIView, UITableViewDataSource, UITableViewDelegate {
        public typealias ParentChildTextListBuilder = ((ParentChildTextList) -> Void)?

        public struct Model {
            public let title: String
            public let subtitle: String
            public let image: UIImage?
            public let swipe: Bool
            public let buttons: [ButtonModel]

            public init(title: String,
                        subtitle: String,
                        image: UIImage? = nil,
                        swipe: Bool = false,
                        buttons: [ButtonModel] = []) {
                self.title = title
                self.subtitle = subtitle
                self.image = image
                self.swipe = swipe
                self.buttons = buttons
            }

            public static func empty() -> Model {
                return Model(title: "",
                             subtitle: "")
            }
        }

        public struct ButtonModel {
            public let title: String
            public let image: UIImage?
            public let backgroundColor: UIColor?
            public let onTouch: (() -> Void)?

            public init(title: String,
                        image: UIImage? = nil,
                        backgroundColor: UIColor? = nil,
                        onTouch: (() -> Void)? = nil) {
                self.title = title
                self.image = image
                self.backgroundColor = backgroundColor
                self.onTouch = onTouch
            }
        }

        private enum State {
            case expanded, collapsed
        }

        private var state: State = .collapsed {
            didSet {
                animateUI()
            }
        }

        public var parent: Model = .empty() {
            didSet {
                updateUI()
            }
        }

        public var children: [Model] = [] {
            didSet {
                updateUI()
            }
        }

        private lazy var parentTextList: Ocean.ParentChildTextListParentCell = {
            Ocean.ParentChildTextListParentCell { parent in
                parent.onTouch = {
                    self.state = self.state == .collapsed ? .expanded : .collapsed
                }
            }
        }()

        private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedSectionHeaderHeight = 0
            tableView.sectionHeaderHeight = 0
            tableView.estimatedRowHeight = ParentChildTextListChildCell.Constants.height
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedSectionFooterHeight = 0
            tableView.sectionFooterHeight = 0
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorStyle = .none
            tableView.tableHeaderView = nil
            tableView.tableFooterView = nil
            tableView.backgroundColor = Ocean.color.colorInterfaceLightPure
            tableView.register(ParentChildTextListChildCell.self, forCellReuseIdentifier: ParentChildTextListChildCell.identifier)
            tableView.isSkeletonable = true
            tableView.bounces = false
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0
            }

            return tableView
        }()

        private lazy var divider = Ocean.Divider(widthConstraint: self.widthAnchor)

        public lazy var heightConstraint: NSLayoutConstraint = {
            self.heightAnchor.constraint(equalToConstant: ParentChildTextListParentCell.Constants.height)
        }()

        public convenience init(builder: ParentChildTextListBuilder = nil) {
            self.init()
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            self.addSubviews(parentTextList, tableView, divider)
            parentTextList.setConstraints(([.topToTop(0),
                                            .leadingToLeading(0),
                                            .trailingToTrailing(0)], toView: self))
            tableView.setConstraints(([.topToBottom(0)], toView: parentTextList),
                                     ([.leadingToLeading(0),
                                       .trailingToTrailing(0),
                                       .bottomToBottom(0)], toView: self))
            divider.setConstraints(([.bottomToBottom(0)], toView: self))
            heightConstraint.isActive = true
        }

        private func updateUI() {
            parentTextList.title = parent.title
            parentTextList.subtitle = parent.subtitle
            parentTextList.image = parent.image

            tableView.reloadData()
        }

        private func animateUI() {
            switch self.state {
            case .collapsed:
                UIView.animate(withDuration: 0.3) {
                    self.parentTextList.arrowTransform = CGAffineTransform(rotationAngle: 0)
                    self.heightConstraint.constant = ParentChildTextListParentCell.Constants.height
                }
            case .expanded:
                UIView.animate(withDuration: 0.3) {
                    self.parentTextList.arrowTransform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                    self.heightConstraint.constant = ParentChildTextListParentCell.Constants.height + ParentChildTextListChildCell.Constants.height * CGFloat(self.children.count)
                }
            }
        }

        // MARK: - UITableViewDataSource

        public func numberOfSections(in tableView: UITableView) -> Int {
            1
        }

        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.children.count
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = ParentChildTextListChildCell()
            let child = self.children[indexPath.row]
            cell.title = child.title
            cell.subtitle = child.subtitle
            cell.image = child.image
            cell.swipe = child.swipe
            cell.onTouch = {
                print("tap")
            }
            return cell
        }

        // MARK: - UITableViewDelegate

        public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            ParentChildTextListChildCell.Constants.height
        }

        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }

        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        }

        @available(iOS 13.0, *)
        public func tableView(
            _ tableView: UITableView,
            contextMenuConfigurationForRowAt indexPath: IndexPath,
            point: CGPoint) -> UIContextMenuConfiguration? {
                let buttons = self.children[indexPath.row].buttons
                if buttons.isEmpty { return nil }

                return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
                    var actions: [UIAction] = []
                    buttons.forEach { button in
                        let action = UIAction(title: button.title,
                                              image: button.image) { _ in
                            button.onTouch?()
                        }
                        actions.append(action)
                    }

                    return UIMenu(title: "", children: actions)
                }
            }

        @available(iOS 11.0, *)
        public func tableView(
            _ tableView: UITableView,
            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                let buttons = self.children[indexPath.row].buttons
                if buttons.isEmpty { return nil }

                var actions: [UIContextualAction] = []
                buttons.forEach { button in
                    let action = UIContextualAction(style: .normal,
                                                    title: button.title) { _, _, _ in
                        button.onTouch?()
                    }
                    action.image = button.image
                    action.backgroundColor = button.backgroundColor
                    actions.append(action)
                }

                let configuration = UISwipeActionsConfiguration(actions: actions)
                configuration.performsFirstActionWithFullSwipe = false
                return configuration
            }
    }
}
