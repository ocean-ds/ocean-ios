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
    public class BottomSheetViewController: UIViewController {
        private lazy var mainStack: UIStackView = {
            UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.alignment = .fill
                stack.distribution = .fillProportionally
                stack.axis = .vertical
            }
        }()
        
        private lazy var spTransitionDelegate: SPStorkTransitioningDelegate = {
            let delegate = SPStorkTransitioningDelegate()
            delegate.indicatorMode = .alwaysLine
            self.transitioningDelegate = delegate
            self.modalPresentationStyle = .custom
            self.modalPresentationCapturesStatusBarAppearance = true
            return delegate
        }()
        
        private var heightSpacing: CGFloat {
            get {
                return hasTopNotch ? 100 : 80
            }
        }
        
        private var rootViewController: UIViewController

        var contentImage: UIImage?
        var contentTitle: String?
        var contentDescription: String?
        var contentDescriptionAttributeText: NSAttributedString?
        var contentCode: String?
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
            spTransitionDelegate.customHeight = mainStack.frame.height + heightSpacing
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
                label.textAlignment = .center
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorBrandPrimaryPure
            })
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        }

        fileprivate func addDescriptionIfExist() {
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

            mainStack.addArrangedSubview(Ocean.Typography.paragraph { label in
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

            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: Ocean.size.spacingStackSm),
                    mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                     constant: -Ocean.size.spacingStackSm),
                    mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    mainStack.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                    constant: Ocean.size.spacingStackSm),
                    mainStack.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                     constant: -Ocean.size.spacingStackSm),
                    mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            }
        }
    }
}
