//
//  OceanSwiftUI+TransactionListItem.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 18/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class TransactionListItemParameters: ObservableObject {
        @Published public var icon: UIImage?
        @Published public var iconColor: UIColor
        @Published public var level1: String
        @Published public var level2: String
        @Published public var level3: String
        @Published public var level4: String
        @Published public var level1Style: TypographyParameters.Style
        @Published public var level2Style: TypographyParameters.Style
        @Published public var level3Style: TypographyParameters.Style
        @Published public var level4Style: TypographyParameters.Style
        @Published public var value1: Double
        @Published public var value1Text: String?
        @Published public var value2: Double?
        @Published public var value3: String
        @Published public var value1Style: TypographyParameters.Style
        @Published public var value2Style: TypographyParameters.Style
        @Published public var value3Style: TypographyParameters.Style
        @Published public var value1Color: UIColor?
        @Published public var value1Status: ValueStatus
        @Published public var value1HasSign: Bool
        @Published public var tagIcon: UIImage?
        @Published public var tagTitle: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var hasDivider: Bool
        @Published public var hasChevron: Bool
        @Published public var hasCheckbox: Bool
        @Published public var hasError: Bool
        @Published public var isEnabled: Bool
        @Published public var isSelected: Bool
        @Published public var padding: EdgeInsets
        @Published public var lineLimitLevel1: Int?
        @Published public var lineLimitLevel2: Int?
        @Published public var lineLimitLevel3: Int?
        @Published public var lineLimitLevel4: Int?
        @Published public var iconLineTop: Bool
        @Published public var iconLineBottom: Bool
        public var onSelection: (Bool) -> Void
        public var onTouch: () -> Void

        public var sign: String {
            if !value1HasSign { return "" }
            
            switch value1Status {
            case .positive:
                return "+"
            case .negative:
                return "-"
            default:
                return ""
            }
        }

        public init(icon: UIImage? = nil,
                    iconColor: UIColor = Ocean.color.colorInterfaceDarkUp,
                    level1: String = "",
                    level2: String = "",
                    level3: String = "",
                    level4: String = "",
                    level1Style: TypographyParameters.Style = .description,
                    level2Style: TypographyParameters.Style = .paragraph,
                    level3Style: TypographyParameters.Style = .captionBold,
                    level4Style: TypographyParameters.Style = .caption,
                    value1: Double = 0.0,
                    value1Text: String? = nil,
                    value2: Double? = nil,
                    value3: String = "",
                    value1Style: TypographyParameters.Style = .heading4,
                    value2Style: TypographyParameters.Style = .description,
                    value3Style: TypographyParameters.Style = .captionBold,
                    value1Color: UIColor? = nil,
                    value1Status: ValueStatus = .neutral,
                    value1HasSign: Bool = true,
                    tagIcon: UIImage? = nil,
                    tagTitle: String = "",
                    tagStatus: TagParameters.Status = .highlightNeutral,
                    hasDivider: Bool = true,
                    hasChevron: Bool = false,
                    hasCheckbox: Bool = false,
                    hasError: Bool = false,
                    isEnabled: Bool = true,
                    isSelected: Bool = false,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXxs),
                    lineLimitLevel1: Int? = nil,
                    lineLimitLevel2: Int? = nil,
                    lineLimitLevel3: Int? = nil,
                    lineLimitLevel4: Int? = nil,
                    iconLineTop: Bool = false,
                    iconLineBottom: Bool = false,
                    onSelection: @escaping (Bool) -> Void = { _ in },
                    onTouch: @escaping () -> Void = { }) {
            self.icon = icon
            self.iconColor = iconColor
            self.level1 = level1
            self.level2 = level2
            self.level3 = level3
            self.level4 = level4
            self.level1Style = level1Style
            self.level2Style = level2Style
            self.level3Style = level3Style
            self.level4Style = level4Style
            self.value1 = value1
            self.value1Text = value1Text
            self.value2 = value2
            self.value3 = value3
            self.value1Style = value1Style
            self.value2Style = value2Style
            self.value3Style = value3Style
            self.value1Color = value1Color
            self.value1Status = value1Status
            self.value1HasSign = value1HasSign
            self.tagIcon = tagIcon
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.hasDivider = hasDivider
            self.hasCheckbox = hasCheckbox
            self.hasError = hasError
            self.isEnabled = isEnabled
            self.isSelected = isSelected
            self.padding = padding
            self.lineLimitLevel1 = lineLimitLevel1
            self.lineLimitLevel2 = lineLimitLevel2
            self.lineLimitLevel3 = lineLimitLevel3
            self.lineLimitLevel4 = lineLimitLevel4
            self.iconLineTop = iconLineTop
            self.iconLineBottom = iconLineBottom
            self.hasChevron = hasChevron
            self.onSelection = onSelection
            self.onTouch = onTouch
        }

        public enum ValueStatus {
            case neutral
            case positive
            case negative
            case processing
            case cancelled
        }
        
        func duplicate() -> TransactionListItemParameters {
            return TransactionListItemParameters(
                icon: self.icon,
                iconColor: self.iconColor,
                level1: self.level1,
                level2: self.level2,
                level3: self.level3,
                level4: self.level4,
                level1Style: self.level1Style,
                level2Style: self.level2Style,
                level3Style: self.level3Style,
                level4Style: self.level4Style,
                value1: self.value1,
                value1Text: self.value1Text,
                value2: self.value2,
                value3: self.value3,
                value1Style: self.value1Style,
                value2Style: self.value2Style,
                value3Style: self.value3Style,
                value1Color: self.value1Color,
                value1Status: self.value1Status,
                value1HasSign: self.value1HasSign,
                tagIcon: self.tagIcon,
                tagTitle: self.tagTitle,
                tagStatus: self.tagStatus,
                hasDivider: self.hasDivider,
                hasChevron: self.hasChevron,
                hasCheckbox: self.hasCheckbox,
                hasError: self.hasError,
                isEnabled: self.isEnabled,
                isSelected: self.isSelected,
                padding: self.padding,
                lineLimitLevel1: self.lineLimitLevel1,
                lineLimitLevel2: self.lineLimitLevel2,
                lineLimitLevel3: self.lineLimitLevel3,
                lineLimitLevel4: self.lineLimitLevel4,
                iconLineTop: self.iconLineTop,
                iconLineBottom: self.iconLineBottom,
                onSelection: self.onSelection,
                onTouch: self.onTouch
            )
        }
    }

    public struct TransactionListItem: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionListItemParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: TransactionListItemParameters = TransactionListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI
        public var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    leadingView
                    
                    centerView
                    
                    trailingView
                }
                .padding(parameters.padding)

                if parameters.hasDivider {
                    OceanSwiftUI.Divider()
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(Ocean.color.colorInterfaceLightPure))
            .onTapGesture {
                parameters.onTouch()
            }
            .allowsHitTesting(parameters.isEnabled)
        }

        @ViewBuilder
        private var leadingView: some View {
            HStack(spacing: 0) {
                if let icon = parameters.icon {
                    VStack(alignment: .center, spacing: Ocean.size.spacingStackXxxs) {
                        OceanSwiftUI.Divider { view in
                            view.parameters.axis = .vertical
                        }
                        .opacity(parameters.iconLineTop ? 1 : 0)
                        
                        
                        Image(uiImage: icon)
                            .renderingMode(.template)
                            .foregroundColor(Color(parameters.iconColor))
                        
                        OceanSwiftUI.Divider { view in
                            view.parameters.axis = .vertical
                        }
                        .opacity(parameters.iconLineBottom ? 1 : 0)
                    }
                    .padding(.vertical, -Ocean.size.spacingStackXs)
                    
                    Spacer()
                        .frame(width: Ocean.size.spacingStackXxsExtra)
                } else if parameters.hasCheckbox {
                    OceanSwiftUI.CheckboxGroup { group in
                        group.parameters.hasError = parameters.hasError
                        group.parameters.items = [.init(isSelected: parameters.isSelected,
                                                        isEnabled: parameters.isEnabled)]
                        group.parameters.onTouch = { items in
                            guard let item = items.first else { return }
                            parameters.onSelection(item.isSelected)
                        }
                    }
                    
                    Spacer()
                        .frame(width: Ocean.size.spacingStackXxsExtra)
                }
            }
        }

        @ViewBuilder
        private var centerView: some View {
            VStack(alignment: .leading, spacing: 0) {
                if !parameters.level4.isEmpty {
                    OceanSwiftUI.Typography { label in
                        label.parameters.style = parameters.level4Style
                        label.parameters.text = parameters.level4
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorBrandPrimaryDeep
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = parameters.lineLimitLevel4 ?? 1
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)
                }

                if !parameters.level1.isEmpty {
                    OceanSwiftUI.Typography { label in
                        label.parameters.style = parameters.level1Style
                        label.parameters.text = parameters.level1
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorInterfaceDarkDown
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = parameters.lineLimitLevel1 ?? 2
                    }
                }

                if !parameters.level2.isEmpty {

                    if !parameters.level1.isEmpty {
                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxxs)
                    }

                    OceanSwiftUI.Typography { label in
                        label.parameters.style = parameters.level2Style
                        label.parameters.text = parameters.level2
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorInterfaceDarkDeep
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = parameters.lineLimitLevel2 ?? 1
                    }
                }

                if !parameters.level3.isEmpty {
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)

                    OceanSwiftUI.Typography { label in
                        label.parameters.style = parameters.level3Style
                        label.parameters.text = parameters.level3
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorInterfaceDarkDown
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = parameters.lineLimitLevel3 ?? 1
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing, Ocean.size.spacingStackXxxs)
        }

        private func getValue1Color() -> UIColor {
            if !parameters.isEnabled {
                return Ocean.color.colorInterfaceDarkUp
            }

            switch parameters.value1Status {
            case .neutral:
                return Ocean.color.colorInterfaceDarkDeep
            case .positive:
                return Ocean.color.colorStatusPositiveDeep
            case .negative:
                return Ocean.color.colorInterfaceDarkDeep
            case .cancelled, .processing:
                return Ocean.color.colorInterfaceDarkUp
            }
        }

        @ViewBuilder
        private var trailingView: some View {
            HStack {
                VStack(alignment: .trailing) {
                    OceanSwiftUI.Typography { label in
                        if let text = parameters.value1Text {
                            label.parameters.text = text
                        } else {
                            label.parameters.text = "\(parameters.sign) \(parameters.value1.toCurrency(symbolSpace: true) ?? " R$ 0,00")"
                        }
                        label.parameters.style = parameters.value1Style
                        label.parameters.textColor = parameters.value1Color ?? getValue1Color()
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                        label.parameters.strikethrough = parameters.value1Status == .cancelled
                        label.parameters.strikethroughColor = getValue1Color()
                    }

                    if let value = parameters.value2?.toCurrency() {
                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxxs)

                        OceanSwiftUI.Typography { label in
                            label.parameters.style = parameters.value2Style
                            label.parameters.text = value
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            label.parameters.lineLimit = 1
                        }
                    }

                    if !parameters.tagTitle.isEmpty {

                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxxs)

                        OceanSwiftUI.Tag { tag in
                            tag.parameters.icon = parameters.tagIcon
                            tag.parameters.label = parameters.tagTitle
                            tag.parameters.status = parameters.isEnabled
                            ? parameters.tagStatus
                            : .neutralInterface
                        }
                    }

                    if !parameters.value3.isEmpty {
                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxxs)

                        OceanSwiftUI.Typography { label in
                            label.parameters.style = parameters.value3Style
                            label.parameters.text = parameters.value3
                            label.parameters.textColor = parameters.isEnabled
                            ? Ocean.color.colorInterfaceDarkDown
                            : Ocean.color.colorInterfaceDarkUp
                            label.parameters.lineLimit = 1
                        }
                    }
                }

                if parameters.hasChevron {
                    Image(uiImage: Ocean.icon.chevronRightSolid)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .frame(width: 20, height: 20)
                } else {
                    Spacer()
                        .frame(width: Ocean.size.spacingStackXxs)
                }
            }
        }
    }
}
