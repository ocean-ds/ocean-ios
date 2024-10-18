//
//  OceanSwiftUI+InputTokenField.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 16/02/24.
//

import SwiftUI
import OceanTokens
import Combine

extension OceanSwiftUI {

    // MARK: Parameters

    public class InputTokenFieldParameters: ObservableObject {
        @Published public var title: String
        @Published public var errorMessage: String
        @Published public var helperMessage: String
        @Published public var iconHelper: UIImage?
        @Published public var isDisabled: Bool
        @Published public var showSkeleton: Bool
        @Published public var onValueChanged: (String) -> Void
        public var onTouchIconHelper: () -> Void

        public init(title: String = "",
                    errorMessage: String = "",
                    helperMessage: String = "",
                    iconHelper: UIImage? = nil,
                    isDisabled: Bool = false,
                    showSkeleton: Bool = false,
                    onValueChanged: @escaping (String) -> Void = { _ in },
                    onTouchIconHelper: @escaping () -> Void = { }) {
            self.title = title
            self.errorMessage = errorMessage
            self.helperMessage = helperMessage
            self.iconHelper = iconHelper
            self.isDisabled = isDisabled
            self.showSkeleton = showSkeleton
            self.onValueChanged = onValueChanged
            self.onTouchIconHelper = onTouchIconHelper
        }
    }

    public struct InputTokenField: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (InputTokenField) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: InputTokenFieldParameters

        // MARK: Properties private

        @State private var text1: String = ""
        @State private var text2: String = ""
        @State private var text3: String = ""
        @State private var text4: String = ""
        
        @State private var code: String = ""

        // MARK: Constructors

        public init(parameters: InputTokenFieldParameters = InputTokenFieldParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            //FIX: BUG KEYBOARD @FocusState
            NavigationView(content: {
                VStack(alignment: .leading) {
                    if !self.parameters.title.isEmpty {
                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = self.parameters.title
                            label.parameters.textColor = self.parameters.isDisabled ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDown
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                        Spacer().frame(height: Ocean.size.spacingStackXxs)
                    }

                    if #available(iOS 15.0, *) {
                        InputTokenFieldItemsFocused(text1: self.$text1,
                                                    text2: self.$text2,
                                                    text3: self.$text3,
                                                    text4: self.$text4,
                                                    errorMessage: self.$parameters.errorMessage,
                                                    isDisabled: self.$parameters.isDisabled,
                                                    showSkeleton: self.$parameters.showSkeleton,
                                                    onValueChanged: {
                            self.tryOnValueChanged()
                        }, onClear: {
                            self.code = ""
                        })
                    } else {
                        InputTokenFieldItems(text1: self.$text1,
                                             text2: self.$text2,
                                             text3: self.$text3,
                                             text4: self.$text4,
                                             errorMessage: self.$parameters.errorMessage,
                                             isDisabled: self.$parameters.isDisabled,
                                             showSkeleton: self.$parameters.showSkeleton,
                                             onValueChanged: {
                            self.tryOnValueChanged()
                        }, onClear: {
                            self.code = ""
                        })
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
                                    .oceanSkeleton(with: self.parameters.showSkeleton)
                            }
                        }
                    }
                    .frame(height: 16)
                    .opacity(self.parameters.errorMessage.isEmpty && self.parameters.helperMessage.isEmpty ? 0 : 1)
                }
            })
            .frame(width: 220, height: 100, alignment: .center)
        }

        // MARK: Methods private

        private func tryOnValueChanged() {
            self.parameters.errorMessage = ""
            let code = "\(self.text1)\(self.text2)\(self.text3)\(self.text4)"
            if !self.text1.isEmpty,
               !self.text2.isEmpty,
               !self.text3.isEmpty,
               !self.text4.isEmpty,
               self.code != code {
                self.code = code
                self.parameters.onValueChanged(code)
            }
        }
    }

    @available(iOS 15.0, *)
    public struct InputTokenFieldItemsFocused: View {
        @Binding var text1: String
        @Binding var text2: String
        @Binding var text3: String
        @Binding var text4: String
        @Binding var errorMessage: String
        @Binding var isDisabled: Bool
        @Binding var showSkeleton: Bool
        var onValueChanged: () -> Void
        var onClear: () -> Void

        enum FocusedText {
            case one, two, three, four
        }

        @FocusState private var focused: FocusedText?

        public var body: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                InputTokenFieldItem(text: self.$text1,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    if !verifyOneTimeCode(text: text) {
                        self.text1 = String(text.prefix(1))
                        self.onValueChanged()
                        if self.focused == .one && self.text1.count == 1 {
                            self.focused = .two
                        }
                    }
                }, onClear: {
                    self.onClear()
                })
                .textInputAutocapitalization(.never)
                .focused(self.$focused, equals: .one)

                InputTokenFieldItem(text: self.$text2,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    self.text2 = String(text.prefix(1))
                    self.onValueChanged()
                    if self.focused == .two && self.text2.count == 0 {
                        self.focused = .one
                    } else if self.focused == .two && self.text2.count == 1 {
                        self.focused = .three
                    }
                }, onClear: {
                    self.onClear()
                })
                .textInputAutocapitalization(.never)
                .focused(self.$focused, equals: .two)

                InputTokenFieldItem(text: self.$text3,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    self.text3 = String(text.prefix(1))
                    self.onValueChanged()
                    if self.focused == .three && self.text3.count == 0 {
                        self.focused = .two
                    } else if self.focused == .three && self.text3.count == 1 {
                        self.focused = .four
                    }
                }, onClear: {
                    self.onClear()
                })
                .textInputAutocapitalization(.never)
                .focused(self.$focused, equals: .three)

                InputTokenFieldItem(text: self.$text4,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    self.text4 = String(text.prefix(1))
                    self.onValueChanged()
                    if self.focused == .four && self.text4.count == 0 {
                        self.focused = .three
                    } else if self.focused == .four && self.text4.count == 1 {
                        self.focused = nil
                    }
                }, onClear: {
                    self.onClear()
                })
                .textInputAutocapitalization(.never)
                .focused(self.$focused, equals: .four)
            }
            .onAppear {
                self.focused = .one
            }
        }
        
        // MARK: Methods private
        
        private func verifyOneTimeCode(text: String) -> Bool {
            if text.count == 4 {
                self.text1 = String(text.prefix(1))
                self.text2 = String(text[text.index(text.startIndex, offsetBy: 1)])
                self.text3 = String(text[text.index(text.startIndex, offsetBy: 2)])
                self.text4 = String(text.suffix(1))
                
                self.onValueChanged()
                self.focused = nil
                
                return true
            }
            
            return false
        }
    }

    public struct InputTokenFieldItems: View {
        @Binding var text1: String
        @Binding var text2: String
        @Binding var text3: String
        @Binding var text4: String
        @Binding var errorMessage: String
        @Binding var isDisabled: Bool
        @Binding var showSkeleton: Bool
        var onValueChanged: () -> Void
        var onClear: () -> Void

        public var body: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                InputTokenFieldItem(text: self.$text1,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    if !verifyOneTimeCode(text: text) {
                        self.text1 = String(text.prefix(1))
                        self.onValueChanged()
                    }
                }, onClear: {
                    self.onClear()
                })

                InputTokenFieldItem(text: self.$text2,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    self.text2 = String(text.prefix(1))
                    self.onValueChanged()
                }, onClear: {
                    self.onClear()
                })

                InputTokenFieldItem(text: self.$text3,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    self.text3 = String(text.prefix(1))
                    self.onValueChanged()
                }, onClear: {
                    self.onClear()
                })

                InputTokenFieldItem(text: self.$text4,
                                    errorMessage: self.$errorMessage,
                                    isDisabled: self.$isDisabled,
                                    showSkeleton: self.$showSkeleton,
                                    onValueChanged: { text in
                    self.text4 = String(text.prefix(1))
                    self.onValueChanged()
                }, onClear: {
                    self.onClear()
                })
            }
        }
        
        // MARK: Methods private
        
        private func verifyOneTimeCode(text: String) -> Bool {
            if text.count == 4 {
                self.text1 = String(text.prefix(1))
                self.text2 = String(text[text.index(text.startIndex, offsetBy: 1)])
                self.text3 = String(text[text.index(text.startIndex, offsetBy: 2)])
                self.text4 = String(text.suffix(1))
                
                self.onValueChanged()
                
                return true
            }
            
            return false
        }
    }

    public struct InputTokenFieldItem: View {
        @Binding var text: String
        @Binding var errorMessage: String
        @Binding var isDisabled: Bool
        @Binding var showSkeleton: Bool
        var onValueChanged: (String) -> Void
        var onClear: () -> Void

        @State private var focused: Bool = false
        @State private var textOld: String = ""

        public var body: some View {
            TextField("", text: self.$text, onEditingChanged: { edit in
                self.focused = edit
            })
            .textContentType(.oneTimeCode)
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)
            .disabled(self.isDisabled)
            .onReceive(Just(self.text), perform: { text in
                if self.textOld != self.text {
                    self.textOld = self.text
                    self.onValueChanged(self.text)
                    if self.text.isEmpty {
                        self.onClear()
                    }
                }
            })
            .background(
                RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                    .overlay(
                        RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                            .strokeBorder(Color(getBorderColor()),
                                          lineWidth: 1))
                    .foregroundColor(Color(self.isDisabled ? Ocean.color.colorInterfaceLightUp : Ocean.color.colorInterfaceLightPure))
                    .frame(width: 48, height: 48)
            )
            .font(Font(UIFont.baseRegular(size: Ocean.font.fontSizeXs)!))
            .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
            .frame(width: 48, height: 48)
            .oceanSkeleton(with: self.showSkeleton)
        }

        // MARK: Methods private

        private func getBorderColor() -> UIColor {
            if self.isDisabled {
                return Ocean.color.colorInterfaceLightUp
            } else if !self.errorMessage.isEmpty {
                return Ocean.color.colorStatusNegativePure
            } else if self.focused {
                return Ocean.color.colorBrandPrimaryDown
            } else if !self.text.isEmpty {
                return Ocean.color.colorBrandPrimaryUp
            } else {
                return Ocean.color.colorInterfaceLightDeep
            }
        }
    }
}
