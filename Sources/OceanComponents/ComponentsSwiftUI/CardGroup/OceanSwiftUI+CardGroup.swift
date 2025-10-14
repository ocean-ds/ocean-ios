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
        @Published public var caption: String
        @Published public var icon: UIImage?
        @Published public var badgeCount: Int?
        @Published public var badgeStatus: BadgeParameters.Status
        @Published public var tagLabel: String?
        @Published public var tagStatus: TagParameters.Status
        @Published public var progress: Float?
        @Published public var view: (any View)?
        @Published public var ctaText: String
        @Published public var ctaIcon: UIImage?
        @Published public var recommend: Bool
        @Published public var showProgressText: Bool
        @Published public var hasDivider: Bool
        @Published public var isLoading: Bool
        @Published public var showSkeleton: Bool
        @Published public var isInverted: Bool
        @Published public var tagLabelHeader: String?
        @Published public var tagStatusHeader: TagParameters.Status
        @Published public var ctaBadgeCount: Int?
        @Published public var ctaBadgeStatus: BadgeParameters.Status
        @Published public var highlightText: String?
        @Published public var headerBackgroundColor: UIColor?
        @Published public var contentBackgroundColor: UIColor?
        @Published public var highlightContentBackgroundColor: UIColor?
        public var onTouch: () -> Void

        public init(title: String = "",
                    subtitle: String = "",
                    caption: String = "",
                    icon: UIImage? = nil,
                    badgeCount: Int? = nil,
                    badgeStatus: BadgeParameters.Status = .warning,
                    tagLabel: String? = nil,
                    tagStatus: TagParameters.Status = .warning,
                    progress: Float? = nil,
                    view: (any View)? = nil,
                    ctaText: String = "",
                    ctaIcon: UIImage? = Ocean.icon.chevronRightSolid,
                    recommend: Bool = false,
                    showProgressText: Bool = false,
                    hasDivider: Bool = true,
                    isLoading: Bool = false,
                    showSkeleton: Bool = false,
                    isInverted: Bool = false,
                    tagLabelHeader: String? = nil,
                    tagStatusHeader: TagParameters.Status = .warning,
                    ctaBadgeCount: Int? = nil,
                    ctaBadgeStatus: BadgeParameters.Status = .warning,
                    highlightText: String? = nil,
                    headerBackgroundColor: UIColor? = nil,
                    contentBackgroundColor: UIColor? = nil,
                    highlightContentBackgroundColor: UIColor? = nil,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.subtitle = subtitle
            self.caption = caption
            self.icon = icon
            self.badgeCount = badgeCount
            self.badgeStatus = badgeStatus
            self.tagLabel = tagLabel
            self.tagStatus = tagStatus
            self.progress = progress
            self.view = view
            self.ctaText = ctaText
            self.ctaIcon = ctaIcon
            self.recommend = recommend
            self.showProgressText = showProgressText
            self.hasDivider = hasDivider
            self.isLoading = isLoading
            self.showSkeleton = showSkeleton
            self.isInverted = isInverted
            self.tagLabelHeader = tagLabelHeader
            self.tagStatusHeader = tagStatusHeader
            self.ctaBadgeCount = ctaBadgeCount
            self.ctaBadgeStatus = ctaBadgeStatus
            self.highlightText = highlightText
            self.headerBackgroundColor = headerBackgroundColor
            self.contentBackgroundColor = contentBackgroundColor
            self.highlightContentBackgroundColor = highlightContentBackgroundColor
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

        @ViewBuilder
        private var titleSubtitleCaptionView: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                if parameters.isInverted {
                    if !self.parameters.title.isEmpty {
                        Typography.description { label in
                            label.parameters.text = self.parameters.title
                        }
                    }

                    if !self.parameters.subtitle.isEmpty {
                        Typography.heading4 { label in
                            label.parameters.text = self.parameters.subtitle
                        }
                    }
                } else {
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

                if !self.parameters.caption.isEmpty {
                    Typography.caption { label in
                        label.parameters.text = self.parameters.caption
                    }
                    .padding(.top, Ocean.size.spacingStackXxxs)
                }
            }
        }

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
            if parameters.showSkeleton {
                VStack(spacing: 0) {
                    Rectangle()
                        .oceanSkeleton(isActive: true,
                                       size: CGSize(width: CGFloat.infinity, height: 100),
                                       shape: .rounded(.radius(Ocean.size.borderRadiusSm, style: .circular)),
                                       lines: 3,
                                       scales: [0: 0.5, 1: 1, 2: 1, 3: 1])
                        .padding(.all, Ocean.size.spacingStackXs)
                }
                .border(cornerRadius: Ocean.size.borderRadiusMd,
                        width: Ocean.size.borderWidthHairline,
                        color: Ocean.color.colorInterfaceLightDown)

            } else {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
                            if let icon = self.parameters.icon {
                                Image(uiImage: icon)
                                    .resizable()
                                    .frame(width: 24, height: 24, alignment: .center)
                                    .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
                            }
                            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                                titleSubtitleCaptionView

                                if let tagLabel = self.parameters.tagLabel {
                                    Tag { tag in
                                        tag.parameters.label = tagLabel
                                        tag.parameters.status = self.parameters.tagStatus
                                    }
                                }
                            }
                            Spacer()
                            VStack(spacing: 0) {
                                if let tagLabelHeader = parameters.tagLabelHeader {
                                    Tag { tag in
                                        tag.parameters.label = tagLabelHeader
                                        tag.parameters.status = parameters.tagStatusHeader
                                    }
                                    Spacer()
                                } else if let badgeCount = parameters.badgeCount {
                                    Badge { badge in
                                        badge.parameters.count = badgeCount
                                        badge.parameters.status = self.parameters.badgeStatus
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.all, Ocean.size.spacingStackXs)
                        .background(Color(parameters.headerBackgroundColor ?? Ocean.color.colorInterfaceLightPure))

                        if let progress = parameters.progress {
                            ProgressBar { view in
                                view.parameters.progress = progress
                                view.parameters.showValue = parameters.showProgressText
                                view.parameters.padding = EdgeInsets(top: 0,
                                                                     leading: Ocean.size.spacingStackXs,
                                                                     bottom: Ocean.size.spacingStackXs,
                                                                     trailing: Ocean.size.spacingStackXs)
                            }
                        }

                        if let customView = parameters.view {
                            if parameters.hasDivider {
                                Divider()
                            }
                            VStack(spacing: 0) {
                                AnyView(customView)
                            }
                            .background(Color(parameters.contentBackgroundColor ?? Ocean.color.colorInterfaceLightPure))
                        }

                        if !parameters.ctaText.isEmpty {
                            Divider()
                            CardCTA { cardCTA in
                                cardCTA.parameters.text = parameters.ctaText
                                cardCTA.parameters.icon = parameters.ctaIcon
                                cardCTA.parameters.badgeCount = parameters.ctaBadgeCount
                                cardCTA.parameters.badgeStatus = parameters.ctaBadgeStatus
                                cardCTA.parameters.isLoading = parameters.isLoading
                                cardCTA.parameters.onTouch = parameters.onTouch
                            }
                        }

                        if let highlightText = parameters.highlightText {
                            Divider()

                            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                                OceanSwiftUI.Typography.captionBold { view in
                                    view.parameters.text = highlightText
                                }
                                .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.all, Ocean.size.spacingStackXs)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color(parameters.highlightContentBackgroundColor ?? Ocean.color.colorBrandPrimaryPure))
                        }
                    }
                    .padding(.all, 1)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(Ocean.size.borderRadiusMd)
                    .clipShape(RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd, style: .continuous)
                            .stroke(
                                Color(self.parameters.recommend ? Ocean.color.colorBrandPrimaryUp : Ocean.color.colorInterfaceLightDown),
                                lineWidth: Ocean.size.borderWidthHairline
                            )
                    )

                    if self.parameters.recommend {
                        Tag.highlightNeutralMD { tag in
                            tag.parameters.label = "Recomendado"
                        }
                        .padding(.leading, Ocean.size.spacingStackXs)
                        .padding(.top, -Ocean.size.spacingStackXxs)
                    }
                }
            }
        }

        // MARK: Methods private
    }
}
