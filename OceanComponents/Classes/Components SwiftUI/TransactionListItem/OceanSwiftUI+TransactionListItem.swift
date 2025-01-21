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
        @Published public var level1: String
        @Published public var level2: String
        @Published public var level3: String
        @Published public var level4: String
        @Published public var value1: Double
        @Published public var value1Text: String?
        @Published public var value2: Double?
        @Published public var value3: String
        @Published public var value1Status: ValueStatus
        @Published public var tagIcon: UIImage?
        @Published public var tagTitle: String
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var hasDivider: Bool
        @Published public var hasChevron: Bool
        @Published public var hasCheckbox: Bool
        @Published public var hasError: Bool
        @Published public var isEnabled: Bool
        @Published public var isSelected: Bool
        @Published public var padding: EdgeInsets
        @Published public var lineLimitLevel3: Int?
        public var onSelection: (Bool) -> Void
        public var onTouch: () -> Void

        public var sign: String {
            switch value1Status {
            case .positive:
                return "+"
            case .negative:
                return "-"
            default:
                return ""
            }
        }

        public init(level1: String = "",
                    level2: String = "",
                    level3: String = "",
                    level4: String = "",
                    value1: Double = 0.0,
                    value2: Double? = nil,
                    value3: String = "",
                    value1Status: ValueStatus = .neutral,
                    tagIcon: UIImage? = nil,
                    tagTitle: String = "",
                    tagStatus: OceanSwiftUI.TagParameters.Status = .highlightNeutral,
                    hasDivider: Bool = true,
                    hasChevron: Bool = false,
                    hasCheckbox: Bool = false,
                    hasError: Bool = false,
                    isEnabled: Bool = true,
                    isSelected: Bool = false,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs),
                    lineLimitLevel3: Int? = nil,
                    onSelection: @escaping (Bool) -> Void = { _ in },
                    onTouch: @escaping () -> Void = { }) {
            self.level1 = level1
            self.level2 = level2
            self.level3 = level3
            self.level4 = level4
            self.value1 = value1
            self.value2 = value2
            self.value3 = value3
            self.value1Status = value1Status
            self.tagIcon = tagIcon
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.hasDivider = hasDivider
            self.hasCheckbox = hasCheckbox
            self.hasError = hasError
            self.isEnabled = isEnabled
            self.isSelected = isSelected
            self.padding = padding
            self.lineLimitLevel3 = lineLimitLevel3
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
                HStack(spacing: Ocean.size.spacingStackXxs) {
                    if parameters.hasCheckbox {
                        leadingView
                    }
                    centerView
                    trailingView
                }
                .padding(parameters.padding)

                if parameters.hasDivider {
                    Divider()
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
                    .frame(width: Ocean.size.spacingStackXxs)
            }
        }

        @ViewBuilder
        private var centerView: some View {
            VStack(alignment: .leading) {
                if !parameters.level4.isEmpty {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = parameters.level4
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorBrandPrimaryDeep
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)
                }

                if !parameters.level1.isEmpty {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = parameters.level1
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorInterfaceDarkDeep
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = 2
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                    }
                }

                if !parameters.level2.isEmpty {

                    if !parameters.level1.isEmpty {
                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxxs)
                    }

                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = parameters.level2
                        label.parameters.textColor = parameters.isEnabled
                        ? Ocean.color.colorInterfaceDarkDown
                        : Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                    }
                }

                if !parameters.level3.isEmpty {
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)

                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = parameters.level3
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                        label.parameters.lineLimit = parameters.lineLimitLevel3 ?? 1
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
                    OceanSwiftUI.Typography.heading5 { label in
                        if let text = parameters.value1Text {
                            label.parameters.text = text
                        } else {
                            label.parameters.text = "\(parameters.sign) \(parameters.value1.toCurrency(symbolSpace: true) ?? " R$ 0,00")"
                        }
                        label.parameters.textColor = getValue1Color()

                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                        label.parameters.strikethrough = parameters.value1Status == .cancelled
                        label.parameters.strikethroughColor = getValue1Color()
                    }

                    if let value = parameters.value2?.toCurrency() {
                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxxs)

                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = value
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            label.parameters.lineLimit = 1
                            label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
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

                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = parameters.value3
                            label.parameters.textColor = parameters.isEnabled
                            ? Ocean.color.colorInterfaceDarkDown
                            : Ocean.color.colorInterfaceDarkUp
                            label.parameters.lineLimit = 1
                            label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                        }
                    }
                }

                if parameters.hasChevron {
                    Image(uiImage: Ocean.icon.chevronRightSolid)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}
