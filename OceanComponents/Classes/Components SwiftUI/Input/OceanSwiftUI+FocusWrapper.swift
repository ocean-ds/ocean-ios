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

        public init(requestFocus: Binding<Bool>,
                    onFocusChanged: @escaping (Bool) -> Void,
                    content: @escaping (FocusState<Bool>.Binding) -> Content) {
            self._requestFocus = requestFocus
            self.onFocusChanged = onFocusChanged
            self.content = content
        }

        public var body: some View {
            content($isFocused)
                .onChange(of: requestFocus) { newValue in
                    isFocused = newValue
                    onFocusChanged(newValue)
                }
        }
    }
}
