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
        @Published public var items: [ItemModel]
        @Published public var tag: TagParameters?
        @Published public var button: ButtonParameters?
        @Published public var icon: RoundedIconParameters?
        @Published public var description: String
        @Published public var descriptionColor: UIColor?
        @Published public var strikethroughText: String
        @Published public var padding: EdgeInsets
        @Published public var state: State
        @Published public var size: Size
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(items: [ItemModel] = [],
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    strikethroughText: String = "",
                    icon: RoundedIconParameters? = nil,
                    tag: TagParameters? = nil,
                    button: ButtonParameters? = nil,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXxs,
                                                leading: 0,
                                                bottom: Ocean.size.spacingStackXxs,
                                                trailing: 0),
                    state: State = .normal,
                    size: Size = .normal,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.items = items
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

        public class ItemModel: ObservableObject, Identifiable {
            @Published public var text: String
            @Published public var value: String
            @Published public var valueColor: UIColor
            @Published public var isBoldValue: Bool
            @Published public var newValue: String
            @Published public var newValueColor: UIColor
            @Published public var imageIcon: UIImage?
            @Published public var imageColor: UIColor

            public init(text: String = "",
                        value: String = "",
                        valueColor: UIColor = Ocean.color.colorInterfaceDarkDeep,
                        isBoldValue: Bool = false,
                        newValue: String = "",
                        newValueColor: UIColor = Ocean.color.colorStatusPositiveDeep,
                        imageIcon: UIImage? = nil,
                        imageColor: UIColor = Ocean.color.colorStatusPositiveDeep) {
                self.text = text
                self.value = value
                self.valueColor = valueColor
                self.isBoldValue = isBoldValue
                self.newValue = newValue
                self.newValueColor = newValueColor
                self.imageIcon = imageIcon
                self.imageColor = imageColor
            }
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
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {

                if parameters.showSkeleton {
                    getSkeletonView()
                } else {
                    ForEach(parameters.items.indices, id: \.self) { index in
                        getItemView(item: parameters.items[index])
                    }
                }
            }
            .padding(parameters.padding)
            .background(Color(Ocean.color.colorInterfaceLightPure))
        }

        // MARK: Private Methods

        @ViewBuilder
        private func getItemView(item: InlineTextListItemParameters.ItemModel) -> some View {
            HStack {
                Typography.paragraph { label in
                    label.parameters.text = item.text
                }

                Spacer()

                if let icon = item.imageIcon {
                    Image(uiImage: icon.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(item.imageColor))
                }

                if let tag = parameters.tag {
                    Tag.init(parameters: tag)
                }

                if !item.newValue.isEmpty, !item.value.isEmpty {
                    Typography.paragraph { label in
                        label.parameters.text = item.value
                        label.parameters.textColor = item.valueColor
                        label.parameters.strikethrough = true
                    }
                    Typography.paragraph { label in
                        label.parameters.text = item.newValue
                        label.parameters.textColor = item.newValueColor
                    }
                } else {
                    Typography.paragraph { label in
                        label.parameters.text = item.value
                        label.parameters.textColor = item.valueColor
                        label.parameters.font = item.isBoldValue
                        ? .baseBold(size: Ocean.font.fontSizeXs)
                        : .baseRegular(size: Ocean.font.fontSizeXs)
                    }
                }

                if let roundedIcon = parameters.icon {
                    RoundedIcon.init(parameters: roundedIcon)
                }

                if let button = parameters.button {
                    Button.init(parameters: button)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }

        private func getSkeletonView() -> some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Skeleton { skeleton in
                    skeleton.parameters.lines = 1
                    skeleton.parameters.height = Ocean.size.spacingStackSm
                }
                Spacer()
                OceanSwiftUI.Skeleton { skeleton in
                    skeleton.parameters.lines = 1
                    skeleton.parameters.height = Ocean.size.spacingStackSm
                }
            }
        }

        private func getStatusColor() -> UIColor {
            if let customColor = parameters.descriptionColor {
                return customColor
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
            case .withAction:
                return Ocean.color.colorInterfaceDarkDown
            }
        }
    }
}
