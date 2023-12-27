//
//  OceanSwiftUI+InputBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 27/12/23.
//

import OceanTokens

extension OceanSwiftUI {
    public struct Input {
        public static func textField(builder: OceanSwiftUI.InputTextField.Builder? = nil) -> OceanSwiftUI.InputTextField {
            return OceanSwiftUI.InputTextField { input in
                builder?(input)
            }
        }
    }
}
