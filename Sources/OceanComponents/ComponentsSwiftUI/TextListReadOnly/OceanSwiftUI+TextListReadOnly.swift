//
//  OceanSwiftUI+TextListReadOnly.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 20/04/26.
//

import OceanTokens
import SwiftUI

extension OceanSwiftUI {

    // MARK: Parameter

    public class TextListReadOnlyParameters: ObservableObject {
        @Published public var state: State
        @Published public var showIcon: Bool
        @Published public var icon: UIImage?
        @Published public var iconColor: UIColor
        @Published public var iconSize: CGFloat
        @Published public var showIndicator: Bool
        @Published public var indicator: TagParameters?
        @Published public var showDivider: Bool
        @Published public var contentList: ContentListParameters
        @Published public var backgroundColor: UIColor
        @Published public var padding: EdgeInsets

        public init(state: State = .default,
                    showIcon: Bool = false,
                    icon: UIImage? = nil,
                    iconColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    iconSize: CGFloat = 20,
                    showIndicator: Bool = false,
                    indicator: TagParameters? = nil,
                    showDivider: Bool = false,
                    contentList: ContentListParameters = ContentListParameters(),
                    backgroundColor: UIColor = Ocean.color.colorInterfaceLightPure,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs)) {
            self.state = state
            self.showIcon = showIcon
            self.icon = icon
            self.iconColor = iconColor
            self.iconSize = iconSize
            self.showIndicator = showIndicator
            self.indicator = indicator
            self.showDivider = showDivider
            self.contentList = contentList
            self.backgroundColor = backgroundColor
            self.padding = padding
        }

        public enum State {
            case `default`
            case disabled
            case loading
        }
    }

    public struct TextListReadOnly: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TextListReadOnly) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TextListReadOnlyParameters

        // MARK: Constructors

        public init(parameters: TextListReadOnlyParameters = TextListReadOnlyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    if parameters.showIcon, let icon = parameters.icon {
                        Image(uiImage: icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: parameters.iconSize,
                                   height: parameters.iconSize)
                            .foregroundColor(Color(parameters.iconColor))
                    }

                    ContentList(parameters: resolvedContentListParameters())

                    if parameters.showIndicator, let tag = parameters.indicator {
                        Tag(parameters: tag)
                    }
                }
                .padding(parameters.padding)

                if parameters.showDivider {
                    Divider()
                }
            }
            .background(Color(parameters.backgroundColor))
        }

        // MARK: Private Methods

        private func resolvedContentListParameters() -> ContentListParameters {
            let source = parameters.contentList
            return ContentListParameters(
                title: source.title,
                description: source.description,
                descriptionColor: source.descriptionColor,
                descriptionFont: source.descriptionFont,
                newDescription: source.newDescription,
                caption: source.caption,
                captionColor: source.captionColor,
                tagTitle: source.tagTitle,
                tagStatus: source.tagStatus,
                errorMessage: source.errorMessage,
                type: parameters.state == .disabled ? .inactive : source.type,
                showSkeleton: parameters.state == .loading || source.showSkeleton,
                padding: .all(0)
            )
        }
    }
}
