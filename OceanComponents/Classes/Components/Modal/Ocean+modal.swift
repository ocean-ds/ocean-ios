//
//  Ocean+modal.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class Modal {
        internal var modalViewController: ModalViewController
        
        public init(_ rootViewController: UIViewController) {
            modalViewController = ModalViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> Modal {
            modalViewController.swipeDismiss = value
            return self
        }
        
        public func withImage(_ image: UIImage?) -> Modal {
            modalViewController.contentImage = image
            return self
        }
        
        public func withTitle(_ title: String?) -> Modal {
            modalViewController.contentTitle = title
            return self
        }
        
        public func withDescription(_ description: String?) -> Modal {
            modalViewController.contentDescription = description
            return self
        }
        
        public func withDescription(_ description: NSAttributedString?) -> Modal {
            modalViewController.contentDescriptionAttributeText = description
            return self
        }
        
        public func withAction(textNegative: String,
                        actionNegative: (() -> Void)?,
                        textPositive: String,
                        actionPositive: (() -> Void)?) -> Modal {
            modalViewController.actionsAxis = .horizontal
            modalViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true) {
                        actionNegative?()
                    }
                }
            })
            modalViewController.actions.append(Ocean.Button.primaryMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true) {
                        actionPositive?()
                    }
                }
            })
            return self
        }
        
        public func withActionPrimary(text: String, action: (() -> Void)?) -> Modal {
            modalViewController.actionsAxis = .vertical
            modalViewController.actions.append(Ocean.Button.primaryBlockedMD { button in
                button.text = text
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public func withActionSecondary(text: String, action: (() -> Void)?) -> Modal {
            modalViewController.actionsAxis = .vertical
            modalViewController.actions.append(Ocean.Button.secondaryBlockedMD { button in
                button.text = text
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public func withCode(_ code: Int?) -> Modal {
            if let code = code {
                modalViewController.contentAdditionalInformation = "Código \(code)"
            }
            return self
        }

        public func withAdditionalInformation(_ additionalInformation: String?) -> Modal {
            modalViewController.contentAdditionalInformation = additionalInformation
            return self
        }
        
        public func withCustomView(view: UIView) -> Modal {
            modalViewController.customContent = view
            return self
        }
        
        public func build() -> ModalViewController {
            self.modalViewController.makeView()
            return modalViewController
        }
    }
}
