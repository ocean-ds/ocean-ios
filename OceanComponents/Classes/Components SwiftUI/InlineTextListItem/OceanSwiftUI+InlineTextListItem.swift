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
        @Published public var descriptionColor: UIColor?
        @Published public var descriptionLineLimit: Int?
        @Published public var strikethroughText: String
        @Published public var icon: RoundedIcon?
        @Published public var tag: Tag?
        @Published public var padding: EdgeInsets
        @Published public var state: OceanSwiftUI.InlineTextListItemParameters.State
        @Published public var size: OceanSwiftUI.InlineTextListItemParameters.Size
        @Published public var buttonTitle: String
        @Published public var buttonStyle: ButtonParameters.Style
        @Published public var buttonIsLoading: Bool
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(title: String = "",
                    titleLineLimit: Int? = nil,
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    descriptionLineLimit: Int? = nil,
                    strikethroughText: String = "",
                    icon: RoundedIcon? = nil,
                    tag: Tag? = nil,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs),
                    state: OceanSwiftUI.InlineTextListItemParameters.State = .normal,
                    size: OceanSwiftUI.InlineTextListItemParameters.Size = .normal,
                    buttonTitle: String = "",
                    buttonStyle: ButtonParameters.Style = .primary,
                    buttonIsLoading: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.titleLineLimit = titleLineLimit
            self.description = description
            self.descriptionColor = descriptionColor
            self.descriptionLineLimit = descriptionLineLimit
            self.strikethroughText = strikethroughText
            self.icon = icon
            self.tag = tag
            self.padding = padding
            self.state = state
            self.size = size
            self.buttonTitle = buttonTitle
            self.buttonStyle = buttonStyle
            self.buttonIsLoading = buttonIsLoading
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }

        public enum State {
            case normal
            case innactive
            case positive
            case warning
            case highlight
            case strikethrough
            case withAction
        }

        public enum Size {
            case normal
            case small
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
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
                    OceanSwiftUI.Skeleton { skeleton in
                        skeleton.parameters.lines = 1
                        skeleton.parameters.height = Ocean.size.spacingStackSm
                    }
                    OceanSwiftUI.Skeleton { skeleton in
                        skeleton.parameters.lines = 1
                        skeleton.parameters.height = Ocean.size.spacingStackSm
                    }
                }
            } else {
                HStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        if parameters.size == .normal {
                            OceanSwiftUI.Typography.paragraph { label in
                                label.parameters.text = parameters.title
                                label.parameters.lineLimit = parameters.titleLineLimit
                                label.parameters.multilineTextAlignment = .leading
                            }
                        } else {
                            OceanSwiftUI.Typography.caption { label in
                                label.parameters.text = parameters.title
                                label.parameters.lineLimit = parameters.titleLineLimit
                                label.parameters.multilineTextAlignment = .leading
                            }
                        }

                        if let tag = parameters.tag {
                            OceanSwiftUI.Tag { tagView in
                                tagView.parameters.label = tag.parameters.label
                                tagView.parameters.icon = tag.parameters.icon
                                tagView.parameters.status = tag.parameters.status
                                tagView.parameters.size = tag.parameters.size
                            }
                        }
                    }

                    Spacer()

                    HStack(alignment: .center, spacing: 0) {
                        if let roundedIcon = parameters.icon {
                            OceanSwiftUI.RoundedIcon { icon in
                                icon.parameters.icon = roundedIcon.parameters.icon
                                icon.parameters.color = getStatusColor()
                                icon.parameters.backgroundColor = Ocean.color.colorInterfaceLightPure
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

                        if parameters.state == .strikethrough {
                            OceanSwiftUI.Typography.paragraph { label in
                                label.parameters.text = parameters.strikethroughText
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                                label.parameters.strikethrough = true
                            }
                            Spacer()
                                .frame(width: Ocean.size.spacingInsetXxs)
                        }

                        if !parameters.description.isEmpty {
                            if parameters.size == .normal {
                                OceanSwiftUI.Typography.paragraph { label in
                                    label.parameters.text = parameters.description
                                    label.parameters.lineLimit = parameters.descriptionLineLimit
                                    label.parameters.textColor = getStatusColor()
                                    if parameters.state == .highlight {
                                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXs)
                                    }
                                }
                            } else {
                                OceanSwiftUI.Typography.description { label in
                                    label.parameters.text = parameters.description
                                    label.parameters.lineLimit = parameters.descriptionLineLimit
                                    label.parameters.textColor = getStatusColor()
                                    if parameters.state == .highlight {
                                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                    }
                                }
                            }
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                }
                .padding(parameters.padding)
                .background(Color(Ocean.color.colorInterfaceLightPure))
            }
        }

        private func getStatusColor() -> UIColor {
            if let subtitleColor = parameters.descriptionColor {
                return subtitleColor
            }

            switch parameters.state {
            case .normal:
                return Ocean.color.colorInterfaceDarkDeep
            case .innactive:
                return Ocean.color.colorInterfaceDarkUp
            case .positive:
                return Ocean.color.colorStatusPositiveDeep
            case .warning:
                return Ocean.color.colorStatusWarningDeep
            case .highlight:
                return Ocean.color.colorInterfaceDarkDeep
            case .strikethrough:
                return Ocean.color.colorStatusPositiveDeep
            default:
                return Ocean.color.colorInterfaceDarkDown
            }
        }

        private struct Constants {
            static let iconSize: CGFloat = 20
            static let skeletonHeight: CGFloat = 24
        }
    }
}
