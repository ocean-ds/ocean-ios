//
//  OceanSwiftUI+FocusWrapper.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 10/02/25.
//

import Foundation
import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    @available(iOS 15.0, *)
    public struct FocusWrapper<Content: View>: View {
        @FocusState private var isFocused: Bool
        @Binding var requestFocus: Bool
        let content: (FocusState<Bool>.Binding) -> Content
        let onFocusChanged: (Bool) -> Void
        let selectAllFocusedText: Bool

        public init(requestFocus: Binding<Bool>,
                    selectAllFocusedText: Bool = false,
                    onFocusChanged: @escaping (Bool) -> Void,
                    content: @escaping (FocusState<Bool>.Binding) -> Content) {
            self._requestFocus = requestFocus
            self.selectAllFocusedText = selectAllFocusedText
            self.onFocusChanged = onFocusChanged
            self.content = content
        }

        public var body: some View {
            content($isFocused)
                .onChange(of: requestFocus) { newValue in
                    isFocused = newValue
                }
                .onChange(of: isFocused) { newValue in
                    if requestFocus != newValue {
                        requestFocus = newValue
                    }
                    onFocusChanged(newValue)
                }
                .onChange(of: isFocused) { focus in
                    if focus, selectAllFocusedText {
                        DispatchQueue.main.async {
                            UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                        }
                    }
                }

        }
    }
}
