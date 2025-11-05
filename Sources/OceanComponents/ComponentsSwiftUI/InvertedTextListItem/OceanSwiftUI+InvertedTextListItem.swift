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
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var tagSize: OceanSwiftUI.TagParameters.Size
        @Published public var backgroundColor: UIColor?
        @Published public var status: OceanSwiftUI.InvertedTextListItemParameters.State
        @Published public var tooltipText: String
        @Published public var padding: EdgeInsets
        @Published public var showSkeleton: Bool
        @Published public var link: OceanSwiftUI.LinkParameters

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
                    leadingImageWidth: CGFloat = 56,
                    leadingImageHeight: CGFloat = 56,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: OceanSwiftUI.TagParameters.Status = .positive,
                    tagSize: OceanSwiftUI.TagParameters.Size = .medium,
                    backgroundColor: UIColor? = nil,
                    status: OceanSwiftUI.InvertedTextListItemParameters.State = .normal,
                    tooltipText: String = "",
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXxsExtra,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXxsExtra,
                                                trailing: Ocean.size.spacingStackXs),
                    showSkeleton: Bool = false,
                    link: OceanSwiftUI.LinkParameters = .init()) {
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
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.status = status
            self.tooltipText = tooltipText
            self.padding = padding
            self.showSkeleton = showSkeleton
            self.link = link
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
            }
            .padding(parameters.padding)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(Color(parameters.backgroundColor ?? Ocean.color.colorInterfaceLightPure))
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
