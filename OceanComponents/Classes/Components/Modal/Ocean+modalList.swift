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
        
        public func withActionPrimary(text: String, icon: UIImage? = nil, action: (() -> Void)?) -> ModalList {
            modalListViewController.actionsAxis = .vertical
            modalListViewController.actions.append(Ocean.Button.primaryBlockedMD { button in
                button.text = text
                button.icon = icon
                button.onTouch = {
                    self.modalListViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public func withActionSecondary(text: String, icon: UIImage? = nil, action: (() -> Void)?) -> ModalList {
            modalListViewController.actionsAxis = .vertical
            modalListViewController.actions.append(Ocean.Button.secondaryBlockedMD { button in
                button.text = text
                button.icon = icon
                button.onTouch = {
                    self.modalListViewController.dismiss(animated: true) {
                        action?()
                    }
                }
            })
            return self
        }
        
        public func build() -> ModalListViewController {
            self.modalListViewController.makeView()
            return modalListViewController
        }
    }
}
