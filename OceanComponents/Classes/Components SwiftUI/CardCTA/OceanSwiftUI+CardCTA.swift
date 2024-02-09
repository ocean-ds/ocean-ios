//
//  OceanSwiftUI+CardCTA.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 09/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class CardCTAParameters: ObservableObject {
        @Published public var text: String
        @Published public var isLoading: Bool
        public var onTouch: () -> Void

        public init(text: String = "",
                    isLoading: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.isLoading = isLoading
            self.onTouch = onTouch
        }
    }

    public struct CardCTA: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardCTA) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardCTAParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: CardCTAParameters = CardCTAParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if self.parameters.isLoading {
                CircularProgressIndicator(parameters: .init(style: .primary))
            } else {
                SwiftUI.Button(action: {
                    self.parameters.onTouch()
                }, label: {
                    HStack(spacing: Ocean.size.spacingStackXxs) {
                        Typography.heading5 { label in
                            label.parameters.text = self.parameters.text
                            label.parameters.textColor = Ocean.color.colorBrandPrimaryPure
                        }

                        Spacer()

                        Image(uiImage: Ocean.icon.chevronRightSolid)
                            .renderingMode(.template)
                            .foregroundColor(Color(Ocean.color.colorBrandPrimaryPure))
                    }
                    .padding(.horizontal, Ocean.size.spacingStackXs)
                    .cornerRadius(Ocean.size.borderRadiusMd)
                })
            }
        }

        // MARK: Methods private
    }
}
