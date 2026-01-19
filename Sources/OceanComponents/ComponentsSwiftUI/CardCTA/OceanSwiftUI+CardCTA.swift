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
        @Published public var badgeCount: Int?
        @Published public var badgeStatus: BadgeParameters.Status
        @Published public var backgroundColor: UIColor?
        @Published public var isLoading: Bool
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(text: String = "",
                    icon: UIImage? = Ocean.icon.chevronRightSolid,
                    badgeCount: Int? = nil,
                    badgeStatus: BadgeParameters.Status = .warning,
                    backgroundColor: UIColor? = nil,
                    isLoading: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.icon = icon
            self.badgeCount = badgeCount
            self.badgeStatus = badgeStatus
            self.backgroundColor = backgroundColor
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
            SwiftUI.Button(action: {
                self.parameters.onTouch()
            }, label: {
                HStack(alignment: .center, spacing: 0) {
                    if self.parameters.isLoading {
                        Spacer()
                        
                        CircularProgressIndicator(parameters: .init(style: .primary))
                        
                        Spacer()
                    } else {
                        
                        HStack(spacing: Ocean.size.spacingStackXxs) {
                            Typography.heading5 { label in
                                label.parameters.text = self.parameters.text
                                label.parameters.textColor = Ocean.color.colorBrandPrimaryPure
                                label.parameters.showSkeleton = self.parameters.showSkeleton
                            }
                            
                            Spacer()
                            
                            if let badgeCount = self.parameters.badgeCount {
                                Badge { badge in
                                    badge.parameters.count = badgeCount
                                    badge.parameters.status = self.parameters.badgeStatus
                                }
                            }
                            
                            if let icon = self.parameters.icon {
                                Image(uiImage: icon)
                                    .renderingMode(.template)
                                    .foregroundColor(Color(Ocean.color.colorBrandPrimaryPure))
                                    .oceanSkeleton(isActive: parameters.showSkeleton)
                            }
                        }
                    }
                }
                .frame(height: 48)
                .padding(.leading, Ocean.size.spacingStackXs)
                .padding(.trailing, Ocean.size.spacingStackXxs)
            })
            .buttonStyle(OceanCardCTAStyle(parameters: parameters))
            .disabled(parameters.showSkeleton)
        }

        // MARK: Methods private
        
        private struct OceanCardCTAStyle: ButtonStyle {
            private var parameters: CardCTAParameters
            
            public init(parameters: CardCTAParameters) {
                self.parameters = parameters
            }
            
            public func makeBody(configuration: Self.Configuration) -> some View {
                configuration.label
                    .cornerRadius(Ocean.size.borderRadiusMd)
                    .background(configuration.isPressed ? Color(Ocean.color.colorInterfaceLightUp) :
                                    Color(parameters.backgroundColor ?? Ocean.color.colorInterfaceLightPure))
            }
        }
    }
}
