//
//  OceanSwiftUI+CardGroup.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 09/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class CardGroupParameters: ObservableObject {
        @Published public var title: String
        @Published public var description: String
        @Published public var content: (any View)?
        @Published public var ctaText: String
        @Published public var badgeCount: Int?
        @Published public var ctaIcon: UIImage?
        public var onTouch: () -> Void

        public init(title: String = "",
                    description: String = "",
                    content: (any View)? = nil,
                    ctaText: String = "",
                    badgeCount: Int? = nil,
                    ctaIcon: UIImage? = Ocean.icon.chevronRightSolid,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.description = description
            self.content = content
            self.ctaText = ctaText
            self.badgeCount = badgeCount
            self.ctaIcon = ctaIcon
            self.onTouch = onTouch
        }

        fileprivate var contentView: AnyView {
            if let view = content {
                return AnyView(view)
            }
            return AnyView(EmptyView())
        }
    }

    public struct CardGroup: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardGroup) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardGroupParameters

        // MARK: Properties private

        public init(parameters: CardGroupParameters) {
            self.parameters = parameters
        }

        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {

                VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                    if !parameters.title.isEmpty {
                        Typography.heading4 { label in
                            label.parameters.text = parameters.title
                        }
                    }
                    if !parameters.description.isEmpty {
                        Typography.description { label in
                            label.parameters.text = parameters.description
                        }
                    }
                }
                .padding(Ocean.size.spacingStackXs)

                OceanSwiftUI.Divider()
                parameters.contentView

                OceanSwiftUI.Divider()
                HStack {
                    Typography.heading5 { label in
                        label.parameters.text = parameters.ctaText
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryPure
                    }
                    Spacer()
                    if let badgeCount = parameters.badgeCount {
                        Badge { badge in
                            badge.parameters.count = badgeCount
                            badge.parameters.status = .warning
                        }
                    }
                    if let icon = parameters.ctaIcon {
                        Image(uiImage: icon)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
                .padding(Ocean.size.spacingStackXs)
                .contentShape(Rectangle())
                .onTapGesture { parameters.onTouch() }
            }
            .cornerRadius(Ocean.size.borderRadiusMd)
            .border(cornerRadius: Ocean.size.borderRadiusMd,
                    width: Ocean.size.borderWidthHairline,
                    color: Ocean.color.colorInterfaceLightDown)
        }
    }
}
