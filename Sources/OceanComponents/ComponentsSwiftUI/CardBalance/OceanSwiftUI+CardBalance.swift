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
        @Published public var footer: Footer
        @Published public var state: CardBalanceState
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets

        public var onToggle: (() -> Void)?
        public var onCTATap: (() -> Void)?
        public var onFooterTap: (() -> Void)?

        public init(
            header: Header = .init(),
            balanceRows: [BalanceRow] = [],
            footer: Footer = Footer(),
            state: CardBalanceState = .collapsed,
            showSkeleton: Bool = false,
            padding: EdgeInsets = .all(Ocean.size.spacingStackXs),
            onToggle: (() -> Void)? = nil,
            onCTATap: (() -> Void)? = nil,
            onFooterTap: (() -> Void)? = nil,
        ) {
            self.header = header
            self.balanceRows = balanceRows
            self.footer = footer
            self.state = state
            self.showSkeleton = showSkeleton
            self.padding = padding
            self.onToggle = onToggle
            self.onCTATap = onCTATap
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
            public let showValue: Bool
            public let acquirers: [String]

            public init(title: String = "",
                        value: Double = 0,
                        showValue: Bool = true,
                        acquirers: [String] = []) {
                self.title = title
                self.value = value
                self.showValue = showValue
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

        public struct Footer: Equatable {

            public let description: String?
            public let title: String?
            public let value: Double?
            public let ctaTitle: String?

            public init(description: String? = nil,
                        title: String? = nil,
                        value: Double? = nil,
                        ctaTitle: String? = nil) {
                self.description = description
                self.title = title
                self.value = value
                self.ctaTitle = ctaTitle
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
                        view.parameters.onTouch = { parameters.onCTATap?() }
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

                if parameters.state == .expanded { bodyItems }

                OceanSwiftUI.Divider()

                footerView
            }
            .border(cornerRadius: Ocean.size.borderRadiusSm,
                    width: 1,
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
                        .animation(.easeInOut(duration: 0.2), value: parameters.header.showValue)

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
                        .animation(.easeInOut(duration: 0.2), value: parameters.header.showValue)
                    }
                }
            }
        }

        private func maskedCurrency(_ value: Double?) -> String {
            return parameters.header.showValue ? (value?.toCurrency() ?? "") : "R$ ••••••"
        }
    }
}
