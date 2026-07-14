//
//  OceanSwiftUI+TransactionFooter.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 28/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public enum TransactionFooterVariant {
        case `default`
        case highlight
    }

    public class TransactionFooterParameters: ObservableObject {
        @Published public var items: [ItemModel]
        @Published public var primaryButton: ButtonParameters?
        @Published public var secondaryButton: ButtonParameters?
        @Published public var buttonOrientation: ButtonOrientation
        @Published public var showSkeleton: Bool
        @Published public var skeletonLines: Int
        @Published public var interlineSpacing: CGFloat
        @Published public var padding: EdgeInsets
        @Published public var variant: TransactionFooterVariant
        @Published public var sectionTitle: String
        @Published public var showBottomDivider: Bool

        public init(items: [ItemModel] = [],
                    primaryButton: ButtonParameters? = nil,
                    secondaryButton: ButtonParameters? = nil,
                    buttonOrientation: ButtonOrientation = .horizontal,
                    showSkeleton: Bool = false,
                    skeletonLines: Int = 3,
                    interlineSpacing: CGFloat = Ocean.size.spacingStackXxs,
                    padding: EdgeInsets = .init(top: 0,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs),
                    variant: TransactionFooterVariant = .default,
                    sectionTitle: String = "",
                    showBottomDivider: Bool = false) {
            self.items = items
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
            self.buttonOrientation = buttonOrientation
            self.showSkeleton = showSkeleton
            self.skeletonLines = skeletonLines
            self.interlineSpacing = interlineSpacing
            self.padding = padding
            self.variant = variant
            self.sectionTitle = sectionTitle
            self.showBottomDivider = showBottomDivider
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

        public var body: some View {
            if parameters.variant == .highlight {
                contentView
                    .padding(.top, Ocean.size.spacingStackXxs)
                    .background(Color(Ocean.color.colorInterfaceLightUp))
                    .cornerRadius(Ocean.size.borderRadiusLg, corners: [.topLeft, .topRight])
            } else {
                contentView
                    .padding(.top, Ocean.size.spacingStackXxs)
                    .overlay(topDivider, alignment: .top)
            }
        }

        // Divisor de topo da variante Default (Figma), edge-to-edge, dentro do
        // espaçador de 8px — a Highlight arredonda o topo e não tem divisor.
        private var topDivider: some View {
            Rectangle()
                .fill(Color(Ocean.color.colorInterfaceLightDown))
                .frame(height: 1)
        }

        private var contentView: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                if parameters.showSkeleton {
                    getSkeletonView(skeletonLines: parameters.skeletonLines)
                } else {
                    if !parameters.sectionTitle.isEmpty {
                        Typography.heading5 { label in
                            label.parameters.text = parameters.sectionTitle
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                        }
                    }

                    VStack(spacing: parameters.interlineSpacing) {
                        ForEach(parameters.items.indices, id: \.self) { index in
                            if parameters.showBottomDivider
                                && index == parameters.items.count - 1
                                && parameters.items.count > 1 {
                                Rectangle()
                                    .fill(Color(Ocean.color.colorInterfaceLightDown))
                                    .frame(height: 1)
                                    .padding(.vertical, Ocean.size.spacingStackXxxs)
                            }

                            getItemView(item: parameters.items[index])
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

        @ViewBuilder
        private func getItemView(item: TransactionFooterParameters.ItemModel) -> some View {
            VStack(alignment: .leading, spacing: 0) {
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
                }

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
