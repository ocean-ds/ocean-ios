//
//  Ocean+bottomSheet.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class BottomSheet {
        internal var bottomSheetViewController: BottomSheetViewController
        
        public init(_ rootViewController: UIViewController) {
            bottomSheetViewController = BottomSheetViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> BottomSheet {
            bottomSheetViewController.swipeDismiss = value
            return self
        }
        
        public func withImage(_ image: UIImage?) -> BottomSheet {
            bottomSheetViewController.contentImage = image
            return self
        }
        
        public func withTitle(_ title: String?) -> BottomSheet {
            bottomSheetViewController.contentTitle = title
            return self
        }
        
        public func withDescription(_ description: String?) -> BottomSheet {
            bottomSheetViewController.contentDescription = description
            return self
        }
        
        public func withDescription(_ description: NSAttributedString?) -> BottomSheet {
            bottomSheetViewController.contentDescriptionAttributeText = description
            return self
        }
        
        public func withAction(textNegative: String,
                        actionNegative: (() -> Void)?,
                        textPositive: String,
                        actionPositive: (() -> Void)?) -> BottomSheet {
            bottomSheetViewController.actionsAxis = .horizontal
            bottomSheetViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    self.bottomSheetViewController.dismiss(animated: true) {
                        actionNegative?()
                    }
                }
            })
            bottomSheetViewController.actions.append(Ocean.Button.primaryMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.bottomSheetViewController.dismiss(animated: true) {
                        actionPositive?()
                    }
                }
            })
            return self
        }
        
        public func withActionPrimary(text: String, action: (() -> Void)?) -> BottomSheet {
            bottomSheetViewController.actionsAxis = .vertical
            bottomSheetViewController.actions.append(Ocean.Button.primaryBlockedMD { button in
                button.text = text
                button.onTouch = {
                    self.bottomSheetViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public func withActionSecondary(text: String, action: (() -> Void)?) -> BottomSheet {
            bottomSheetViewController.actionsAxis = .vertical
            bottomSheetViewController.actions.append(Ocean.Button.secondaryBlockedMD { button in
                button.text = text
                button.onTouch = {
                    self.bottomSheetViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public func withCode(_ code: String?) -> BottomSheet {
            bottomSheetViewController.contentCode = code
            return self
        }
        
        public func build() -> BottomSheetViewController {
            self.bottomSheetViewController.makeView()
            return bottomSheetViewController
        }
    }
}
