//
//  Ocean+BottomSheetViewController.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import UIKit
import SPStorkController
import OceanTokens

extension Ocean {
    public class BottomSheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        struct Constants {
            static let heightCell: CGFloat = 48
            static let heightCellWithImages: CGFloat = 73
        }
        
        private lazy var mainStack: UIStackView = {
            UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.distribution = .fillProportionally
                stack.axis = .vertical
            }
        }()
        
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
        
        private lazy var spTransitionDelegate: SPStorkTransitioningDelegate = {
            let delegate = SPStorkTransitioningDelegate()
            delegate.indicatorMode = .alwaysLine
            delegate.cornerRadius = 24
            self.transitioningDelegate = delegate
            self.modalPresentationStyle = .custom
            self.modalPresentationCapturesStatusBarAppearance = true
            return delegate
        }()
        
        private var heightSpacing: CGFloat {
            get {
                return hasTopNotch ? contentValues == nil ? 80 : 40 : contentValues == nil ? 50 : 20
            }
        }
        
        private var rootViewController: UIViewController

        public var onValueSelected: ((Int, CellModel) -> Void)?
        
        var contentIsCritical: Bool = false
        var contentImage: UIImage?
        var contentTitle: String?
        var contentDescription: String?
        var contentDescriptionAttributeText: NSAttributedString?
        var contentCode: String?
        var contentValues: [CellModel]?
        var actionsAxis: NSLayoutConstraint.Axis = .vertical
        var actions: [UIControl] = []
        var customContent: UIView?
        var swipeDismiss: Bool = true {
            didSet {
                spTransitionDelegate.swipeToDismissEnabled = swipeDismiss
                spTransitionDelegate.showIndicator = swipeDismiss
                spTransitionDelegate.tapAroundToDismissEnabled = swipeDismiss
            }
        }
        
        init(_ rootViewController: UIViewController) {
            self.rootViewController = rootViewController
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func makeView() {
            var totalSpacing = heightSpacing
            let topSpacing = Ocean.size.spacingStackMd
            mainStack.addArrangedSubview(Spacer(space: topSpacing))
            
            totalSpacing += topSpacing
            totalSpacing += addImageIfExist()
            totalSpacing += addTitleIfExist()
            totalSpacing += addDescriptionIfExist()
            totalSpacing += addCustomViewIfExist()
            totalSpacing += addActionsIfExist()
            totalSpacing += addErrorCodeIfExist()
            
            if let contentValues = contentValues {
                let pureHeight = contentValues.first?.imageIcon != nil ? Constants.heightCellWithImages : Constants.heightCell
                let tableHeight = pureHeight * (CGFloat(contentValues.count))
                totalSpacing += tableHeight
            }
            
            spTransitionDelegate.customHeight = totalSpacing
        }
        
        public func show() {
            DispatchQueue.main.async {
                if let presentedViewController = self.rootViewController.presentedViewController {
                    presentedViewController.dismiss(animated: true) {
                        self.present(self, animated: true, completion: nil)
                    }
                } else {
                    self.rootViewController.present(self, animated: true, completion: nil)
                }
            }
        }

        fileprivate func addActionsIfExist() -> CGFloat {
            guard !actions.isEmpty else {
                return 0
            }
            
            let stackView = UIStackView { stack in
                stack.axis = actionsAxis
                stack.distribution = .fillEqually
                stack.spacing = Ocean.size.spacingStackXs
                actions.forEach { (control) in
                    stack.addArrangedSubview(control)
                }
            }
            
            let actionsHeight: CGFloat = actionsAxis == .horizontal ? 48 : actions.count > 1 ? 112 : 48
            let topSpacing = Ocean.size.spacingStackMd
            let bottomSpacing = Ocean.size.spacingStackSm
            
            mainStack.addArrangedSubview(Spacer(space: topSpacing))
            mainStack.addArrangedSubview(stackView)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))
            
            return actionsHeight + topSpacing + bottomSpacing
        }
        
        fileprivate func addCustomViewIfExist() -> CGFloat {
            guard let customContent = self.customContent else {
                return 0
            }
            
            customContent.sizeToFit()
            
            mainStack.addArrangedSubview(customContent)
            
            return customContent.frame.height
        }

        fileprivate func addImageIfExist() -> CGFloat {
            guard let image = contentImage else {
                return 0
            }
            
            let imageView = UIImageView { imageView in
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.sizeToFit()
            }
            
            let bottomSpacing = Ocean.size.spacingStackSm

            mainStack.addArrangedSubview(imageView)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))
            
            return imageView.frame.height + bottomSpacing
        }

        fileprivate func addTitleIfExist() -> CGFloat {
            guard let title = contentTitle else {
                return 0
            }
            
            let label = Ocean.Typography.heading3 { label in
                label.text = title
                label.textAlignment = self.contentValues == nil ? .center : .left
                label.numberOfLines = 0
                label.textColor = self.contentIsCritical ? Ocean.color.colorStatusNegativePure : Ocean.color.colorBrandPrimaryPure
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
            }
            
            let bottomSpacing = Ocean.size.spacingStackXs

            mainStack.addArrangedSubview(label)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))
            
            return label.frame.height + bottomSpacing
        }

        fileprivate func addDescriptionIfExist() -> CGFloat {
            if contentDescription == nil && contentDescriptionAttributeText == nil {
                return 0
            }
            
            let label = Ocean.Typography.paragraph { label in
                if let contentDescription = self.contentDescription {
                    label.text = contentDescription
                }
                if let contentDescriptionAttributeText = self.contentDescriptionAttributeText {
                    label.attributedText = contentDescriptionAttributeText
                }
                label.numberOfLines = 0
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
            }
            
            mainStack.addArrangedSubview(label)
            
            let totalLines = (label.frame.width / view.frame.width).rounded()
            return totalLines * label.frame.height
        }
        
        fileprivate func addErrorCodeIfExist() -> CGFloat {
            guard let code = contentCode else {
                return 0
            }
            
            let label = Ocean.Typography.description { label in
                label.text = "Código \(code)"
                label.numberOfLines = 1
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
            }
            
            let bottomSpacing = Ocean.size.spacingStackXs

            mainStack.addArrangedSubview(label)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))
            
            return label.frame.height + bottomSpacing
        }

        public override func viewDidLoad() {
            self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.view.addSubview(mainStack)
            
            if contentValues == nil {
                addConstraintMainStack(addConstraintBottom: true)
            } else {
                self.view.addSubview(tableView)
                addConstraintMainStack(addConstraintBottom: false)
                addConstraintTableView()
            }
        }
        
        private func addConstraintMainStack(addConstraintBottom: Bool) {
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: Ocean.size.spacingStackSm),
                    mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                     constant: -Ocean.size.spacingStackSm)
                ])
                
                if addConstraintBottom {
                    mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                }
            } else {
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: view.topAnchor),
                    mainStack.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                    constant: Ocean.size.spacingStackSm),
                    mainStack.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                     constant: -Ocean.size.spacingStackSm)
                ])
                
                if addConstraintBottom {
                    mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                }
            }
        }
        
        private func addConstraintTableView() {
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contentValues?.count ?? 0
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Ocean.BottomSheetCell()

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
