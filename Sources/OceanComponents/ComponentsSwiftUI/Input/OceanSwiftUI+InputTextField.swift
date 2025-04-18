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
        @Published public var titleColor: UIColor
        @Published public var placeholder: String
        @Published public var text: String
        @Published public var style: Style
        @Published public var icon: UIImage?
        @Published public var errorMessage: String
        @Published public var errorMessageColor: UIColor
        @Published public var helperMessage: String
        @Published public var iconHelper: UIImage?
        @Published public var keyboardType: UIKeyboardType
        @Published public var autocapitalization: UITextAutocapitalizationType
        @Published public var autocorrectionDisabled: Bool
        @Published public var textContentType: UITextContentType?
        @Published public var maxLength: Int?
        @Published public var showMaxLength: Bool
        @Published public var isDisabled: Bool
        @Published public var showSkeleton: Bool
        @Published public var reserveMessageHeight: Bool
        @Published public var isFocused: Bool
        @Published public var selectAllFocusedText: Bool
        public var onMask: ((String) -> String)?
        public var onValueChanged: (String) -> Void
        public var onEditingChanged: (Bool) -> Void
        public var onFocusChanged: (Bool) -> Void
        public var onTouchIcon: () -> Void
        public var onTouchIconHelper: () -> Void

        public init(title: String = "",
                    titleColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    placeholder: String = "",
                    text: String = "",
                    style: Style = .input,
                    icon: UIImage? = nil,
                    errorMessage: String = "",
                    errorMessageColor: UIColor = Ocean.color.colorStatusNegativePure,
                    helperMessage: String = "",
                    iconHelper: UIImage? = nil,
                    keyboardType: UIKeyboardType = .default,
                    autocapitalization: UITextAutocapitalizationType = .words,
                    autocorrectionDisabled: Bool = false,
                    textContentType: UITextContentType? = nil,
                    maxLength: Int? = nil,
                    showMaxLength: Bool = false,
                    isDisabled: Bool = false,
                    showSkeleton: Bool = false,
                    reserveMessageHeight: Bool = true,
                    isFocused: Bool = true,
                    selectAllFocusedText: Bool = false,
                    onMask: ((String) -> String)? = nil,
                    onValueChanged: @escaping (String) -> Void = { _ in },
                    onEditingChanged: @escaping (Bool) -> Void = { _ in },
                    onFocusChanged: @escaping (Bool) -> Void = { _ in },
                    onTouchIcon: @escaping () -> Void = { },
                    onTouchIconHelper: @escaping () -> Void = { }) {
            self.title = title
            self.titleColor = titleColor
            self.placeholder = placeholder
            self.text = text
            self.style = style
            self.icon = icon
            self.errorMessage = errorMessage
            self.errorMessageColor = errorMessageColor
            self.helperMessage = helperMessage
            self.iconHelper = iconHelper
            self.keyboardType = keyboardType
            self.autocapitalization = autocapitalization
            self.autocorrectionDisabled = autocorrectionDisabled
            self.textContentType = textContentType
            self.maxLength = maxLength
            self.showMaxLength = showMaxLength
            self.isDisabled = isDisabled
            self.showSkeleton = showSkeleton
            self.reserveMessageHeight = reserveMessageHeight
            self.isFocused = isFocused
            self.selectAllFocusedText = selectAllFocusedText
            self.onMask = onMask
            self.onValueChanged = onValueChanged
            self.onEditingChanged = onEditingChanged
            self.onFocusChanged = onFocusChanged
            self.onTouchIcon = onTouchIcon
            self.onTouchIconHelper = onTouchIconHelper
        }

        public enum Style {
            case input
            case inputSearch
            case secureText
            case textArea
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

            UITextView.appearance().backgroundColor = .clear
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
            self.textOld = parameters.text
        }

        // MARK: View SwiftUI

        private var textFieldView: some View {
            Group {
                if #available(iOS 15.0, *) {
                    FocusWrapper(
                        requestFocus: Binding(
                            get: { self.parameters.isFocused },
                            set: { self.parameters.isFocused = $0 }
                        ),
                        selectAllFocusedText: self.parameters.selectAllFocusedText,
                        onFocusChanged: { newValue in
                            self.focused = newValue
                            self.parameters.onFocusChanged(newValue)

                            if parameters.selectAllFocusedText, newValue {
                                selectAllText()
                            }
                        }
                    ) { focusBinding in
                        baseTextFieldView
                            .focused(focusBinding)
                    }
                } else {
                    baseTextFieldView
                }
            }
        }

        private var baseTextFieldView: some View {
            Group {
                switch self.parameters.style {
                case .input:
                    TextField(self.parameters.placeholder, text: self.$parameters.text, onEditingChanged: { edit in
                        self.focused = edit
                        self.parameters.onEditingChanged(edit)
                    })
                case .inputSearch:
                    HStack {
                        Image(uiImage: Ocean.icon.searchOutline)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color(getSearchIconColor()))

                        TextField(self.parameters.placeholder, text: self.$parameters.text, onEditingChanged: { edit in
                            self.focused = edit
                            self.parameters.onEditingChanged(edit)
                        })

                        Spacer()

                        if !parameters.text.isEmpty {
                            Image(uiImage: Ocean.icon.xSolid)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color(Ocean.color.colorInterfaceLightDeep))
                                .onTapGesture {
                                    parameters.text = ""
                                    parameters.onValueChanged("")
                                }
                        }
                    }
                case .secureText:
                    SecureField(self.parameters.placeholder, text: self.$parameters.text, onCommit: { self.focused = false })
                        .onTapGesture {
                            self.focused = true
                        }
                case .textArea:
                    if #available(iOS 14.0, *) {
                        ZStack(alignment: .topLeading) {
                            if self.parameters.text.isEmpty && !self.parameters.placeholder.isEmpty {
                                OceanSwiftUI.Typography.paragraph { label in
                                    label.parameters.text = self.parameters.placeholder
                                    label.parameters.textColor = Ocean.color.colorInterfaceLightDeep
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, Ocean.size.spacingStackXxxs)
                            }

                            if #available(iOS 16.0, *) {
                                TextEditor(text: self.$parameters.text)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .frame(height: 88)
                                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                                        self.focused = true
                                        self.parameters.onEditingChanged(true)
                                    }
                                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                                        self.focused = false
                                        self.parameters.onEditingChanged(false)
                                    }
                            } else {
                                TextEditor(text: self.$parameters.text)
                                    .frame(height: 88)
                                    .background(Color.clear)
                                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                                        self.focused = true
                                        self.parameters.onEditingChanged(true)
                                    }
                                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                                        self.focused = false
                                        self.parameters.onEditingChanged(false)
                                    }
                            }
                        }
                    } else {
                        TextField(self.parameters.placeholder, text: self.$parameters.text, onEditingChanged: { edit in
                            self.focused = edit
                            self.parameters.onEditingChanged(edit)
                        })
                    }
                }
            }
            .disabled(self.parameters.isDisabled)
            .autocapitalization(self.parameters.autocapitalization)
            .autocorrectionDisabled(self.parameters.autocorrectionDisabled)
            .onReceive(Just(self.parameters.text), perform: { text in
                var textMask = self.parameters.onMask?(text) ?? text
                if textMask != self.textOld || text != self.textOld {
                    if let maxLength = self.parameters.maxLength {
                        textMask = String(textMask.prefix(maxLength))
                    }

                    self.textOld = textMask
                    self.parameters.text = textMask
                    self.parameters.errorMessage = ""
                    self.parameters.onValueChanged(textMask)
                }
            })
        }

        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                if !self.parameters.title.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.title
                        label.parameters.textColor = self.parameters.isDisabled ? Ocean.color.colorInterfaceLightDeep : self.parameters.titleColor
                        label.parameters.showSkeleton = self.parameters.showSkeleton
                    }
                    Spacer().frame(height: Ocean.size.spacingStackXxs)
                }

                ZStack(alignment: .trailing) {
                    textFieldView
                        .keyboardType(self.parameters.keyboardType)
                        .textContentType(self.parameters.textContentType)
                        .frame(height: self.parameters.style == .textArea ? 90 : 48)
                        .padding([.leading, .trailing], Ocean.size.spacingStackXs)
                        .padding([.top, .bottom], 2)
                        .background(
                            RoundedRectangle(cornerRadius: Ocean.size.borderRadiusSm)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Ocean.size.borderRadiusSm)
                                        .strokeBorder(Color(getBorderColor()),
                                                      lineWidth: 1))
                                .foregroundColor(Color(self.parameters.isDisabled ? Ocean.color.colorInterfaceLightUp : Ocean.color.colorInterfaceLightPure))
                        )
                        .font(Font(UIFont.baseRegular(size: Ocean.font.fontSizeXs)!))
                        .foregroundColor(Color(self.parameters.isDisabled ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDeep))
                        .oceanSkeleton(isActive: self.parameters.showSkeleton,
                                       shape: .rounded(.radius(Ocean.size.borderRadiusMd,
                                                               style: .continuous)))

                    if let icon = self.parameters.icon, !parameters.showSkeleton {
                        Image(uiImage: icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding(.trailing, Ocean.size.spacingStackXs)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                            .onTapGesture {
                                self.parameters.onTouchIcon()
                            }
                    }
                }

                Spacer()
                    .frame(height: Ocean.size.spacingStackXxxs)

                HStack(alignment: .center) {
                    if !self.parameters.errorMessage.isEmpty {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.errorMessage
                            label.parameters.textColor = self.parameters.errorMessageColor
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    } else if let maxLength = self.parameters.maxLength,
                              self.parameters.showMaxLength,
                              !self.parameters.text.isEmpty {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = "Caracteres restantes: \(self.parameters.text.count)/\(maxLength)"
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
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
                                .oceanSkeleton(isActive: self.parameters.showSkeleton)
                        }
                    }
                }
                .frame(minHeight: parameters.reserveMessageHeight ? Ocean.size.spacingStackXs : 0)
                .opacity(self.parameters.errorMessage.isEmpty && self.parameters.helperMessage.isEmpty && !self.parameters.showMaxLength ? 0 : 1)

                Spacer()
                    .frame(height: Ocean.size.spacingStackXxxs)
            }
        }

        // MARK: Methods private

        private func getBorderColor() -> UIColor {
            if self.parameters.isDisabled {
                return Ocean.color.colorInterfaceLightUp
            } else if !self.parameters.errorMessage.isEmpty {
                return Ocean.color.colorStatusNegativePure
            } else if self.focused {
                return Ocean.color.colorBrandPrimaryDown
            } else if !self.parameters.text.isEmpty {
                return Ocean.color.colorBrandPrimaryUp
            } else {
                return Ocean.color.colorInterfaceLightDeep
            }
        }

        private func getSearchIconColor() -> UIColor {
            if self.parameters.isDisabled {
                return Ocean.color.colorInterfaceLightDeep
            } else if self.focused {
                return Ocean.color.colorBrandPrimaryPure
            } else if !self.parameters.text.isEmpty {
                return Ocean.color.colorBrandPrimaryDown
            } else {
                return Ocean.color.colorInterfaceLightDeep
            }
        }

        private func selectAllText() {
            DispatchQueue.main.async {
                UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
            }
        }
    }
}
