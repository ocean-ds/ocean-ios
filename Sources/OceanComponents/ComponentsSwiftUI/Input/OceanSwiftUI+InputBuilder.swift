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

        public static func searchField(builder: OceanSwiftUI.InputTextField.Builder? = nil) -> OceanSwiftUI.InputTextField {
            return OceanSwiftUI.InputTextField { input in
                input.parameters.style = .inputSearch
                builder?(input)
            }
        }

        public static func secureText(builder: OceanSwiftUI.InputTextField.Builder? = nil) -> OceanSwiftUI.InputTextField {
            return OceanSwiftUI.InputTextField { input in
                input.parameters.style = .secureText
                builder?(input)
            }
        }

        public static func textArea(builder: OceanSwiftUI.InputTextField.Builder? = nil) -> OceanSwiftUI.InputTextField {
            return OceanSwiftUI.InputTextField { input in
                input.parameters.style = .textArea
                builder?(input)
            }
        }

        public static func selectField(builder: OceanSwiftUI.InputSelectField.Builder? = nil) -> OceanSwiftUI.InputSelectField {
            return OceanSwiftUI.InputSelectField { input in
                builder?(input)
            }
        }

        public static func tokenField(builder: OceanSwiftUI.InputTokenField.Builder? = nil) -> OceanSwiftUI.InputTokenField {
            return OceanSwiftUI.InputTokenField { input in
                builder?(input)
            }
        }
    }
}
