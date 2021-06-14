//
//  Ocean+textarea.swift
//  OceanComponents
//
//  Created by Alex Gomes on 06/08/20.
//

import Foundation
import OceanTokens

extension Ocean {
    public typealias TextAreaBuilder = (TextArea) -> Void
    public typealias InputTextFieldBuilder = (InputTextField) -> Void
    public typealias InputSelectFieldBuilder = (InputSelectField) -> Void
    
    public struct Input {
        public static func textarea(builder: TextAreaBuilder) -> TextArea {
            return TextArea { textArea in
                textArea.placeholder = "TextArea"
                builder(textArea)
            }
        }
        
        public static func textareaWithLabel(builder: TextAreaBuilder) -> TextArea {
            return TextArea { textArea in
                textArea.title = "Label"
                textArea.placeholder = "TextArea"
                builder(textArea)
            }
        }
        
        public static func textfield(builder: InputTextFieldBuilder) -> InputTextField {
            return InputTextField { inputText in
                inputText.placeholder = "inputText"
                builder(inputText)
            }
        }
        
        public static func textfieldWithLabel(builder: InputTextFieldBuilder) -> InputTextField {
            return InputTextField { inputText in
                inputText.title = "Label"
                inputText.placeholder = "inputText"
                builder(inputText)
            }
        }
        
        public static func select(builder: InputSelectFieldBuilder) -> InputSelectField {
            return InputSelectField { inputSelect in
                inputSelect.placeholder = "inputSelect"
                builder(inputSelect)
            }
        }
        
        public static func selectWithLabel(builder: InputSelectFieldBuilder) -> InputSelectField {
            return InputSelectField { inputSelect in
                inputSelect.title = "Label"
                inputSelect.placeholder = "inputSelect"
                builder(inputSelect)
            }
        }
    }
}
