//
//  Ocean+modalList.swift
//  OceanComponents
//
//  Created by Vini on 14/06/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class ModalList {
        private var modalListViewController: ModalListViewController
        
        public init(_ rootViewController: UIViewController) {
            modalListViewController = ModalListViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> ModalList {
            modalListViewController.swipeDismiss = value
            return self
        }
        
        public func withTitle(_ title: String?) -> ModalList {
            modalListViewController.contentTitle = title
            return self
        }
        
        public func withValues(_ values: [CellModel]) -> ModalList {
            modalListViewController.contentValues = values
            return self
        }
        
        public func withPrimaryButton(_ text: String,
                                      icon: UIImage? = nil,
                                      action: (() -> Void)? = nil) -> ModalList {
            
            if icon == nil {
                print("SWPOCAS -> Icon is nil for primary")
            }
            
//            modalListViewController.bottomPrimaryButton.text = title
//            modalListViewController.bottomPrimaryButton.icon = icon
//            modalListViewController.bottomPrimaryButton.isHidden = false
//            modalListViewController.onPrimaryAction = action
            modalListViewController.addPrimaryButton(text: text, icon: icon, action: action)
            return self
        }
        
        public func withSecondaryButton(_ text: String,
                                        icon: UIImage? = nil,
                                        action: (() -> Void)? = nil) -> ModalList {
            
            if icon == nil {
                print("SWPOCAS -> Icon is nil for secondary")
            }
            
//            modalListViewController.bottomSecondaryButton.text = title
//            modalListViewController.bottomSecondaryButton.icon = icon
//            modalListViewController.bottomSecondaryButton.isHidden = false
//            modalListViewController.onSecondaryAction = action
            
            modalListViewController.addSecondaryButton(text: text, icon: icon, action: action)
            return self
        }
        
        public func build() -> ModalListViewController {
            self.modalListViewController.makeView()
            return modalListViewController
        }
    }
}
