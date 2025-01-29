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
        @Published public var description: String
        @Published public var descriptionColor: UIColor?
        @Published public var strikethroughText: String
        @Published public var icon: RoundedIconParameters?
        @Published public var tag: TagParameters?
        @Published public var button: ButtonParameters?
        @Published public var padding: EdgeInsets
        @Published public var state: State
        @Published public var size: Size
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(title: String = "",
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    strikethroughText: String = "",
                    icon: RoundedIconParameters? = nil,
                    tag: TagParameters? = nil,
                    button: ButtonParameters? = nil,
                    padding: EdgeInsets =
            .init(top: Ocean.size.spacingStackXxs,
                  leading: 0,
                  bottom: Ocean.size.spacingStackXxs,
                  trailing: 0),
                    state: State = .normal,
                    size: Size = .normal,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.description = description
            self.descriptionColor = descriptionColor
            self.strikethroughText = strikethroughText
            self.icon = icon
            self.tag = tag
            self.button = button
            self.padding = padding
            self.state = state
            self.size = size
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
                            }
                        } else {
                            OceanSwiftUI.Typography.caption { label in
                                label.parameters.text = parameters.title
                            }
                        }

                        if let tag = parameters.tag {
                            Tag.init(parameters: tag)
                        }
                    }

                    Spacer()

                    HStack(alignment: .center, spacing: 0) {
                        if let roundedIcon = parameters.icon {
                            RoundedIcon.init(parameters: roundedIcon)
                            /*
                            OceanSwiftUI.RoundedIcon { icon in
                                icon.parameters.icon = roundedIcon.parameters.icon
                                icon.parameters.color = getStatusColor()
                                icon.parameters.backgroundColor = Ocean.color.colorInterfaceLightPure
                            }
                             */
                        }

                        if let button = parameters.button {
                            Button.init(parameters: button)

                            /*
                            OceanSwiftUI.Button.primarySM { button in
                                button.parameters.text = hasButton.parameters.text
                                button.parameters.isLoading = hasButton.parameters.isLoading
                                button.parameters.onTouch = hasButton.parameters.onTouch
                            }
                            */
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
                                    label.parameters.textColor = getStatusColor()
                                    if parameters.state == .highlight {
                                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXs)
                                    }
                                }
                            } else {
                                OceanSwiftUI.Typography.description { label in
                                    label.parameters.text = parameters.description
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
    }
}
