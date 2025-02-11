//
//  OceanSwiftUI+ExpandableTextListItem.swift
//  OceanComponents
//
//  Created by Celso Farias on 11/02/25.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameter

    public class ExpandableTextListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var icon: UIImage?
        @Published public var iconColor: UIColor
        @Published public var iconBackgroundColor: UIColor
        @Published public var actionText: String
        @Published public var status: Status
        @Published public var content: [TextListItemParameters]
        @Published public var hasDivider: Bool
        @Published public var showSkeleton: Bool
        @Published public var isEnabled: Bool
        @Published public var padding: EdgeInsets

        public var onTouchAction: () -> Void

        public init(title: String = "",
                    subtitle: String = "",
                    icon: UIImage? = nil,
                    iconColor: UIColor = Ocean.color.colorBrandPrimaryDown,
                    iconBackgroundColor: UIColor = Ocean.color.colorInterfaceLightUp,
                    actionText: String = "",
                    status: Status = .collapsed,
                    content: [TextListItemParameters] = [],
                    hasDivider: Bool = true,
                    showSkeleton: Bool = false,
                    isEnabled: Bool = true,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs),
                    onTouchAction: @escaping () -> Void = { }) {
            self.title = title
            self.subtitle = subtitle
            self.icon = icon
            self.iconColor = iconColor
            self.iconBackgroundColor = iconBackgroundColor
            self.actionText = actionText
            self.status = status
            self.content = content
            self.hasDivider = hasDivider
            self.showSkeleton = showSkeleton
            self.isEnabled = isEnabled
            self.padding = padding
            self.onTouchAction = onTouchAction
        }

        public enum Status {
            case expanded, collapsed
        }
    }

    public struct ExpandableTextListItemTextListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ExpandableTextListItemTextListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ExpandableTextListItemParameters

        // MARK: Private properties

        @State private var rotation: Double = 0.0

        private let animationDuration: Double = 0.3

        // MARK: Constructors

        public init(parameters: ExpandableTextListItemParameters = ExpandableTextListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                HStack(spacing: Ocean.size.spacingStackXs) {
                    if let icon = parameters.icon {
                        OceanSwiftUI.RoundedIcon { image in
                            image.parameters.icon = icon
                            image.parameters.color = parameters.iconColor
                            image.parameters.backgroundColor = parameters.iconBackgroundColor
                        }
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        if !parameters.title.isEmpty {
                            OceanSwiftUI.Typography.paragraph { label in
                                label.parameters.text = parameters.title
                                label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDeep : Ocean.color.colorInterfaceDarkUp
                            }
                        }

                        if !parameters.subtitle.isEmpty {
                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.subtitle
                                label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorInterfaceLightDeep
                            }
                        }
                    }

                    Spacer()

                    Image(uiImage: Ocean.icon.chevronDownSolid)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .rotationEffect(.degrees(rotation))
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(Ocean.size.spacingStackXs)
                .background(Color(Ocean.color.colorInterfaceLightPure))
                .contentShape(Rectangle())
                .transform(condition: parameters.isEnabled, transform: { view in
                    view.onTapGesture {
                        parameters.status = parameters.status == .collapsed ? .expanded : .collapsed
                        parameters.onTouchAction()
                        withAnimation(.linear(duration: animationDuration)) {
                            rotation = parameters.status == .collapsed ? 0 : -180
                        }
                    }
                })
                .animation(.easeInOut(duration: animationDuration), value: parameters.status)

                if parameters.status == .expanded {
                    ForEach(parameters.content.indices, id: \.self) { index in
                        OceanSwiftUI.TextListItem(parameters: parameters.content[index])
                    }
                }
            }
        }
    }
}
