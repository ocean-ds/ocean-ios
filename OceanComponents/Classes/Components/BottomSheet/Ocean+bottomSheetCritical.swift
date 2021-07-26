//
//  Ocean+bottomSheetCritical.swift
//  OceanComponents
//
//  Created by Vini on 21/07/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class BottomSheetCritical: BottomSheet {
        public override func withAction(textNegative: String,
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
            bottomSheetViewController.actions.append(Ocean.Button.primaryCriticalMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.bottomSheetViewController.dismiss(animated: true) {
                        actionPositive?()
                    }
                }
            })
            return self
        }
        
        public override func withActionPrimary(text: String, action: (() -> Void)?) -> BottomSheet {
            bottomSheetViewController.actionsAxis = .vertical
            bottomSheetViewController.actions.append(Ocean.Button.primaryCriticalBlockedMD { button in
                button.text = text
                button.onTouch = {
                    self.bottomSheetViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public override func build() -> BottomSheetViewController {
            self.bottomSheetViewController.contentIsCritical = true
            self.bottomSheetViewController.makeView()
            return bottomSheetViewController
        }
    }
}
