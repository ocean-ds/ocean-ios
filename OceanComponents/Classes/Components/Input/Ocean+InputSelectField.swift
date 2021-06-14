//
//  Ocean+InputSelectField.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class InputSelectField: InputTextField {
        public var rootViewController: UIViewController?
        public var values: [String] = []
        
        public convenience init(builder: InputSelectFieldBuilder) {
            self.init()
            builder(self)
            makeView()
        }
        
        override func makeTextField() {
            super.makeTextField()
            textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(inputSelectorAction)))
        }
        
        override func makeView() {
            super.makeView()
            self.image = Ocean.icon.chevronDownSm
        }
        
        @objc func inputSelectorAction(_ sender: Any) {
            if let rootViewController = rootViewController {
                let model = values.compactMap { value in
                    CellModel(value: value, isSelected: self.text == value)
                }
                
                let bottomSheetList = BottomSheetList(rootViewController)
                    .withTitle(self.title)
                    .withValues(model)
                    .build()
                
                bottomSheetList.onValueSelected = { value in
                    self.text = value.value
                }
                
                bottomSheetList.show()
            }
        }
    }
}
