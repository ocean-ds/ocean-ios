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
        @Published public var isCaptionBold: Bool
        @Published public var captionColor: UIColor
        @Published public var info: String
        @Published public var infoLineLimit: Int?
        @Published public var icon: UIImage?
        @Published public var iconColor: UIColor
        @Published public var iconWidth: CGFloat
        @Published public var iconHeight: CGFloat
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var tagSize: OceanSwiftUI.TagParameters.Size
        @Published public var tagOrientation: OceanSwiftUI.TextListItemParameters.TagOrientation
        @Published public var backgroundColor: UIColor?
        @Published public var state: OceanSwiftUI.TextListItemParameters.State
        @Published public var checkboxIcon: UIImage?
        @Published public var actionIcon: UIImage?
        @Published public var hasCheckbox: Bool
        @Published public var hasRadioButton: Bool
        @Published public var isChecked: Bool
        @Published public var isEnabled: Bool
        @Published public var hasError: Bool
        @Published public var hasAction: Bool
        @Published public var hasLocked: Bool
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets
        @Published public var paddingNotReadOnly: EdgeInsets

        public var onSelection: (Bool) -> Void
        public var onTouch: () -> Void

        public init(title: String = "",
                    titleLineLimit: Int? = nil,
                    description: String = "",
                    descriptionLineLimit: Int? = nil,
                    caption: String = "",
                    captionLineLimit: Int? = nil,
                    isCaptionBold: Bool = false,
                    captionColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    info: String = "",
                    infoLineLimit: Int? = nil,
                    icon: UIImage? = nil,
                    iconColor: UIColor = Ocean.color.colorBrandPrimaryDown,
                    iconWidth: CGFloat = 24,
                    iconHeight: CGFloat = 24,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: OceanSwiftUI.TagParameters.Status = .positive,
                    tagSize: OceanSwiftUI.TagParameters.Size = .small,
                    tagOrientation: OceanSwiftUI.TextListItemParameters.TagOrientation = .vertical,
                    backgroundColor: UIColor? = nil,
                    state: OceanSwiftUI.TextListItemParameters.State = .normal,
                    checkboxIcon: UIImage? = nil,
                    actionIcon: UIImage? = nil,
                    hasCheckbox: Bool = false,
                    hasRadioButton: Bool = false,
                    isChecked: Bool = false,
                    isEnabled: Bool = true,
                    hasError: Bool = false,
                    hasAction: Bool = false,
                    hasLocked: Bool = false,
                    showSkeleton: Bool = false,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXxs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXxs,
                                                trailing: Ocean.size.spacingStackXs),
                    paddingNotReadOnly: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                           leading: Ocean.size.spacingStackXs,
                                                           bottom: Ocean.size.spacingStackXs,
                                                           trailing: Ocean.size.spacingStackXxs),
                    onSelection: @escaping (Bool) -> Void = { _ in },
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.titleLineLimit = titleLineLimit
            self.description = description
            self.descriptionLineLimit = descriptionLineLimit
            self.caption = caption
            self.captionLineLimit = captionLineLimit
            self.isCaptionBold = isCaptionBold
            self.captionColor = captionColor
            self.info = info
            self.infoLineLimit = infoLineLimit
            self.icon = icon
            self.iconColor = iconColor
            self.iconWidth = iconWidth
            self.iconHeight = iconHeight
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.tagOrientation = tagOrientation
            self.backgroundColor = backgroundColor
            self.state = state
            self.checkboxIcon = checkboxIcon
            self.actionIcon = actionIcon
            self.hasCheckbox = hasCheckbox
            self.hasRadioButton = hasRadioButton
            self.isChecked = isChecked
            self.isEnabled = isEnabled
            self.hasError = hasError
            self.hasAction = hasAction
            self.hasLocked = hasLocked
            self.showSkeleton = showSkeleton
            self.padding = padding
            self.paddingNotReadOnly = paddingNotReadOnly
            self.onSelection = onSelection
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
            let isNotReadOnly = parameters.hasAction || parameters.hasRadioButton || parameters.hasCheckbox
            
            if parameters.showSkeleton {
                OceanSwiftUI.Skeleton()
            } else {
                HStack(spacing: Ocean.size.spacingStackXxsExtra) {
                    if let icon = parameters.icon {
                        Image(uiImage: icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: parameters.iconWidth, height: parameters.iconHeight)
                            .foregroundColor(Color(parameters.iconColor))
                    }

                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                                if !parameters.title.isEmpty {
                                    OceanSwiftUI.Typography.paragraph { label in
                                        label.parameters.text = parameters.title
                                        label.parameters.lineLimit = parameters.titleLineLimit
                                        label.parameters.textColor = parameters.isEnabled ? Ocean.color.colorInterfaceDarkDeep : Ocean.color.colorInterfaceDarkUp
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
                            Spacer()
                        }

                        if !parameters.caption.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxxs)

                            OceanSwiftUI.Typography { label in
                                label.parameters.text = parameters.caption
                                label.parameters.font = parameters.isCaptionBold
                                    ? .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                                    : .baseRegular(size: Ocean.font.fontSizeXxxs)
                                label.parameters.textColor = parameters.captionColor
                                label.parameters.lineLimit = parameters.captionLineLimit
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

                        if !parameters.tagLabel.isEmpty && parameters.tagOrientation == .vertical {
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

                    if !parameters.tagLabel.isEmpty && parameters.tagOrientation == .horizontal {
                        OceanSwiftUI.Tag { tag in
                            tag.parameters.label = parameters.tagLabel
                            tag.parameters.icon = parameters.tagIcon
                            tag.parameters.status = parameters.tagStatus
                            tag.parameters.size = parameters.tagSize
                        }
                        .fixedSize()
                    }

                    if parameters.hasAction {
                        Image(uiImage: parameters.actionIcon ?? Ocean.icon.chevronRightSolid)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                    } else if parameters.hasCheckbox {
                        OceanSwiftUI.CheckboxGroup { group in
                            group.parameters.icon = parameters.checkboxIcon
                            group.parameters.hasError = parameters.hasError
                            group.parameters.items = [ .init(isSelected: self.parameters.isChecked,
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
                            group.parameters.setSelectedIndex(self.parameters.isChecked ? 0 : -1)
                            group.parameters.onTouch = { _, _ in
                                parameters.onTouch()
                            }
                        }
                    } else if parameters.hasLocked {
                        Image(uiImage: Ocean.icon.lockClosedSolid)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(isNotReadOnly ? parameters.paddingNotReadOnly : parameters.padding)
                .background(Color(parameters.backgroundColor ?? Ocean.color.colorInterfaceLightPure))
                .transform(condition: parameters.isEnabled, transform: { view in
                    view.onTapGesture {
                        parameters.onTouch()

                        if parameters.hasCheckbox {
                            parameters.isChecked.toggle()
                        } else if parameters.hasRadioButton {
                            parameters.isChecked = true
                        }
                    }
                })
            }
        }
    }
}

