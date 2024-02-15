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
        @Published public var subtitle: String
        @Published public var icon: UIImage?
        @Published public var badgeCount: Int?
        @Published public var badgeStatus: BadgeParameters.Status
        @Published public var view: (any View)?
        @Published public var ctaText: String
        @Published public var ctaIcon: UIImage?
        @Published public var recommend: Bool
        @Published public var isLoading: Bool
        public var onTouch: () -> Void

        public init(title: String = "",
                    subtitle: String = "",
                    icon: UIImage? = nil,
                    badgeCount: Int? = nil,
                    badgeStatus: BadgeParameters.Status = .warning,
                    view: (any View)? = nil,
                    ctaText: String = "",
                    ctaIcon: UIImage? = Ocean.icon.chevronRightSolid,
                    recommend: Bool = false,
                    isLoading: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.subtitle = subtitle
            self.icon = icon
            self.badgeCount = badgeCount
            self.badgeStatus = badgeStatus
            self.view = view
            self.ctaText = ctaText
            self.ctaIcon = ctaIcon
            self.recommend = recommend
            self.isLoading = isLoading
            self.onTouch = onTouch
        }

        fileprivate var contentView: AnyView {
            if view != nil {
                return AnyView(view!)
            } else {
                return AnyView(EmptyView())
            }
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

        // MARK: Constructors

        public init(parameters: CardGroupParameters = CardGroupParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
                        if let icon = self.parameters.icon {
                            Image(uiImage: icon)
                                .resizable()
                                .frame(width: 24,
                                       height: 24,
                                       alignment: .center)
                                .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
                        }

                        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                            if !self.parameters.title.isEmpty {
                                Typography.heading4 { label in
                                    label.parameters.text = self.parameters.title
                                }
                            }

                            if !self.parameters.subtitle.isEmpty {
                                Typography.description { label in
                                    label.parameters.text = self.parameters.subtitle
                                }
                            }
                        }

                        Spacer()

                        if let badgeCount = self.parameters.badgeCount {
                            Badge { badge in
                                badge.parameters.count = badgeCount
                                badge.parameters.status = self.parameters.badgeStatus
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, Ocean.size.spacingStackXs)
                    .background(Color(Ocean.color.colorInterfaceLightPure))

                    if let _ = self.parameters.view {
                        Divider()

                        self.parameters.contentView
                    }

                    if !self.parameters.ctaText.isEmpty {
                        Divider()

                        CardCTA { cardCTA in
                            cardCTA.parameters.text = self.parameters.ctaText
                            cardCTA.parameters.icon = self.parameters.ctaIcon
                            cardCTA.parameters.isLoading = self.parameters.isLoading
                            cardCTA.parameters.onTouch = self.parameters.onTouch
                        }
                    }
                }
                .padding(.all, 1)
                .frame(minWidth: 0, maxWidth: .infinity)
                .cornerRadius(Ocean.size.borderRadiusMd)
                .border(cornerRadius: Ocean.size.borderRadiusMd,
                        width: Ocean.size.borderWidthHairline,
                        color: self.parameters.recommend ? Ocean.color.colorBrandPrimaryUp : Ocean.color.colorInterfaceLightDown)

                if self.parameters.recommend {
                    Tag.neutralMD { tag in
                        tag.parameters.label = "Recomendado"
                    }
                    .padding(.leading, Ocean.size.spacingStackXs)
                    .padding(.top, -Ocean.size.spacingStackXxs)
                }
            }
        }

        // MARK: Methods private
    }
}
