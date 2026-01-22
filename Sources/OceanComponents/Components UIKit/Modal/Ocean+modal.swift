//
//  Ocean+modal.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import UIKit
import OceanTokens
import SwiftUI

extension Ocean {
    public class Modal {
        internal var modalViewController: ModalViewController

        public init(_ rootViewController: UIViewController) {
            modalViewController = ModalViewController(rootViewController)
        }

        public func withDismiss(_ value: Bool, completion: ((Bool) -> Void)? = nil) -> Modal {
            modalViewController.swipeDismiss = value
            modalViewController.onDismiss = completion
            return self
        }

        public func withImage(_ image: UIImage?, maxHeight: CGFloat? = nil) -> Modal {
            modalViewController.contentImage = image
            modalViewController.maxImageHeight = maxHeight
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
            modalViewController.contentDescriptionAttributedText = description
            return self
        }

        public func withCaption(_ caption: String?) -> Modal {
            modalViewController.contentCaption = caption
            return self
        }

        public func withCaption(_ caption: NSAttributedString?) -> Modal {
            modalViewController.contentCaptionAttributedText = caption
            return self
        }

        public func withAction(textNegative: String,
                               actionNegative: (() -> Void)?,
                               textPositive: String,
                               actionPositive: (() -> Void)?,
                               shouldDismiss: Bool = true) -> Modal {
            modalViewController.actionsAxis = .horizontal
            modalViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    if shouldDismiss {
                        self.modalViewController.dismiss(animated: true, wasClosed: false) {
                            actionNegative?()
                        }
                    } else {
                        actionNegative?()
                    }
                }
            })
            modalViewController.actions.append(Ocean.Button.primaryMD { button in
                button.text = textPositive
                button.onTouch = {
                    if shouldDismiss {
                        self.modalViewController.dismiss(animated: true, wasClosed: false) {
                            actionPositive?()
                        }
                    } else {
                        actionPositive?()
                    }
                }
            })
            return self
        }

        public func withActionPrimary(text: String,
                                      icon: UIImage? = nil,
                                      action: (() -> Void)?,
                                      shouldDismiss: Bool = true) -> Modal {
            modalViewController.actionsAxis = .vertical
            modalViewController.actions.append(Ocean.Button.primaryBlockedMD { button in
                button.text = text
                button.icon = icon
                button.onTouch = {
                    if shouldDismiss {
                        self.modalViewController.dismiss(animated: true, wasClosed: false) {
                            action?()
                        }
                    } else {
                        action?()
                    }
                }
            })
            return self
        }

        public func withActionSecondary(text: String,
                                        icon: UIImage? = nil,
                                        action: (() -> Void)?,
                                        shouldDismiss: Bool = true) -> Modal {
            modalViewController.actionsAxis = .vertical
            modalViewController.actions.append(Ocean.Button.secondaryBlockedMD { button in
                button.text = text
                button.icon = icon
                button.onTouch = {
                    if shouldDismiss {
                        self.modalViewController.dismiss(animated: true, wasClosed: false) {
                            action?()
                        }
                    } else {
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
        
        public func withCustomSwiftUIView<Content: SwiftUI.View>(view: Content) -> Modal {
            let hostingController = UIHostingController(rootView: view)
            modalViewController.customContent = hostingController.getUIView()
            return self
        }

        public func build() -> ModalViewController {
            self.modalViewController.makeView()
            return modalViewController
        }
    }
    
    public protocol ModalNotDismissIfPresented {
        
    }
}
