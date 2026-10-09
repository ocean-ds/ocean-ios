//
//  OceanSwiftUI+TransactionFooter.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 28/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public enum TransactionFooterV2Type: Equatable {
        case `default`
        case highlight
    }

    public struct TransactionFooterV2Total {
        public var label: String
        public var value: String

        public init(label: String, value: String) {
            self.label = label
            self.value = value
        }
    }

    public final class TransactionFooterV2Parameters: ObservableObject {
        @Published public var type: TransactionFooterV2Type
        @Published public var notice: String?
        @Published public var items: [TransactionListReadOnlyParameters]
        @Published public var total: TransactionFooterV2Total
        @Published public var button: ButtonParameters

        public init(type: TransactionFooterV2Type = .default,
                    notice: String? = nil,
                    items: [TransactionListReadOnlyParameters],
                    total: TransactionFooterV2Total,
                    button: ButtonParameters) {
            self.type = type
            self.notice = notice
            self.items = items
            self.total = total
            self.button = button
        }
    }

    public struct TransactionFooterV2: View {
        @ObservedObject public var parameters: TransactionFooterV2Parameters

        public init(parameters: TransactionFooterV2Parameters) {
            self.parameters = parameters
        }

        public var body: some View {
            VStack(spacing: 0) {
                if let notice = parameters.notice {
                    OceanSwiftUI.Typography.paragraph { label in
                        label.parameters.text = notice
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Ocean.size.spacingStackXs)
                    .background(
                        Color(red: 242 / 255.0, green: 252 / 255.0, blue: 245 / 255.0)
                            .overlay(
                                Color(red: 45 / 255.0, green: 169 / 255.0, blue: 79 / 255.0)
                                    .opacity(0.12)
                            )
                    )
                    .padding(.bottom, Ocean.size.spacingStackXs)
                }

                let visibleItems = Array(parameters.items.prefix(5))
                ForEach(Array(visibleItems.enumerated()), id: \.offset) { row in
                    OceanSwiftUI.TransactionListReadOnly(
                        parameters: rowParameters(for: row.element, index: row.offset)
                    )
                }

                OceanSwiftUI.Divider()
                    .padding(.horizontal, Ocean.size.spacingStackXs)

                HStack {
                    OceanSwiftUI.Typography.paragraph { label in
                        label.parameters.text = parameters.total.label
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                    }
                    Spacer()
                    OceanSwiftUI.Typography.paragraph { label in
                        label.parameters.text = parameters.total.value
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                    }
                }
                .padding(.horizontal, Ocean.size.spacingStackXs)
                .padding(.vertical, Ocean.size.spacingStackXs)

                OceanSwiftUI.Button(parameters: parameters.button)
                    .padding(.horizontal, Ocean.size.spacingStackXs)
                    .padding(.top, Ocean.size.spacingStackMd)
                    .padding(.bottom, Ocean.size.spacingStackXs)
            }
            .background(backgroundColor)
            .clipShape(
                parameters.type == .highlight
                    ? TransactionFooterTopCorners(radius: Ocean.size.borderRadiusMd)
                    : TransactionFooterTopCorners(radius: 0)
            )
            .overlay(alignment: .top) {
                if parameters.type == .default {
                    Rectangle()
                        .fill(Color(Ocean.color.colorInterfaceLightDown))
                        .frame(height: 1)
                }
            }
        }

        private var backgroundColor: Color {
            Color(parameters.type == .default
                  ? Ocean.color.colorInterfaceLightPure
                  : Ocean.color.colorInterfaceLightUp)
        }

        private func rowParameters(for item: TransactionListReadOnlyParameters,
                                   index: Int) -> TransactionListReadOnlyParameters {
            TransactionListReadOnlyParameters(
                state: item.state,
                icon: item.icon,
                iconColor: item.iconColor,
                contentList: item.contentList,
                amountDetails: item.amountDetails,
                showDivider: index == 0 && min(parameters.items.count, 5) > 1,
                density: index == 0 ? .default : .compact
            )
        }
    }

    private struct TransactionFooterTopCorners: Shape {
        let radius: CGFloat

        func path(in rect: CGRect) -> Path {
            guard radius > 0 else { return Path(rect) }

            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addQuadCurve(to: CGPoint(x: rect.minX + radius, y: rect.minY),
                              control: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + radius),
                              control: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }

    // MARK: Parameters

    @available(*, deprecated, message: "Use OceanSwiftUI.TransactionFooterV2 and TransactionFooterV2Parameters.")
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
                                                trailing: Ocean.size.spacingStackXs)) {
            self.items = items
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
            self.buttonOrientation = buttonOrientation
            self.showSkeleton = showSkeleton
            self.skeletonLines = skeletonLines
            self.interlineSpacing = interlineSpacing
            self.padding = padding
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

    @available(*, deprecated, message: "Use OceanSwiftUI.TransactionFooterV2.")
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

        public var body: some View {
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
