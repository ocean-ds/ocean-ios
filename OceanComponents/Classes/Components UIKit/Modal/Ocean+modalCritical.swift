//
//  Ocean+modalCritical.swift
//  OceanComponents
//
//  Created by Vini on 21/07/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class ModalCritical: Modal {
        public override func withAction(textNegative: String,
                        actionNegative: (() -> Void)?,
                        textPositive: String,
                        actionPositive: (() -> Void)?) -> Modal {
            modalViewController.actionsAxis = .horizontal
            modalViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true, wasClosed: false) {
                        actionNegative?()
                    }
                }
            })
            modalViewController.actions.append(Ocean.Button.primaryCriticalMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true, wasClosed: false) {
                        actionPositive?()
                    }
                }
            })
            return self
        }
        
        public override func withActionPrimary(text: String, action: (() -> Void)?) -> Modal {
            modalViewController.actionsAxis = .vertical
            modalViewController.actions.append(Ocean.Button.primaryCriticalBlockedMD { button in
                button.text = text
                button.onTouch = {
                    self.modalViewController.dismiss(animated: true, wasClosed: false) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public override func build() -> ModalViewController {
            self.modalViewController.contentIsCritical = true
            self.modalViewController.makeView()
            return modalViewController
        }
    }
}
