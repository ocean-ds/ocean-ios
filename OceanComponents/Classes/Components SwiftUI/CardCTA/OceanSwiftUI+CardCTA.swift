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
        @Published public var icon: UIImage?
        @Published public var isLoading: Bool
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(text: String = "",
                    icon: UIImage? = Ocean.icon.chevronRightSolid,
                    isLoading: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.icon = icon
            self.isLoading = isLoading
            self.showSkeleton = showSkeleton
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
            if self.parameters.showSkeleton {
                OceanSwiftUI.Skeleton { skeleton in
                    skeleton.parameters.radius = Ocean.size.borderRadiusMd
                    skeleton.parameters.lines = 1
                }
                .frame(height: 48)
                .padding(.horizontal, Ocean.size.spacingStackXs)
            } else {
                HStack(alignment: .center, spacing: 0) {
                    if self.parameters.isLoading {
                        Spacer()

                        CircularProgressIndicator(parameters: .init(style: .primary))

                        Spacer()
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

                                if let icon = self.parameters.icon {
                                    Image(uiImage: icon)
                                        .renderingMode(.template)
                                        .foregroundColor(Color(Ocean.color.colorBrandPrimaryPure))
                                }
                            }
                        })
                    }
                }
                .frame(height: 48)
                .padding(.horizontal, Ocean.size.spacingStackXs)
                .cornerRadius(Ocean.size.borderRadiusMd)
                .background(Color(Ocean.color.colorInterfaceLightPure))
            }
        }

        // MARK: Methods private
    }
}
