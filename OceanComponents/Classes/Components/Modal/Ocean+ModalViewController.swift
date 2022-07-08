//
//  Ocean+ModalViewController.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import UIKit
import SPStorkController
import OceanTokens

extension Ocean {
    public class ModalViewController: BaseModalViewController {
        var contentIsCritical: Bool = false
        var contentImage: UIImage?
        var contentTitle: String?
        var contentDescription: String?
        var contentDescriptionAttributeText: NSAttributedString?
        var contentAdditionalInformation: String?
        var actionsAxis: NSLayoutConstraint.Axis = .vertical
        var actions: [UIControl] = []
        var customContent: UIView?

        override var heightSpacing: CGFloat {
            return hasTopNotch ? 85 : 55
        }

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

            totalSpacing += addImageIfExist()
            totalSpacing += addTitleIfExist()
            totalSpacing += addDescriptionIfExist()
            totalSpacing += addCustomViewIfExist()
            totalSpacing += addActionsIfExist()
            totalSpacing += addAdditionalInformationIfExist()

            spTransitionDelegate.customHeight = totalSpacing
        }

        fileprivate func addActionsIfExist() -> CGFloat {
            guard !actions.isEmpty else {
                return 0
            }

            let stackView = Ocean.StackView { stack in
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
                label.textAlignment = .center
                label.numberOfLines = 0
                label.textColor = self.contentIsCritical ? Ocean.color.colorStatusNegativePure : Ocean.color.colorBrandPrimaryPure
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

        fileprivate func addDescriptionIfExist() -> CGFloat {
            if contentDescription == nil && contentDescriptionAttributeText == nil {
                return 0
            }

            let label = Ocean.Typography.paragraph { label in
                if let contentDescription = self.contentDescription {
                    label.setTextWithBoldTag(contentDescription)
                }
                if let contentDescriptionAttributeText = self.contentDescriptionAttributeText {
                    label.attributedText = contentDescriptionAttributeText
                }
                label.numberOfLines = 0
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.translatesAutoresizingMaskIntoConstraints = false
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.82
                label.sizeToFit()
            }

            mainStack.addArrangedSubview(label)

            let widthWithoutSpacing = view.frame.width - Ocean.size.spacingInsetLg
            let totalLines = (label.frame.width / widthWithoutSpacing).rounded()
            return totalLines * label.frame.height
        }

        fileprivate func addAdditionalInformationIfExist() -> CGFloat {
            guard let additionalInformation = contentAdditionalInformation else {
                return 0
            }

            let label = Ocean.Typography.description { label in
                label.text = additionalInformation
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
            super.viewDidLoad()
            addConstraintMainStack()
        }

        private func addConstraintMainStack() {
            NSLayoutConstraint.activate([
                mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                constant: Ocean.size.spacingStackSm),
                mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                 constant: -Ocean.size.spacingStackSm),
                mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}
