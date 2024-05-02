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
        @Published public var titleLineLimit: Int?
        @Published public var description: String
        @Published public var descriptionLineLimit: Int?
        @Published public var caption: String
        @Published public var captionLineLimit: Int?
        @Published public var info: String
        @Published public var infoLineLimit: Int?
        @Published public var icon: UIImage?
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var tagSize: OceanSwiftUI.TagParameters.Size
        @Published public var padding: EdgeInsets
        @Published public var state: OceanSwiftUI.TextListItemParameters.State
        @Published public var hasCheckbox: Bool
        @Published public var hasRadioButton: Bool
        @Published public var checked: Bool
        @Published public var isEnabled: Bool
        @Published public var hasError: Bool
        @Published public var hasAction: Bool
        @Published public var showSkeleton: Bool

        public var onSelection: (Bool) -> Void
        public var onTouch: () -> Void

        public init(title: String = "",
                    titleLineLimit: Int? = nil,
                    description: String = "",
                    descriptionLineLimit: Int? = nil,
                    caption: String = "",
                    captionLineLimit: Int? = nil,
                    info: String = "",
                    infoLineLimit: Int? = nil,
                    icon: UIImage? = nil,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: OceanSwiftUI.TagParameters.Status = .positive,
                    tagSize: OceanSwiftUI.TagParameters.Size = .small,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs),
                    state: OceanSwiftUI.TextListItemParameters.State = .normal,
                    hasCheckbox: Bool = false,
                    hasRadioButton: Bool = false,
                    checked: Bool = false,
                    isEnabled: Bool = true,
                    hasError: Bool = false,
                    hasAction: Bool = false,
                    showSkeleton: Bool = false,
                    onSelection: @escaping (Bool) -> Void = { _ in },
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.titleLineLimit = titleLineLimit
            self.description = description
            self.descriptionLineLimit = descriptionLineLimit
            self.caption = caption
            self.captionLineLimit = captionLineLimit
            self.info = info
            self.infoLineLimit = infoLineLimit
            self.icon = icon
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.padding = padding
            self.state = state
            self.hasCheckbox = hasCheckbox
            self.hasRadioButton = hasRadioButton
            self.checked = checked
            self.isEnabled = isEnabled
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
                            group.parameters.items = [ .init(isSelected: self.parameters.checked,
                                                             isEnabled: self.parameters.isEnabled) ]
                            group.parameters.onTouch = { items in
                                guard let item = items.first else { return }
                                parameters.onSelection(item.isSelected)
                            }
                        }
                    } else if parameters.hasRadioButton {
                        OceanSwiftUI.RadioButtonGroup { group in
                            group.parameters.hasError = parameters.hasError
                            group.parameters.items = [ .init() ]
                            group.parameters.isEnabled = self.parameters.isEnabled
                            group.parameters.setSelectedIndex(self.parameters.checked ? 0 : -1)
                            group.parameters.onTouch = { _, _ in
                                parameters.onTouch()
                            }
                        }
                    }

                    VStack(alignment: .leading) {
                        OceanSwiftUI.Typography.heading4 { label in
                            label.parameters.text = parameters.title
                            label.parameters.lineLimit = parameters.titleLineLimit
                            label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDeep : Ocean.color.colorInterfaceDarkUp
                        }

                        if !parameters.description.isEmpty {
                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.description
                                label.parameters.lineLimit = parameters.descriptionLineLimit
                                label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorInterfaceLightDeep
                            }
                        }

                        if !parameters.caption.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxxs)

                            OceanSwiftUI.Typography.caption { label in
                                label.parameters.text = parameters.caption
                                label.parameters.lineLimit = parameters.captionLineLimit
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                            }
                        }

                        if parameters.state != .normal && !parameters.info.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxs)

                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.info
                                label.parameters.lineLimit = parameters.infoLineLimit
                                label.parameters.textColor = parameters.state == .neutral
                                ? Ocean.color.colorInterfaceDarkDeep
                                : Ocean.color.colorStatusPositiveDeep
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
            .transform(condition: parameters.isEnabled, transform: { view in
                view.onTapGesture {
                    parameters.onTouch()
                }
            })
        }

        private struct Constants {
            static let iconSize: CGFloat = 20
            static let skeletonHeight: CGFloat = 24
        }
    }
}
