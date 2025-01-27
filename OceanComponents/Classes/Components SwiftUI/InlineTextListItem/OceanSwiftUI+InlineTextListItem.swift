//
//  OceanSwiftUI+InlineTextListItem.swift
//  OceanComponents
//
//  Created by Celso Farias on 27/01/2025.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameter

    public class InlineTextListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var titleLineLimit: Int?
        @Published public var description: String
        @Published public var descriptionLineLimit: Int?
        @Published public var icon: UIImage?
        @Published public var iconColor: UIColor
        @Published public var iconBackgroundColor: UIColor
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var tagSize: OceanSwiftUI.TagParameters.Size
        @Published public var tagOrientation: OceanSwiftUI.InlineTextListItemParameters.TagOrientation
        @Published public var padding: EdgeInsets
        @Published public var state: OceanSwiftUI.InlineTextListItemParameters.State
        @Published public var buttonTitle: String
        @Published public var buttonStyle: ButtonParameters.Style
        @Published public var buttonIsLoading: Bool
        @Published public var isEnabled: Bool
        @Published public var hasLocked: Bool
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(title: String = "",
                    titleLineLimit: Int? = nil,
                    description: String = "",
                    descriptionLineLimit: Int? = nil,
                    icon: UIImage? = nil,
                    iconColor: UIColor = Ocean.color.colorBrandPrimaryDown,
                    iconBackgroundColor: UIColor = Ocean.color.colorInterfaceLightUp,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: OceanSwiftUI.TagParameters.Status = .positive,
                    tagSize: OceanSwiftUI.TagParameters.Size = .small,
                    tagOrientation: OceanSwiftUI.InlineTextListItemParameters.TagOrientation = .vertical,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs),
                    state: OceanSwiftUI.InlineTextListItemParameters.State = .normal,
                    buttonTitle: String = "",
                    buttonStyle: ButtonParameters.Style = .primary,
                    buttonIsLoading: Bool = false,
                    isEnabled: Bool = true,
                    hasLocked: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.titleLineLimit = titleLineLimit
            self.description = description
            self.descriptionLineLimit = descriptionLineLimit
            self.icon = icon
            self.iconColor = iconColor
            self.iconBackgroundColor = iconBackgroundColor
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.tagOrientation = tagOrientation
            self.padding = padding
            self.state = state
            self.buttonTitle = buttonTitle
            self.buttonStyle = buttonStyle
            self.buttonIsLoading = buttonIsLoading
            self.isEnabled = isEnabled
            self.hasLocked = hasLocked
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }

        public enum State {
            case normal
            case neutral
            case positive
        }

        public enum TagOrientation {
            case vertical
            case horizontal
        }
    }

    public struct InlineTextListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (InlineTextListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: InlineTextListItemParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: InlineTextListItemParameters = InlineTextListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if parameters.showSkeleton {
                OceanSwiftUI.Skeleton()
            } else {
                HStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        OceanSwiftUI.Typography.paragraph { label in
                            label.parameters.text = parameters.title
                            label.parameters.lineLimit = parameters.titleLineLimit
                            label.parameters.multilineTextAlignment = .leading
                            label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDeep : Ocean.color.colorInterfaceDarkUp
                        }

                        if !parameters.tagLabel.isEmpty && parameters.tagOrientation == .horizontal {
                            OceanSwiftUI.Tag { tag in
                                tag.parameters.label = parameters.tagLabel
                                tag.parameters.icon = parameters.tagIcon
                                tag.parameters.status = parameters.tagStatus
                                tag.parameters.size = parameters.tagSize
                            }
                        }
                    }

                    Spacer()

                    HStack(alignment: .center, spacing: 0) {
                        if let icon = parameters.icon {
                            RoundedIcon { image in
                                image.parameters.icon = icon
                                image.parameters.color = parameters.iconColor
                                image.parameters.backgroundColor = parameters.iconBackgroundColor
                            }
                        }

                        if !parameters.buttonTitle.isEmpty {
                            Button { button in
                                button.parameters.text = parameters.buttonTitle
                                button.parameters.style = parameters.buttonStyle
                                button.parameters.size = .small
                                button.parameters.isLoading = parameters.buttonIsLoading
                                button.parameters.onTouch = parameters.onTouch
                            }
                        }

                        if !parameters.description.isEmpty {
                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.description
                                label.parameters.lineLimit = parameters.descriptionLineLimit
                                label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorInterfaceLightDeep
                            }
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                }
                .padding(parameters.padding)
                .background(Color(Ocean.color.colorInterfaceLightPure))
            }
        }

        private struct Constants {
            static let iconSize: CGFloat = 20
            static let skeletonHeight: CGFloat = 24
        }
    }
}
