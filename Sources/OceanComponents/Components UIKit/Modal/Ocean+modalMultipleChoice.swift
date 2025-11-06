//
//  Ocean+modalMultipleChoice.swift
//  FSCalendar
//
//  Created by Acassio Mendonça on 19/04/23.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    public class ModalMultipleChoice {
        private var modalMultipleChoiceViewController: ModelMultipleChoiceViewController
        
        public init(_ rootViewController: UIViewController) {
            modalMultipleChoiceViewController = ModelMultipleChoiceViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> ModalMultipleChoice {
            modalMultipleChoiceViewController.swipeDismiss = value
            return self
        }
        
        public func withTitle(_ title: String?) -> ModalMultipleChoice {
            modalMultipleChoiceViewController.contentTitle = title
            return self
        }
        
        public func withMultipleOptions(_ values: [CellModel], textIsRightForMultipleChoice: Bool = true) -> ModalMultipleChoice {
            modalMultipleChoiceViewController.contentMultipleOptions = values
            modalMultipleChoiceViewController.optionTextIsRight = textIsRightForMultipleChoice
            return self
        }
        
        public func withAction(textNegative: String,
                               actionNegative: (() -> Void)?,
                               textPositive: String,
                               actionPositive: (([CellModel]) -> Void)?) -> ModalMultipleChoice {
            modalMultipleChoiceViewController.actions.append(Ocean.Button.secondaryMD { button in
                button.text = textNegative
                button.onTouch = {
                    self.modalMultipleChoiceViewController.dismiss(animated: true, wasClosed: false) {
                        actionNegative?()
                    }
                }
            })
            modalMultipleChoiceViewController.actions.append(Ocean.Button.primaryMD { button in
                button.text = textPositive
                button.onTouch = {
                    self.modalMultipleChoiceViewController.dismiss(animated: true, wasClosed: false) {
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
