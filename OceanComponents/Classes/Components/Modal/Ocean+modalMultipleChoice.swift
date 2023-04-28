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
        private var modalMultipleChoiceViewController: ModelMultipleChoiceViewController
        
        public init(_ rootViewController: UIViewController) {
            modalMultipleChoiceViewController = ModelMultipleChoiceViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> ModalMultiChoice {
            modalMultipleChoiceViewController.swipeDismiss = value
            return self
        }
        
        public func withTitle(_ title: String?) -> ModalMultiChoice {
            modalMultipleChoiceViewController.contentTitle = title
            return self
        }
        
        public func withMultipleOptions(_ values: [CellModel]) -> ModalMultiChoice {
            modalMultipleChoiceViewController.contenteMultipleOptions = values
            return self
        }
        
        public func withAction(textNegative: String,
                               actionNegative: (() -> Void)?,
                               textPositive: String,
                               actionPositive: (([CellModel]) -> Void)?) -> ModalMultiChoice {
            modalMultipleChoiceViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    self.modalMultipleChoiceViewController.dismiss(animated: true) {
                        actionNegative?()
                    }
                }
            })
            modalMultipleChoiceViewController.actions.append(Ocean.Button.primaryMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.modalMultipleChoiceViewController.dismiss(animated: true) {
                        let selectedOption = self.modalMultipleChoiceViewController.getOptionSelected()
                                                actionPositive?(selectedOption)
                    }
                }
            })
            return self
        }
        
        public func build() -> ModelMultipleChoiceViewController {
            self.modalMultipleChoiceViewController.makeView()
            return modalMultipleChoiceViewController
        }
    }
}
