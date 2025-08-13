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
        var maxImageHeight: CGFloat?
        var contentTitle: String?
        var contentDescription: String?
        var contentDescriptionAttributedText: NSAttributedString?
        var contentCaption: String?
        var contentCaptionAttributedText: NSAttributedString?
        var contentAdditionalInformation: String?
        var actionsAxis: NSLayoutConstraint.Axis = .vertical
        var actions: [UIControl] = []
        var customContent: UIView?

        public var isLoading: Bool = false {
            didSet {
                actions.map { $0 as? ButtonPrimary }
                    .forEach { $0?.isLoading = isLoading }

                actions.map { $0 as? ButtonSecondary }
                    .forEach { $0?.isLoading = isLoading }
            }
        }

        public override var heightSpacing: CGFloat {
            return hasTopNotch ? 85 : 55
        }

        public override func makeView() {
            setupConstraints()

            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))

            if swipeDismiss {
                mainStack.addArrangedSubview(closeView)
            } else {
                mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackMd))
            }

            addImageIfExist()
            addTitleIfExist()
            addDescriptionIfExist()
            addCaptionIfExist()
            addCustomViewIfExist()
            addActionsIfExist()
            addAdditionalInformationIfExist()

            mainStack.layoutIfNeeded()
            spTransitionDelegate.customHeight = mainStack.frame.height + Ocean.size.spacingStackSm
        }

        fileprivate func addImageIfExist() {
            guard let image = contentImage else {
                return
            }

            let imageView = UIImageView { imageView in
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.sizeToFit()
            }

            var imageHeight = imageView.frame.height
            if let maxHeight = maxImageHeight, imageHeight > maxHeight {
                imageHeight = maxHeight
                imageView.oceanConstraints
                    .height(constant: maxHeight)
                    .make()
            }

            let bottomSpacing = Ocean.size.spacingStackSm

            mainStack.addArrangedSubview(imageView)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))
        }

        fileprivate func addTitleIfExist() {
            guard let title = contentTitle else {
                return
            }

            let label = Ocean.Typography.heading3 { label in
                label.text = title
                label.textAlignment = .center
                label.numberOfLines = 0
                label.textColor = self.contentIsCritical ? Ocean.color.colorStatusNegativePure : Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.82
                label.sizeToFit()
            }

            let bottomSpacing = Ocean.size.spacingStackXs

            mainStack.addArrangedSubview(label)
            mainStack.addArrangedSubview(Spacer(space: bottomSpacing))
        }

        fileprivate func addDescriptionIfExist() {
            if contentDescription == nil && contentDescriptionAttributedText == nil {
                return
            }

            let label = Ocean.Typography.paragraph { label in
                if let contentDescription = self.contentDescription {
                    label.setTextWithBoldTag(contentDescription)
                }
                if let contentDescriptionAttributedText = self.contentDescriptionAttributedText {
                    label.attributedText = contentDescriptionAttributedText
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
        }

        fileprivate func addCaptionIfExist() {
            if contentCaption == nil && contentCaptionAttributedText == nil {
                return
            }

            mainStack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingStackXs))

            let label = Ocean.Typography.caption { label in
                if let contentDescription = self.contentCaption {
                    label.setTextWithBoldTag(contentDescription)
                }
                if let contentCaptionAttributedText = self.contentCaptionAttributedText {
                    label.attributedText = contentCaptionAttributedText
                }
                label.numberOfLines = 0
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
            }

            mainStack.addArrangedSubview(label)
        }

        fileprivate func addCustomViewIfExist() {
            guard let customContent = self.customContent else {
                return
            }

            mainStack.addArrangedSubview(customContent)
        }

        fileprivate func addActionsIfExist() {
            guard !actions.isEmpty else {
                return
            }

            let stackView = Ocean.StackView { stack in
                stack.axis = actionsAxis
                stack.distribution = .fillEqually
                stack.spacing = Ocean.size.spacingStackXs
                actions.forEach { (control) in
                    stack.addArrangedSubview(control)
                }
            }

            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackMd))
            mainStack.addArrangedSubview(stackView)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackSm))
        }

        fileprivate func addAdditionalInformationIfExist() {
            guard let additionalInformation = contentAdditionalInformation else {
                return
            }

            let label = Ocean.Typography.description { label in
                label.text = additionalInformation
                label.numberOfLines = 1
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
            }

            mainStack.addArrangedSubview(label)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        }

        private func setupConstraints() {
            mainStack.translatesAutoresizingMaskIntoConstraints = false

            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Ocean.size.spacingStackXs),
                    mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    mainStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - Ocean.size.spacingStackSm * 2)
                ])
            } else {
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: heightSpacing),
                    mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    mainStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - Ocean.size.spacingStackSm * 2)
                ])
            }
        }
    }
}
