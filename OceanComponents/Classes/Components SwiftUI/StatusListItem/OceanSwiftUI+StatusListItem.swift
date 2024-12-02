//
//  OceanSwiftUI+StatusListItem.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 24/11/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class StatusListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var titleLineLimit: Int?
        @Published public var description: String
        @Published public var descriptionLineLimit: Int?
        @Published public var caption: String
        @Published public var captionLineLimit: Int?
        @Published public var captionColor: UIColor?
        @Published public var style: Style
        @Published public var tagLabel: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var tagPosition: Position
        @Published public var badgeCount: Int?
        @Published public var badgeStatus: BadgeParameters.Status
        @Published public var badgePosition: Position
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void = { }

        public enum Style {
            case normal
            case contextMenu
            case readOnly
        }

        public enum Position {
            case below
            case right
        }

        public init(title: String = "",
                    titleLineLimit: Int? = nil,
                    description: String = "",
                    descriptionLineLimit: Int? = nil,
                    caption: String = "",
                    captionLineLimit: Int? = nil,
                    captionColor: UIColor? = nil,
                    style: Style = .normal,
                    tagLabel: String = "",
                    tagStatus: TagParameters.Status = .positive,
                    tagPosition: Position = .below,
                    badgeCount: Int? = nil,
                    badgeStatus: BadgeParameters.Status = .warning,
                    badgePosition: Position = .below,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.titleLineLimit = titleLineLimit
            self.description = description
            self.descriptionLineLimit = descriptionLineLimit
            self.caption = caption
            self.captionLineLimit = captionLineLimit
            self.captionColor = captionColor
            self.style = style
            self.tagLabel = tagLabel
            self.tagStatus = tagStatus
            self.tagPosition = tagPosition
            self.badgeCount = badgeCount
            self.badgeStatus = badgeStatus
            self.badgePosition = badgePosition
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }
    }

    public struct StatusListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (StatusListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: StatusListItemParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: StatusListItemParameters = StatusListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    OceanSwiftUI.Typography.paragraph { label in
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                        label.parameters.text = self.parameters.title
                        label.parameters.lineLimit = self.parameters.titleLineLimit
                        label.parameters.showSkeleton = self.parameters.showSkeleton
                    }
                    if !self.parameters.description.isEmpty {
                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = self.parameters.description
                            label.parameters.lineLimit = self.parameters.descriptionLineLimit
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    }
                    if !self.parameters.caption.isEmpty {
                        Spacer().frame(height: Ocean.size.spacingStackXxxs)
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.caption
                            label.parameters.textColor = self.parameters.captionColor ?? Ocean.color.colorInterfaceDarkDown
                            label.parameters.lineLimit = self.parameters.captionLineLimit
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    }

                    if !self.parameters.tagLabel.isEmpty && self.parameters.tagPosition == .below {
                        Spacer().frame(height: Ocean.size.spacingStackXxs)
                        OceanSwiftUI.Tag { tag in
                            tag.parameters.label = self.parameters.tagLabel
                            tag.parameters.status = self.parameters.tagStatus
                            tag.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    }
                    if self.parameters.badgeCount != nil && self.parameters.badgePosition == .below {
                        Spacer().frame(height: Ocean.size.spacingStackXxs)
                        OceanSwiftUI.Badge { badge in
                            badge.parameters.count = self.parameters.badgeCount ?? 0
                            badge.parameters.status = self.parameters.badgeStatus
                            badge.parameters.size = .small
                            badge.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    }
                }

                Spacer().frame(width: Ocean.size.spacingStackXs)

                Spacer()

                if !self.parameters.tagLabel.isEmpty && self.parameters.tagPosition == .right {
                    OceanSwiftUI.Tag { tag in
                        tag.parameters.label = self.parameters.tagLabel
                        tag.parameters.status = self.parameters.tagStatus
                        tag.parameters.showSkeleton = self.parameters.showSkeleton
                    }
                    Spacer().frame(width: Ocean.size.spacingStackXxs)
                }
                if self.parameters.badgeCount != nil && self.parameters.badgePosition == .right {
                    Spacer().frame(width: Ocean.size.spacingStackXxs)
                    OceanSwiftUI.Badge { badge in
                        badge.parameters.count = self.parameters.badgeCount ?? 0
                        badge.parameters.status = self.parameters.badgeStatus
                        badge.parameters.size = .small
                        badge.parameters.showSkeleton = self.parameters.showSkeleton
                    }
                }

                if let icon = getIconImage() {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .oceanSkeleton(isActive: self.parameters.showSkeleton)
                }
            }
            .background(Color(Ocean.color.colorInterfaceLightPure))
            .padding(.all, Ocean.size.spacingStackXs)
            .onTapGesture {
                self.parameters.onTouch()
            }
        }

        // MARK: Methods private

        private func getIconImage() -> UIImage? {
            switch parameters.style {
            case .normal:
                return Ocean.icon.chevronRightSolid
            case .contextMenu:
                return Ocean.icon.dotsVerticalSolid
            case .readOnly:
                return nil
            }
        }
    }
}
