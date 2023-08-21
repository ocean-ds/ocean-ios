//
//  Ocean.Button.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/08/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class ButtonPrimaryParameters: ObservableObject {
        @Published public var text: String = "Hello"
        @Published public var isLoading: Bool = false
    }

    public struct ButtonPrimary: View {
        @ObservedObject public var parameters = ButtonPrimaryParameters()

        public init() {

        }

        public var body: some View {
            VStack {
                Text(parameters.text)
                if parameters.isLoading {
                    Text("Carregando...")
                }
                Button("test") {
                    self.parameters.text = "Test 2"
                }
            }
        }
    }
}

struct Ocean_Button_Previews: PreviewProvider {
    static var previews: some View {
        OceanSwiftUI.ButtonPrimary()
    }
}
