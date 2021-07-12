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
                stack.alignment = .fill
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
                return hasTopNotch ? 80 : 60
            }
        }
        
        private var rootViewController: UIViewController

        var onValueSelected: ((CellModel) -> Void)?
        
        var contentImage: UIImage?
        var contentTitle: String?
        var contentDescription: String?
        var contentDescriptionAttributeText: NSAttributedString?
        var contentCode: String?
        var contentValues: [CellModel]?
        var actionsAxis: NSLayoutConstraint.Axis = .vertical
        var actions: [UIControl] = []
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
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackMd))
            addImageIfExist()
            addTitleIfExist()
            addDescriptionIfExist()
            addActionsIfExist()
            addErrorCodeIfExist()
            
            mainStack.updateConstraints()
            mainStack.layoutIfNeeded()
            let tableHeight = Constants.heightCellWithImages * (CGFloat(contentValues?.count ?? 1))
            spTransitionDelegate.customHeight = mainStack.frame.height + tableHeight + heightSpacing
        }
        
        public func show() {
            DispatchQueue.main.async {
                self.rootViewController.present(self, animated: true, completion: nil)
            }
        }

        fileprivate func addActionsIfExist() {
            guard !actions.isEmpty else {
                return
            }
            
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackMd))
            mainStack.addArrangedSubview(UIStackView { stack in
                stack.axis = actionsAxis
                stack.distribution = .fillEqually
                stack.spacing = stack.axis == .vertical ? Ocean.size.spacingStackXs : Ocean.size.spacingInlineXs
                actions.forEach { (control) in
                    stack.addArrangedSubview(control)
                }
            })
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackSm))
        }

        fileprivate func addImageIfExist() {
            guard let image = contentImage else {
                return
            }

            mainStack.addArrangedSubview(UIImageView { imageView in
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
            })
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackSm))

        }

        fileprivate func addTitleIfExist() {
            guard let title = contentTitle else {
                return
            }

            mainStack.addArrangedSubview(Ocean.Typography.heading3 { label in
                label.text = title
                label.textAlignment = self.contentValues == nil ? .center : .left
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorBrandPrimaryPure
            })
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        }

        fileprivate func addDescriptionIfExist() {
            if contentDescription == nil && contentDescriptionAttributeText == nil {
                return
            }
            
            mainStack.addArrangedSubview(Ocean.Typography.paragraph { label in
                if let contentDescription = self.contentDescription {
                    label.text = contentDescription
                }
                if let contentDescriptionAttributeText = self.contentDescriptionAttributeText {
                    label.attributedText = contentDescriptionAttributeText
                }
                label.numberOfLines = 0
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkDown
            })
        }
        
        fileprivate func addErrorCodeIfExist() {
            guard let code = contentCode else {
                return
            }

            mainStack.addArrangedSubview(Ocean.Typography.description { label in
                label.text = "Código \(code)"
                label.numberOfLines = 0
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkUp
            })
            
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        }

        public override func viewDidLoad() {
            self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.view.addSubview(mainStack)
            
            if contentValues == nil {
                if #available(iOS 11.0, *) {
                    NSLayoutConstraint.activate([
                        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                        constant: Ocean.size.spacingStackSm),
                        mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                         constant: -Ocean.size.spacingStackSm)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        mainStack.topAnchor.constraint(equalTo: view.topAnchor),
                        mainStack.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                        constant: Ocean.size.spacingStackSm),
                        mainStack.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                         constant: -Ocean.size.spacingStackSm)
                    ])
                }
            } else {
                self.view.addSubview(tableView)
                
                if #available(iOS 11.0, *) {
                    NSLayoutConstraint.activate([
                        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                        constant: Ocean.size.spacingStackXs),
                        mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                         constant: -Ocean.size.spacingStackXs),
                        
                        tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        mainStack.topAnchor.constraint(equalTo: view.topAnchor),
                        mainStack.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                        constant: Ocean.size.spacingStackXs),
                        mainStack.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                         constant: -Ocean.size.spacingStackXs),
                        
                        tableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor),
                        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    ])
                }
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
                self.onValueSelected?(value)
            }
        }
    }
}
