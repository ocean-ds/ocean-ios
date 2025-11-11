//  OceanSwiftUI+Balance.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 08/10/25.

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public final class CardBalanceParameters: ObservableObject {
        @Published public var header: Header
        @Published public var balanceRows: [BalanceRow]
        @Published public var promotionalAnticipation: PromotionalAnticipation
        @Published public var footer: Footer
        @Published public var state: CardBalanceState
        @Published public var showValue: Bool
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets

        public var onToggle: (() -> Void)?
        public var onFooterTap: (() -> Void)?

        public init(
            header: Header = .init(),
            balanceRows: [BalanceRow] = [],
            promotionalAnticipation: PromotionalAnticipation = PromotionalAnticipation(),
            footer: Footer = Footer(),
            state: CardBalanceState = .collapsed,
            showValue: Bool = true,
            showSkeleton: Bool = false,
            padding: EdgeInsets = .all(Ocean.size.spacingStackXs),
            onToggle: (() -> Void)? = nil,
            onFooterTap: (() -> Void)? = nil
        ) {
            self.header = header
            self.balanceRows = balanceRows
            self.promotionalAnticipation = promotionalAnticipation
            self.footer = footer
            self.state = state
            self.showValue = showValue
            self.showSkeleton = showSkeleton
            self.padding = padding
            self.onToggle = onToggle
            self.onFooterTap = onFooterTap
        }

        public func setCollapsed() { setState(.collapsed) }
        public func setExpanded() { setState(.expanded)  }
        public func toggle() { setState(state == .expanded ? .collapsed : .expanded) }

        public enum CardBalanceState: Equatable {
            case collapsed
            case expanded
        }

        public struct Header: Equatable {
            public let title: String
            public let value: Double
            public let acquirers: [String]

            public init(title: String = "",
                        value: Double = 0,
                        acquirers: [String] = []) {
                self.title = title
                self.value = value
                self.acquirers = acquirers
            }
        }

        public struct BalanceRow: Equatable {
            public let label: String
            public let value: Double

            public init(label: String, value: Double) {
                self.label = label
                self.value = value
            }
        }

        public struct PromotionalAnticipation {
            public let remainingTime: String?
            public let description: String?
            public let ctaTitle: String?
            public let backgroundColor: UIColor
            public var onCTATap: (() -> Void)?

            public init(remainingTime: String? = nil,
                        description: String? = nil,
                        ctaTitle: String? = nil,
                        backgroundColor: UIColor = Ocean.color.colorStatusWarningUp,
                        onCTATap: (() -> Void)? = nil
            ) {
                self.remainingTime = remainingTime
                self.description = description
                self.ctaTitle = ctaTitle
                self.backgroundColor = backgroundColor
                self.onCTATap = onCTATap
            }
        }

        public struct Footer {

            public let description: String?
            public let title: String?
            public let value: Double?
            public let ctaTitle: String?
            public var onCTATap: (() -> Void)?

            public init(description: String? = nil,
                        title: String? = nil,
                        value: Double? = nil,
                        ctaTitle: String? = nil,
                        onCTATap: (() -> Void)? = nil) {
                self.description = description
                self.title = title
                self.value = value
                self.ctaTitle = ctaTitle
                self.onCTATap = onCTATap
            }
        }

        private func setState(_ new: CardBalanceState, animated: Bool = true) {
            let apply = { self.state = new }
            animated ? withAnimation(.easeInOut(duration: 0.3), apply) : apply()
        }
    }

    public struct CardBalance: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardBalance) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardBalanceParameters

        // MARK: Private properties

        private var headerView: some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {

                getBalanceView(label: parameters.header.title,
                               balance: parameters.header.value,
                               isVerticalBalance: true)

                Spacer()

                acquirersView

                chevronView
            }
            .padding(.vertical, Ocean.size.spacingStackXxsExtra)
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .contentShape(Rectangle())
            .onTapGesture {
                parameters.toggle()
                parameters.onToggle?()
            }
            .zIndex(1)
        }

        private var bodyItems: some View {
            VStack(spacing: 0) {
                ForEach(parameters.balanceRows.indices, id: \.self) { i in
                    let item = parameters.balanceRows[i]
                    getBalanceView(label: item.label,
                                   balance: item.value,
                                   isVerticalBalance: false)
                    .padding(.vertical, Ocean.size.spacingStackXxsExtra)
                    .padding(.horizontal, Ocean.size.spacingStackXs)

                    if i != parameters.balanceRows.indices.last {
                        OceanSwiftUI.Divider()
                    }
                }
            }
            .clipped()
            .transition(.opacity)
            .zIndex(0)
        }

        @ViewBuilder
        private var promotionalOfferView: some View {
            if parameters.promotionalAnticipation.remainingTime != nil ||
                parameters.promotionalAnticipation.description != nil ||
                parameters.promotionalAnticipation.ctaTitle != nil {

                VStack(alignment: .leading, spacing: 0) {
                    if let remainingTime = parameters.promotionalAnticipation.remainingTime {
                        OceanSwiftUI.Typography.description { view in
                            view.parameters.text = remainingTime
                            view.parameters.textColor = Ocean.color.colorStatusWarningDeep
                            view.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                        }
                        .padding(.top, Ocean.size.spacingStackXs)
                        .padding(.bottom, Ocean.size.spacingStackXxxs)
                    }
                    
                    if let description = parameters.promotionalAnticipation.description {
                        OceanSwiftUI.Typography.description { view in
                            view.parameters.text = description
                            view.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                            view.parameters.lineLimit = 3
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxsExtra)
                    }

                    if let ctaTitle = parameters.promotionalAnticipation.ctaTitle {
                        OceanSwiftUI.Link { view in
                            view.parameters.text = ctaTitle
                            view.parameters.style = .primary
                            view.parameters.type = .chevron
                            view.parameters.onTouch = { parameters.promotionalAnticipation.onCTATap?() }
                        }
                        .padding(.bottom, Ocean.size.spacingStackXs)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Ocean.size.spacingStackXs)
                .background(Color(parameters.promotionalAnticipation.backgroundColor))
                .transition(.opacity)
            }
        }

        @ViewBuilder
        private var footerView: some View {
            HStack(spacing: Ocean.size.spacingStackXs) {
                if let value = parameters.footer.value {
                    getBalanceView(label: parameters.footer.title,
                                   balance: parameters.footer.value,
                                   isVerticalBalance: true)

                } else {
                    OceanSwiftUI.Typography.caption { view in
                        view.parameters.text = parameters.footer.description ?? ""
                    }
                }

                Spacer()

                if let cta = parameters.footer.ctaTitle {
                    OceanSwiftUI.Button.secondarySM { view in
                        view.parameters.text = cta
                        view.parameters.onTouch = { parameters.footer.onCTATap?() }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
            .padding(.vertical, Ocean.size.spacingStackXxsExtra)
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }

        private var chevronView: some View {
            Image(uiImage: Ocean.icon.chevronRightSolid)
                .resizable()
                .renderingMode(.template)
                .frame(width: Ocean.size.spacingStackXs, height: Ocean.size.spacingStackXs)
                .foregroundColor(Color(Ocean.color.colorBrandPrimaryPure))
                .rotationEffect(.degrees(90))
                .rotationEffect(.degrees(parameters.state == .expanded ? -180 : 0))
                .animation(.easeInOut, value: parameters.state)
        }

        private var acquirersView: some View {
            OceanSwiftUI.Brands { view in
                view.parameters.acquirers = parameters.header.acquirers
                view.parameters.limit = 3
                view.parameters.hasBorder = true
                view.parameters.borderColor = Ocean.color.colorInterfaceLightPure
                view.parameters.itemSize = Ocean.size.spacingStackMd
                view.parameters.overlapSpacing = Ocean.size.spacingStackXxs
            }
        }

        // MARK: Constructors

        public init(parameters: CardBalanceParameters = CardBalanceParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: 0) {
                headerView

                if parameters.state == .expanded {
                    bodyItems

                    promotionalOfferView
                }

                OceanSwiftUI.Divider()

                footerView
            }
            .oceanSkeleton(isActive: parameters.showSkeleton, shape: .rectangle)
            .border(cornerRadius: Ocean.size.borderRadiusSm,
                    width: !parameters.showSkeleton ? 1 : 0,
                    color: Ocean.color.colorInterfaceLightDown)
            .padding(parameters.padding)
            .clipped()
        }

        private func getBalanceView(label: String?,
                                    balance: Double?,
                                    isVerticalBalance: Bool) -> some View {
            VStack(alignment: .leading, spacing: 0) {
                if isVerticalBalance {
                    VStack(alignment: .leading, spacing: 0) {
                        OceanSwiftUI.Typography.caption { view in
                            view.parameters.text = label ?? ""
                        }
                        OceanSwiftUI.Typography.heading4 { view in
                            view.parameters.text = maskedCurrency(balance)
                        }
                        .animation(.easeInOut(duration: 0.2), value: parameters.showValue)

                    }
                } else {
                    HStack {
                        OceanSwiftUI.Typography.caption { view in
                            view.parameters.text = label ?? ""
                        }
                        Spacer()
                        OceanSwiftUI.Typography.heading5 { view in
                            view.parameters.text = maskedCurrency(balance)
                        }
                        .animation(.easeInOut(duration: 0.2), value: parameters.showValue)
                    }
                }
            }
        }

        private func maskedCurrency(_ value: Double?) -> String {
            let hasSymbolSpace = (value ?? 0) < 0
            return parameters.showValue ? (value?.toCurrency(symbolSpace: hasSymbolSpace) ?? "") : "R$ ••••••"
        }
    }
}
