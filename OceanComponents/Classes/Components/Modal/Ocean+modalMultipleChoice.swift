//
//  Ocean+modalMultipleChoice.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 19/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class ModalMultiChoice {
        private var modalListViewController: ModelMultipleChoiceViewController
        
        public init(_ rootViewController: UIViewController) {
            modalListViewController = ModelMultipleChoiceViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> ModalMultiChoice {
            modalListViewController.swipeDismiss = value
            return self
        }
        
        public func withTitle(_ title: String?) -> ModalMultiChoice {
            modalListViewController.contentTitle = title
            return self
        }
        
        public func withMultipleOptions(_ values: [CellModel]) -> ModalMultiChoice {
            modalListViewController.contenteMultipleOptions = values
            return self
        }
        
        public func withAction(textNegative: String,
                               actionNegative: (() -> Void)?,
                               textPositive: String,
                               actionPositive: (([CellModel]) -> Void)?) -> ModalMultiChoice {
            modalListViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    self.modalListViewController.dismiss(animated: true) {
                        actionNegative?()
                    }
                }
            })
            modalListViewController.actions.append(Ocean.Button.primaryMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.modalListViewController.dismiss(animated: true) {
                        let selectedOption = self.modalListViewController.optionSelected()
                                                actionPositive?(selectedOption)
                    }
                }
            })
            return self
        }
        
        public func build() -> ModelMultipleChoiceViewController {
            self.modalListViewController.makeView()
            return modalListViewController
        }
    }
}
