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
        @Published public var icon: UIImage?
        @Published public var iconHelper: UIImage?
        @Published public var keyboardType: UIKeyboardType
        @Published public var autocapitalization: UITextAutocapitalizationType
        @Published public var textContentType: UITextContentType?
        @Published public var showSkeleton: Bool
        @Published public var onMask: ((String) -> String)?
        @Published public var onValueChanged: (String) -> Void
        public var onTouchIcon: () -> Void
        public var onTouchIconHelper: () -> Void

        public init(title: String = "",
                    placeholder: String = "",
                    text: String = "",
                    isSecureTextEntry: Bool = false,
                    errorMessage: String = "",
                    helperMessage: String = "",
                    icon: UIImage? = nil,
                    iconHelper: UIImage? = nil,
                    keyboardType: UIKeyboardType = .default,
                    autocapitalization: UITextAutocapitalizationType = .allCharacters,
                    textContentType: UITextContentType? = nil,
                    showSkeleton: Bool = false,
                    onMask: ((String) -> String)? = nil,
                    onValueChanged: @escaping (String) -> Void = { _ in },
                    onTouchIcon: @escaping () -> Void = { },
                    onTouchIconHelper: @escaping () -> Void = { }) {
            self.title = title
            self.placeholder = placeholder
            self.text = text
            self.isSecureTextEntry = isSecureTextEntry
            self.errorMessage = errorMessage
            self.helperMessage = helperMessage
            self.icon = icon
            self.iconHelper = iconHelper
            self.keyboardType = keyboardType
            self.autocapitalization = autocapitalization
            self.textContentType = textContentType
            self.showSkeleton = showSkeleton
            self.onMask = onMask
            self.onValueChanged = onValueChanged
            self.onTouchIcon = onTouchIcon
            self.onTouchIconHelper = onTouchIconHelper
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
            self.textOld = parameters.text
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
                } else {
                    TextField(self.parameters.placeholder, text: self.$parameters.text, onEditingChanged: { edit in
                        self.focused = edit
                    })
                }
            }
            .autocapitalization(self.parameters.autocapitalization)
            .onReceive(Just(self.parameters.text), perform: { text in
                let textMask = self.parameters.onMask?(text) ?? text
                if textMask != self.textOld || text != self.textOld {
                    self.textOld = textMask
                    self.parameters.text = textMask
                    self.parameters.errorMessage = ""
                    self.parameters.onValueChanged(textMask)
                }
            })
        }

        public var body: some View {
            VStack(alignment: .leading) {
                if !self.parameters.title.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.title
                        label.parameters.showSkeleton = self.parameters.showSkeleton
                    }
                    Spacer().frame(height: Ocean.size.spacingStackXxs)
                }

                ZStack(alignment: .trailing) {
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
                                        .strokeBorder(Color(!self.parameters.errorMessage.isEmpty ? Ocean.color.colorStatusNegativePure :
                                                                self.focused ? Ocean.color.colorBrandPrimaryDown : Ocean.color.colorInterfaceLightDeep),
                                                      lineWidth: 1))
                                .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                        )
                        .font(Font(UIFont.baseRegular(size: Ocean.font.fontSizeXs)!))
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
                        .skeleton(with: self.parameters.showSkeleton)

                    if let icon = self.parameters.icon {
                        Image(uiImage: icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding(.trailing, Ocean.size.spacingStackXs)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                            .onTapGesture {
                                self.parameters.onTouchIcon()
                            }
                            .skeleton(with: self.parameters.showSkeleton)
                    }
                }

                HStack {
                    if !self.parameters.errorMessage.isEmpty {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.errorMessage
                            label.parameters.textColor = Ocean.color.colorStatusNegativePure
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    } else if !self.parameters.helperMessage.isEmpty {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.helperMessage
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }

                        Spacer().frame(width: Ocean.size.spacingStackXxxs)

                        if let icon = self.parameters.iconHelper {
                            Image(uiImage: icon)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 16, height: 16, alignment: .center)
                                .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                                .onTapGesture {
                                    self.parameters.onTouchIconHelper()
                                }
                                .skeleton(with: self.parameters.showSkeleton)
                        }
                    }
                }
                .frame(height: 16)
                .opacity(self.parameters.errorMessage.isEmpty && self.parameters.helperMessage.isEmpty ? 0 : 1)
            }
        }

        // MARK: Methods private
    }
}
