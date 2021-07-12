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
        public var titleBottomSheet: String?
        public var values: [String] = []
        public var maxValues: Int? = nil
        public var placeholderFilter: String?
        
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
            self.image = Ocean.icon.chevronDownSolid
        }
        
        @objc func inputSelectorAction(_ sender: Any) {
            if let rootViewController = rootViewController {
                rootViewController.view.endEditing(true)
                
                var model: [CellModel]
                
                if let maxValues = self.maxValues {
                    model = self.values.prefix(maxValues).compactMap { value in
                        CellModel(title: value, isSelected: self.text == value)
                    }
                    model.append(CellModel(title: "Ver todos", isSelected: false))
                } else {
                    model = self.values.compactMap { value in
                        CellModel(title: value, isSelected: self.text == value)
                    }
                }
                
                let bottomSheetList = BottomSheetList(rootViewController)
                    .withTitle(self.titleBottomSheet)
                    .withValues(model)
                    .build()
                
                bottomSheetList.onValueSelected = { value in
                    if value.title == "Ver todos" {
                        let values = self.values.compactMap { value in
                            CellModel(title: value, isSelected: self.text == value)
                        }
                        let filterViewController = FilterViewController(title: self.titleBottomSheet,
                                                                        placeholder: self.placeholderFilter,
                                                                        values: values)
                        filterViewController.onValueSelected = { filterValue in
                            self.text = filterValue.title
                            self.onValueChanged?(self.text)
                        }
                        let navigationController = UINavigationController(rootViewController: filterViewController)
                        navigationController.modalTransitionStyle = .coverVertical
                        navigationController.modalPresentationStyle = .overFullScreen
                        rootViewController.present(navigationController, animated: true, completion: nil)
                    } else {
                        self.text = value.title
                        self.onValueChanged?(self.text)
                    }
                }
                
                bottomSheetList.show()
            }
        }
    }
}
