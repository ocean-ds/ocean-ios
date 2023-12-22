//
//  OceanSwiftUI+InputTextField.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 22/12/23.
//

import SwiftUI
import OceanTokens
import Combine

extension OceanSwiftUI {

    // MARK: Parameters

    public class InputTextFieldParameters: ObservableObject {
        @Published public var title: String
        @Published public var placeholder: String
        @Published public var text: String
        @Published public var isSecureTextEntry: Bool
        @Published public var errorMessage: String
        @Published public var helperMessage: String
        @Published public var tooltipMessage: String
        @Published public var icon: UIImage?
        @Published public var iconHelper: UIImage?
        @Published public var keyboardType: UIKeyboardType
        @Published public var textContentType: UITextContentType?
        @Published public var onMask: ((String) -> String)?
        @Published public var onValueChanged: (String) -> Void

        public init(title: String = "",
                    placeholder: String = "",
                    text: String = "",
                    isSecureTextEntry: Bool = false,
                    errorMessage: String = "",
                    helperMessage: String = "",
                    tooltipMessage: String = "",
                    icon: UIImage? = nil,
                    iconHelper: UIImage? = nil,
                    keyboardType: UIKeyboardType = .default,
                    textContentType: UITextContentType? = nil,
                    onMask: ((String) -> String)? = nil,
                    onValueChanged: @escaping (String) -> Void = { _ in }) {
            self.title = title
            self.placeholder = placeholder
            self.text = text
            self.isSecureTextEntry = isSecureTextEntry
            self.errorMessage = errorMessage
            self.helperMessage = helperMessage
            self.tooltipMessage = tooltipMessage
            self.icon = icon
            self.iconHelper = iconHelper
            self.keyboardType = keyboardType
            self.textContentType = textContentType
            self.onMask = onMask
            self.onValueChanged = onValueChanged
        }
    }

    public struct InputTextField: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (InputTextField) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: InputTextFieldParameters

        // MARK: Properties private

        @State private var focused: Bool = false
        @State private var textOld: String = ""

        // MARK: Constructors

        public init(parameters: InputTextFieldParameters = InputTextFieldParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        private var textFieldView: some View {
            Group {
                if self.parameters.isSecureTextEntry {
                    SecureField(self.parameters.placeholder, text: self.$parameters.text, onCommit: { self.focused = false })
                        .onTapGesture {
                            self.focused = true
                        }
                        .onReceive(Just(self.parameters.text), perform: { text in
                            let textMask = self.parameters.onMask?(text) ?? text
                            if textMask != self.textOld {
                                self.parameters.text = textMask
                                self.textOld = textMask
                                self.parameters.onValueChanged(textMask)
                            }
                        })
                } else {
                    TextField(self.parameters.placeholder, text: self.$parameters.text, onEditingChanged: { edit in
                        self.focused = edit
                    })
                    .onReceive(Just(self.parameters.text), perform: { text in
                        let textMask = self.parameters.onMask?(text) ?? text
                        if textMask != self.textOld {
                            self.parameters.text = textMask
                            self.textOld = textMask
                            self.parameters.onValueChanged(textMask)
                        }
                    })
                }
            }
        }

        public var body: some View {
            VStack(alignment: .leading) {
                if !self.parameters.title.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.title
                    }
                    Spacer().frame(height: Ocean.size.spacingStackXxs)
                }

                textFieldView
                    .keyboardType(self.parameters.keyboardType)
                    .textContentType(self.parameters.textContentType)
                    .frame(height: 48)
                    .padding([.leading, .trailing], Ocean.size.spacingStackXs)
                    .padding([.top, .bottom], 2)
                    .background(
                        RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                            .overlay(
                                RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                                    .strokeBorder(Color(self.focused ? Ocean.color.colorBrandPrimaryDown :
                                                            Ocean.color.colorInterfaceLightDeep),
                                                  lineWidth: 1))
                            .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                    )
                    .font(Font(UIFont.baseRegular(size: Ocean.font.fontSizeXs)!))
                    .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
            }
        }

        // MARK: Methods private
    }
}
