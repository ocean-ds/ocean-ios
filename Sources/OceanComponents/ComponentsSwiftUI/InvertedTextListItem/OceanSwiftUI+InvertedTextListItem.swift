//
//  OceanSwiftUI+InvertedTextListItem.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 26/01/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameter

    public class InvertedTextListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var subtitleColor: UIColor?
        @Published public var showSubtitle: Bool
        @Published public var newSubtitle: String
        @Published public var caption: String
        @Published public var hasCaptionBold: Bool
        @Published public var icon: UIImage?
        @Published public var leadingImage: UIImage?
        @Published public var leadingImageUrl: String?
        @Published public var leadingImageWidth: CGFloat
        @Published public var leadingImageHeight: CGFloat
        @Published public var leadingImageColor: UIColor
        @Published public var badge: BadgeParameters?
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: TagParameters.Status
        @Published public var tagSize: TagParameters.Size
        @Published public var backgroundColor: UIColor?
        @Published public var status: InvertedTextListItemParameters.State
        @Published public var tooltipText: String
        @Published public var padding: EdgeInsets
        @Published public var showSkeleton: Bool
        @Published public var link: LinkParameters
        @Published public var hasAction: Bool
        public var onTouch: () -> Void

        public init(title: String = "",
                    subtitle: String = "",
                    subtitleColor: UIColor? = nil,
                    showSubtitle: Bool = true,
                    newSubtitle: String = "",
                    caption: String = "",
                    hasCaptionBold: Bool = false,
                    leadingImage: UIImage? = nil,
                    leadingImageUrl: String? = nil,
                    icon: UIImage? = nil,
                    iconColor: UIColor = Ocean.color.colorBrandPrimaryDown,
                    leadingImageWidth: CGFloat = 24,
                    leadingImageHeight: CGFloat = 24,
                    leadingImageColor: UIColor = Ocean.color.colorBrandPrimaryDown,
                    badge: BadgeParameters? = nil,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: TagParameters.Status = .positive,
                    tagSize: TagParameters.Size = .medium,
                    backgroundColor: UIColor? = nil,
                    status: InvertedTextListItemParameters.State = .normal,
                    tooltipText: String = "",
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXxsExtra,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXxsExtra,
                                                trailing: Ocean.size.spacingStackXs),
                    showSkeleton: Bool = false,
                    link: LinkParameters = .init(),
                    hasAction: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.subtitle = subtitle
            self.showSubtitle = showSubtitle
            self.subtitleColor = subtitleColor
            self.newSubtitle = newSubtitle
            self.caption = caption
            self.hasCaptionBold = hasCaptionBold
            self.icon = icon
            self.leadingImage = leadingImage
            self.leadingImageUrl = leadingImageUrl
            self.leadingImageWidth = leadingImageWidth
            self.leadingImageHeight = leadingImageHeight
            self.leadingImageColor = leadingImageColor
            self.badge = badge
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.status = status
            self.tooltipText = tooltipText
            self.padding = padding
            self.showSkeleton = showSkeleton
            self.link = link
            self.hasAction = hasAction
            self.onTouch = onTouch
        }

        public enum State {
            case normal
            case inactive
            case positive
            case warning
            case highlight
            case highlightLead
            case strikethrough
        }
    }

    public struct InvertedTextListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (InvertedTextListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: InvertedTextListItemParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: InvertedTextListItemParameters = InvertedTextListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(spacing: Ocean.size.spacingStackXxsExtra) {
                if let imageUrl = parameters.leadingImageUrl {
                    ImageDownload(parameters: .init(url: imageUrl, contentMode: .fit))
                        .frame(width: parameters.leadingImageWidth, height: parameters.leadingImageHeight)
                } else if let image = parameters.leadingImage {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(parameters.leadingImageColor))
                        .frame(width: parameters.leadingImageWidth, height: parameters.leadingImageHeight)
                }
                VStack(alignment: .leading, spacing: 0) {

                    HStack(spacing: Ocean.size.spacingStackXxxs) {
                        if !parameters.title.isEmpty {
                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.title
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            }
                        }

                        if !parameters.tooltipText.isEmpty {
                            OceanSwiftUI.Tooltip { tooltip in
                                tooltip.parameters.text = parameters.tooltipText
                            }
                        }
                    }

                    if parameters.showSkeleton {
                        GeometryReader { geometryReader in
                            Rectangle()
                                .oceanSkeleton(isActive: true,
                                               size: CGSize(width: geometryReader.size.width,
                                                            height: Constants.skeletonHeight),
                                               shape: .rounded(.radius(Ocean.size.borderRadiusTiny,
                                                                       style: .circular)))
                        }
                        .frame(height: Constants.skeletonHeight)
                    } else {
                        HStack(spacing: 0) {
                            if let image = parameters.icon {
                                Image(uiImage: image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(getStatusColor()))
                                    .frame(width: Constants.iconSize, height: Constants.iconSize)

                                Spacer()
                                    .frame(width: Ocean.size.spacingInsetXxs)
                            }

                            OceanSwiftUI.Typography.paragraph { label in
                                label.parameters.text = maskedValue(parameters.subtitle)

                                if parameters.newSubtitle.isEmpty {
                                    label.parameters.textColor = getStatusColor()
                                } else {
                                    label.parameters.strikethrough = true
                                    label.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                                }

                                if parameters.status == .highlight {
                                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeXs)
                                }

                                if parameters.status == .highlightLead {
                                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeMd)
                                }
                            }
                            .animation(.easeInOut(duration: 0.2), value: parameters.showSubtitle)

                            if !parameters.newSubtitle.isEmpty {
                                Spacer()
                                    .frame(width: Ocean.size.spacingInsetXxs)

                                OceanSwiftUI.Typography.paragraph { label in
                                    label.parameters.text = parameters.newSubtitle
                                    label.parameters.textColor = getStatusColor()
                                    label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                                }
                            }
                        }

                        if !parameters.tagLabel.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxs)

                            OceanSwiftUI.Tag { tag in
                                tag.parameters.label = parameters.tagLabel
                                tag.parameters.icon = parameters.tagIcon
                                tag.parameters.status = parameters.tagStatus
                                tag.parameters.size = parameters.tagSize
                            }
                        }

                        if !parameters.caption.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxs)

                            OceanSwiftUI.Typography.caption { label in
                                label.parameters.text = parameters.caption
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            }
                        }

                        if !parameters.link.text.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxsExtra)

                            OceanSwiftUI.Link(parameters: parameters.link)
                        }
                    }
                }
                
                Spacer()
                
                if let badge = parameters.badge {
                    OceanSwiftUI.Badge(parameters: badge)
                        .padding(.trailing, -Ocean.size.spacingStackXxxs)
                }
                
                if parameters.hasAction {
                    Image(uiImage: Ocean.icon.chevronRightSolid)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .offset(x: Ocean.size.spacingStackXxs)
                }
            }
            .padding(parameters.padding)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(Color(parameters.backgroundColor ?? Ocean.color.colorInterfaceLightPure))
            .onTapGesture {
                parameters.onTouch()
            }
        }

        private func getStatusColor() -> UIColor {
            if let subtitleColor = parameters.subtitleColor {
                return subtitleColor
            }

            switch parameters.status {
            case .inactive:
                return Ocean.color.colorInterfaceDarkUp
            case .positive:
                return Ocean.color.colorStatusPositiveDeep
            case .warning:
                return Ocean.color.colorStatusWarningDeep
            case .strikethrough:
                return Ocean.color.colorStatusPositiveDeep
            default:
                return Ocean.color.colorInterfaceDarkDeep
            }
        }

        private func maskedValue(_ value: String) -> String {
            return parameters.showSubtitle ? value : "R$ ••••••"
        }

        private struct Constants {
            static let iconSize: CGFloat = 20
            static let skeletonHeight: CGFloat = 24
        }
    }
}
