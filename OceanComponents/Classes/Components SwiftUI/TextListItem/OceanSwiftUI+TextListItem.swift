//
//  OceanSwiftUI+TextListItem.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 15/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameter

    public class TextListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var description: String
        @Published public var caption: String
        @Published public var info: String
        @Published public var icon: UIImage?

        @Published public var padding: EdgeInsets

        @Published public var state: OceanSwiftUI.TextListItemParameters.State

        @Published public var hasCheckbox: Bool
        @Published public var hasRadioButton: Bool
        @Published public var hasError: Bool
        @Published public var hasAction: Bool
        @Published public var showSkeleton: Bool

        public var onSelection: (Bool) -> Void
        public var onTouch: () -> Void

        public init(title: String = "",
                    description: String = "",
                    caption: String = "",
                    info: String = "",
                    icon: UIImage? = nil,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXxs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXxs,
                                                trailing: Ocean.size.spacingStackXs),
                    state: OceanSwiftUI.TextListItemParameters.State = .normal,
                    hasCheckbox: Bool = false,
                    hasRadioButton: Bool = false,
                    hasError: Bool = false,
                    hasAction: Bool = false,
                    showSkeleton: Bool = false,
                    onSelection: @escaping (Bool) -> Void = { _ in },
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.description = description
            self.caption = caption
            self.info = info
            self.icon = icon
            self.padding = padding
            self.state = state
            self.hasCheckbox = hasCheckbox
            self.hasRadioButton = hasRadioButton
            self.hasError = hasError
            self.hasAction = hasAction
            self.showSkeleton = showSkeleton
            self.onSelection = onSelection
            self.onTouch = onTouch
        }

        public enum State {
            case normal
            case neutral
            case positive
        }
    }

    public struct TextListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TextListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TextListItemParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: TextListItemParameters = TextListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(spacing: Ocean.size.spacingStackXs) {
                if parameters.showSkeleton {
                    Skeleton { skeleton in
                        skeleton.parameters.withImage = parameters.icon != nil
                    }
                } else {
                    if let icon = parameters.icon {
                        RoundedIcon { image in
                            image.parameters.icon = icon
                        }
                    }
                    else if parameters.hasCheckbox {
                        OceanSwiftUI.CheckboxGroup { group in
                            group.parameters.hasError = parameters.hasError
                            group.parameters.items = [ .init() ]
                            group.parameters.onTouch = { items in
                                guard let item = items.first else { return }
                                parameters.onSelection(item.isSelected)
                            }
                        }
                    } else if parameters.hasRadioButton {
                        OceanSwiftUI.RadioButtonGroup { group in
                            group.parameters.hasError = parameters.hasError
                            group.parameters.items = [ .init() ]
                            group.parameters.onTouch = { _, _ in
                                parameters.onTouch()
                            }
                        }
                    }

                    VStack(alignment: .leading) {
                        OceanSwiftUI.Typography.heading4 { label in
                            label.parameters.text = parameters.title
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                        }

                        if !parameters.description.isEmpty {
                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.description
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            }
                        }

                        if !parameters.caption.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxxs)

                            OceanSwiftUI.Typography.caption { label in
                                label.parameters.text = parameters.caption
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                            }
                        }

                        if parameters.state != .normal && !parameters.info.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxs)

                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.info
                                label.parameters.textColor = parameters.state == .neutral
                                ? Ocean.color.colorInterfaceDarkDeep
                                : Ocean.color.colorStatusPositiveDeep
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                    if parameters.hasAction {
                        Image(uiImage: Ocean.icon.chevronRightSolid)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                    }
                }

            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(parameters.padding)
            .background(Color(Ocean.color.colorInterfaceLightPure))
            .onTapGesture {
                parameters.onTouch()
            }
        }

        private struct Constants {
            static let iconSize: CGFloat = 20
            static let skeletonHeight: CGFloat = 24
        }
    }
}
