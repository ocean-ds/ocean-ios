//
//  TransactionListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 18/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public class TransactionListItemParameters: ObservableObject {
        @Published public var level1: String
        @Published public var level2: String
        @Published public var level3: String
        @Published public var level4: String
        @Published public var value1: Double
        @Published public var value2: Double?
        @Published public var value3: String
        @Published public var valueStatus: ValueStatus
        @Published public var tagIcon: UIImage?
        @Published public var tagTitle: String
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var hasDivider: Bool
        @Published public var onTouch: () -> Void

        public var sign: String {
            switch valueStatus {
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
                    valueStatus: ValueStatus = .neutral,
                    tagIcon: UIImage? = nil,
                    tagTitle: String = "",
                    tagStatus: OceanSwiftUI.TagParameters.Status = .neutral,
                    hasDivider: Bool = true,
                    onTouch: @escaping () -> Void = { }) {
            self.level1 = level1
            self.level2 = level2
            self.level3 = level3
            self.level4 = level4
            self.value1 = value1
            self.value2 = value2
            self.value3 = value3
            self.valueStatus = valueStatus
            self.tagIcon = tagIcon
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.hasDivider = hasDivider
            self.onTouch = onTouch
        }

        public enum ValueStatus {
            case neutral
            case positive
            case negative
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
            VStack {
                HStack {
                    leadingView
                    trailingView
                }
                .padding([.horizontal, .bottom], Ocean.size.spacingStackXs)

                if parameters.hasDivider {
                    Divider()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onTapGesture {
                parameters.onTouch()
            }
        }

        @ViewBuilder
        private var leadingView: some View {
            VStack(alignment: .leading) {
                if !parameters.level4.isEmpty {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = parameters.level4
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryDeep
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)
                }

                if !parameters.level1.isEmpty {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = parameters.level1
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                        label.parameters.lineLimit = 2
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxxs)
                }

                if !parameters.level2.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = parameters.level2
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)
                }

                if !parameters.level3.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = parameters.level3
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }

        @ViewBuilder
        private var trailingView: some View {
            VStack(alignment: .trailing) {
                OceanSwiftUI.Typography.heading5 { label in
                    label.parameters.text = "\(parameters.sign) \(parameters.value1.toCurrency(symbolSpace: true) ?? " R$ 0,00")"
                    label.parameters.textColor = parameters.valueStatus == .positive
                    ? Ocean.color.colorStatusPositiveDeep
                    : Ocean.color.colorInterfaceDarkDeep
                    label.parameters.lineLimit = 1
                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                }

                Spacer()
                    .frame(height: Ocean.size.spacingStackXxxs)

                if let value = parameters.value2?.toCurrency() {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = value
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxxs)
                }

                if !parameters.tagTitle.isEmpty {
                    OceanSwiftUI.Tag { tag in
                        tag.parameters.icon = parameters.tagIcon
                        tag.parameters.label = parameters.tagTitle
                        tag.parameters.status = parameters.tagStatus
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxxs)
                }

                if !parameters.value3.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = parameters.value3
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                        label.parameters.lineLimit = 1
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                    }
                }
            }
        }
    }
}

struct TransactionListItem_Preview: PreviewProvider {
    static var previews: some View {
        let view = OceanSwiftUI.TransactionListItem()
        view.parameters.level1 = "Level 1"
        view.parameters.level2 = "Level 2"
        view.parameters.level3 = "Level 3"
        view.parameters.level4 = "Level 4"
        view.parameters.value1 = 1000000
        view.parameters.value2 = 1.00
        view.parameters.value3 = "09:00"
        view.parameters.valueStatus = .positive
        view.parameters.tagTitle = "Label"
        view.parameters.tagIcon = Ocean.icon.checkSolid
        view.parameters.tagStatus = .important


        return ScrollView {
            VStack {
                view
                view
            }
        }
    }
}
