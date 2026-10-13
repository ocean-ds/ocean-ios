//
//  OceanSwiftUI+TransactionFooter.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 28/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public enum TransactionFooterType: Equatable {
        case `default`
        case highlight
    }

    /// Label and value shown in a Transaction Footer 2.0 row.
    public struct TransactionFooterRow {
        public var label: String
        public var value: String
        public var info: String?

        public init(label: String, value: String, info: String? = nil) {
            self.label = label
            self.value = value
            self.info = info
        }
    }

    /// Optional notice content displayed above the footer body.
    public struct TransactionFooterNotice {
        public var icon: Image?
        public var title: String?
        public var description: String

        public init(icon: Image? = Image(uiImage: Ocean.icon.checkCircleSolid!),
                    title: String? = nil,
                    description: String) {
            self.icon = icon
            self.title = title
            self.description = description
        }
    }

    public struct TransactionFooterTotal {
        public var label: String
        public var value: String

        public init(label: String, value: String) {
            self.label = label
            self.value = value
        }
    }

    /// Content for Transaction Footer 2.0.
    public struct TransactionFooterContent {
        public var type: TransactionFooterType
        public var notice: TransactionFooterNotice?
        public var mainItem: TransactionFooterRow?
        public var details: [TransactionFooterRow]
        public var total: TransactionFooterTotal
        public var button: ButtonParameters

        public init(type: TransactionFooterType = .default,
                    notice: TransactionFooterNotice? = nil,
                    mainItem: TransactionFooterRow? = nil,
                    details: [TransactionFooterRow] = [],
                    total: TransactionFooterTotal,
                    button: ButtonParameters) {
            self.type = type
            self.notice = notice
            self.mainItem = mainItem
            self.details = details
            self.total = total
            self.button = button
        }
    }

    public enum TransactionFooterStyle {
        /// Transaction Footer 1.0. Kept as the default for compatibility.
        @available(*, deprecated, message: "Transaction Footer 1.0 — use .v2")
        case legacy

        /// Transaction Footer 2.0 with explicit main item, details and total.
        case v2(TransactionFooterContent)
    }

    private struct TransactionFooterTopCorners: Shape {
        let radius: CGFloat

        func path(in rect: CGRect) -> Path {
            let radius = min(radius, min(rect.width, rect.height) / 2)
            guard radius > 0 else { return Path(rect) }

            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addArc(
                center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                radius: radius,
                startAngle: .degrees(270),
                endAngle: .degrees(360),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }

    // MARK: Parameters

    public class TransactionFooterParameters: ObservableObject {
        @Published public var items: [ItemModel]
        @Published public var primaryButton: ButtonParameters?
        @Published public var secondaryButton: ButtonParameters?
        @Published public var buttonOrientation: ButtonOrientation
        @Published public var showSkeleton: Bool
        @Published public var skeletonLines: Int
        /// Extra spacing between rows. Rows already carry `spacingStackXxs` of vertical
        /// padding each (the Figma Inline Text List Item), so with the default `0` two texts
        /// end up `spacingStackXs` apart, exactly like the design.
        @Published public var interlineSpacing: CGFloat
        @Published public var padding: EdgeInsets
        @Published public var style: TransactionFooterStyle

        public init(items: [ItemModel] = [],
                    primaryButton: ButtonParameters? = nil,
                    secondaryButton: ButtonParameters? = nil,
                    buttonOrientation: ButtonOrientation = .horizontal,
                    showSkeleton: Bool = false,
                    skeletonLines: Int = 3,
                    interlineSpacing: CGFloat = 0,
                    padding: EdgeInsets = .init(top: 0,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs),
                    style: TransactionFooterStyle = .legacy) {
            self.items = items
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
            self.buttonOrientation = buttonOrientation
            self.showSkeleton = showSkeleton
            self.skeletonLines = skeletonLines
            self.interlineSpacing = interlineSpacing
            self.padding = padding
            self.style = style
        }

        public enum ButtonOrientation {
            case horizontal
            case vertical
        }

        public class ItemModel: ObservableObject, Identifiable {
            @Published public var text: String
            @Published public var value: String
            @Published public var valueColor: UIColor
            @Published public var isBoldValue: Bool
            @Published public var newValue: String
            @Published public var newValueColor: UIColor
            @Published public var caption: String
            @Published public var imageIcon: UIImage?
            @Published public var imageColor: UIColor

            public init(text: String = "",
                        value: String = "",
                        valueColor: UIColor = Ocean.color.colorInterfaceDarkDeep,
                        isBoldValue: Bool = false,
                        newValue: String = "",
                        newValueColor: UIColor = Ocean.color.colorStatusPositiveDeep,
                        caption: String = "",
                        imageIcon: UIImage? = nil,
                        imageColor: UIColor = Ocean.color.colorStatusPositiveDeep) {
                self.text = text
                self.value = value
                self.valueColor = valueColor
                self.isBoldValue = isBoldValue
                self.newValue = newValue
                self.newValueColor = newValueColor
                self.caption = caption
                self.imageIcon = imageIcon
                self.imageColor = imageColor
            }
        }
    }

    public struct TransactionFooter: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionFooter) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionFooterParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: TransactionFooterParameters = TransactionFooterParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        @ViewBuilder
        public var body: some View {
            switch parameters.style {
            case .legacy:
                legacyBody
            case .v2(let content):
                transactionBody(content)
            }
        }

        private var legacyBody: some View {
            // Figma "Transaction Footer": rows are Inline Text List Items (vertical padding
            // `spacingStackXxs` each, no gap between them) and the button bar sits
            // `spacingStackXs` below the last row. Without rows the button comes first, so the
            // rows block is left out instead of contributing an empty view plus the stack spacing.
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                if parameters.showSkeleton {
                    getSkeletonView(skeletonLines: parameters.skeletonLines)
                } else {
                    if !parameters.items.isEmpty {
                        VStack(spacing: parameters.interlineSpacing) {
                            ForEach(parameters.items.indices, id: \.self) { index in
                                getItemView(item: parameters.items[index])
                                    .padding(.vertical, Ocean.size.spacingStackXxs)
                            }
                        }
                    }

                    if parameters.buttonOrientation == .horizontal {
                        HStack(spacing: Ocean.size.spacingStackXxsExtra) {
                            getButtonsView()
                        }
                    } else {
                        VStack(spacing: Ocean.size.spacingStackXxsExtra) {
                            getButtonsView()
                        }
                    }
                }
            }
            .padding(parameters.padding)
        }

        private func transactionBody(_ content: TransactionFooterContent) -> some View {
            VStack(spacing: 0) {
                if let notice = content.notice {
                    noticeView(notice)
                        .padding(.bottom, -Ocean.size.spacingStackXs)
                        .zIndex(0)
                }

                VStack(spacing: 0) {
                    if let mainItem = content.mainItem {
                        transactionRow(mainItem, density: .default)
                    }

                    if content.mainItem != nil && !content.details.isEmpty {
                        transactionDivider
                    }

                    if !content.details.isEmpty {
                        VStack(spacing: 0) {
                            ForEach(content.details.indices, id: \.self) { index in
                                transactionRow(content.details[index], density: .compact)
                            }
                        }
                        .padding(.vertical, Ocean.size.spacingStackXxs)
                    }

                    if content.mainItem != nil || !content.details.isEmpty {
                        transactionDivider
                    }

                    totalRow(content.total)

                    OceanSwiftUI.Button(parameters: content.button)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                        .padding(.bottom, Ocean.size.spacingStackXs)
                }
                .frame(maxWidth: .infinity)
                .background(
                    TransactionFooterTopCorners(
                        radius: content.type == .highlight ? Ocean.size.borderRadiusMd : 0
                    )
                    .fill(Color(content.type == .default
                                ? Ocean.color.colorInterfaceLightPure
                                : Ocean.color.colorInterfaceLightUp))
                        .ignoresSafeArea(.container, edges: .bottom)
                )
                .overlay(alignment: .top) {
                    if content.type == .default {
                        Rectangle()
                            .fill(Color(Ocean.color.colorInterfaceLightDown))
                            .frame(height: 1)
                    }
                }
                .zIndex(1)
            }
        }

        private enum TransactionFooterRowDensity: Equatable {
            case `default`
            case compact
        }

        private func transactionRow(
            _ row: TransactionFooterRow,
            density: TransactionFooterRowDensity
        ) -> some View {
            HStack(alignment: .center) {
                OceanSwiftUI.Typography.paragraph { label in
                    label.parameters.text = row.label
                    label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                    label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                }
                Spacer(minLength: Ocean.size.spacingStackXxs)
                VStack(alignment: .trailing, spacing: Ocean.size.spacingStackXxxs) {
                    OceanSwiftUI.Typography.paragraph { value in
                        value.parameters.text = row.value
                        value.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                        value.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                        value.parameters.multilineTextAlignment = .trailing
                    }

                    if let info = row.info {
                        OceanSwiftUI.Typography.captionBold { additionalData in
                            additionalData.parameters.text = info
                            additionalData.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            additionalData.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                            additionalData.parameters.lineLimit = transactionListTextLineLimit
                            additionalData.parameters.lineSpacing = figmaLineSpacing(
                                .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                            )
                            additionalData.parameters.multilineTextAlignment = .trailing
                        }
                    }
                }
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .padding(
                .vertical,
                density == .default ? Ocean.size.spacingStackXs : Ocean.size.spacingStackXxs
            )
        }

        private func totalRow(_ total: TransactionFooterTotal) -> some View {
            HStack(alignment: .firstTextBaseline) {
                OceanSwiftUI.Typography.paragraph { label in
                    label.parameters.text = total.label
                    label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeXs)
                }
                Spacer(minLength: Ocean.size.spacingStackXxs)
                OceanSwiftUI.Typography.paragraph { value in
                    value.parameters.text = total.value
                    value.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                    value.parameters.font = .baseBold(size: Ocean.font.fontSizeXs)
                }
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .padding(.vertical, Ocean.size.spacingStackXs)
        }

        private var transactionDivider: some View {
            OceanSwiftUI.Divider()
                .padding(.horizontal, Ocean.size.spacingStackXs)
        }

        private func noticeView(_ notice: TransactionFooterNotice) -> some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                if let icon = notice.icon {
                    icon
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(Ocean.color.colorStatusPositiveDeep))
                        .frame(width: 20, height: 20)
                }

                VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                    if let title = notice.title {
                        OceanSwiftUI.Typography.paragraph { label in
                            label.parameters.text = title
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                            label.parameters.font = .baseExtraBold(size: Ocean.font.fontSizeXxs)
                        }
                    }

                    OceanSwiftUI.Typography.paragraph { description in
                        description.parameters.text = notice.description
                        description.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                        description.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, Ocean.size.spacingStackXs)
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .padding(.bottom, Ocean.size.spacingStackMd)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color(Ocean.color.colorStatusPositiveUp)
                    .overlay(
                        Color(Ocean.color.colorStatusPositiveDeep)
                            .opacity(0.12)
                    )
            )
            .clipShape(TransactionFooterTopCorners(radius: Ocean.size.borderRadiusMd))
        }

        // MARK: Methods private

        /// Same two-column grid as `InlineTextListItem`'s text-only rows (shared
        /// `LabelValueGridRow`): a long value wraps inside its own column instead of growing
        /// into the label's, and the icon keeps its intrinsic size.
        @ViewBuilder
        private func getItemView(item: TransactionFooterParameters.ItemModel) -> some View {
            VStack(alignment: .leading, spacing: 0) {
                LabelValueGridRow(text: item.text,
                                  value: item.value,
                                  valueColor: item.valueColor,
                                  isBoldValue: item.isBoldValue,
                                  newValue: item.newValue,
                                  newValueColor: item.newValueColor,
                                  imageIcon: item.imageIcon,
                                  imageColor: item.imageColor)

                if !item.caption.isEmpty {
                    Typography.caption { label in
                        label.parameters.text = item.caption
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                    }
                    .padding(.top, Ocean.size.spacingStackXxs)
                }
            }
        }

        @ViewBuilder
        private func getButtonsView() -> some View {
            Group {
                if let button = parameters.primaryButton {
                    Button.init(parameters: button)
                }

                if let button = parameters.secondaryButton {
                    Button.init(parameters: button)
                }
            }
        }

        private func getSkeletonView(skeletonLines: Int) -> some View {
            VStack(spacing: parameters.interlineSpacing) {
                ForEach(0..<skeletonLines, id: \.self) { index in
                    HStack {
                        Typography.paragraph { label in
                            label.parameters.text = "                                        "
                            label.parameters.showSkeleton = true
                        }

                        Spacer()

                        Typography.paragraph { label in
                            label.parameters.text = "                     "
                            label.parameters.showSkeleton = true
                        }
                    }
                }
            }
        }
    }
}
