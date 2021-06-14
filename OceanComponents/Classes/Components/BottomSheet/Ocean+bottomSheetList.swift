//
//  Ocean+bottomSheetList.swift
//  OceanComponents
//
//  Created by Vini on 14/06/21.
//

import UIKit
import OceanTokens

extension Ocean {
    public class BottomSheetList {
        private var bottomSheetViewController: BottomSheetViewController
        
        public init(_ rootViewController: UIViewController) {
            bottomSheetViewController = BottomSheetViewController(rootViewController)
        }
        
        public func withDismiss(_ value: Bool) -> BottomSheetList {
            bottomSheetViewController.swipeDismiss = value
            return self
        }
        
        public func withTitle(_ title: String?) -> BottomSheetList {
            bottomSheetViewController.contentTitle = title
            return self
        }
        
        public func withValues(_ values: [CellModel]) -> BottomSheetList {
            bottomSheetViewController.contentValues = values
            return self
        }
        
        public func build() -> BottomSheetViewController {
            DispatchQueue.main.async {
                self.bottomSheetViewController.makeView()
            }
            
            return bottomSheetViewController
        }
    }
}
