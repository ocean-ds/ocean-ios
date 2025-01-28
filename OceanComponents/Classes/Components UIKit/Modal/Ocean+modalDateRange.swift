//
//  Ocean+modalDateRange.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 23/01/25.
//

import UIKit
import OceanTokens

extension Ocean {
    public class ModalDateRange {
        private var modalViewController: ModalDateRangeViewController

        public init(_ rootViewController: UIViewController) {
            modalViewController = ModalDateRangeViewController(rootViewController)
        }

        public func withDismiss(_ value: Bool) -> ModalDateRange {
            modalViewController.swipeDismiss = value
            return self
        }

        public func withTitle(_ title: String?) -> ModalDateRange {
            modalViewController.contentTitle = title
            return self
        }

        public func withBeginDate(_ date: Date?) -> ModalDateRange {
            modalViewController.beginDate = date
            return self
        }

        public func withEndDate(_ date: Date?) -> ModalDateRange {
            modalViewController.endDate = date
            return self
        }

        public func withCompletion(_ completion: @escaping (Date?, Date?) -> ()) -> ModalDateRange {
            modalViewController.onFilter = completion
            return self
        }

        public func build() -> ModalDateRangeViewController {
            self.modalViewController.makeView()
            return modalViewController
        }
    }
}
