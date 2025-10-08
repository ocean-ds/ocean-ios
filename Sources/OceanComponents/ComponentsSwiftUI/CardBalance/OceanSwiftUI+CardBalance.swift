// OceanSwiftUI+CardBalance.swift
import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public final class CardBalanceParameters: ObservableObject {
        @Published public var context: Context
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
            context: Context = .distributor,
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
            self.context = context
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

        public enum Context {
            case retailer
            case distributor
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
                VStack(alignment: .leading, spacing: 0) {
                    OceanSwiftUI.Typography.caption { view in
                        view.parameters.text = parameters.header.title
                    }

                    OceanSwiftUI.Typography.heading4 { view in
                        view.parameters.text = parameters.header.value.toCurrency() ?? ""
                    }
                }

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
                    HStack {
                        OceanSwiftUI.Typography.caption { view in
                            view.parameters.text = item.label
                        }

                        Spacer()

                        OceanSwiftUI.Typography.heading5 { view in
                            view.parameters.text = item.value.toCurrency() ?? ""
                        }
                    }
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
            Group {
                switch parameters.context {
                case .distributor:
                    HStack(spacing: Ocean.size.spacingStackXs) {
                        DescValueView(description: parameters.footer.title ?? "",
                                      value: parameters.footer.value,
                                      showValue: parameters.header.showValue)

                        Spacer()

                        if let cta = parameters.footer.ctaTitle {
                            OceanSwiftUI.Button.secondarySM { b in
                                b.parameters.text = cta
                                b.parameters.onTouch = { parameters.onCTATap?() }
                            }
                            .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                case .retailer:
                    HStack(spacing: Ocean.size.spacingStackXs) {
                        OceanSwiftUI.Typography.caption { view in
                            view.parameters.text = parameters.footer.title ?? ""
                        }

                        Spacer()

                        if let cta = parameters.footer.ctaTitle {
                            OceanSwiftUI.Button.secondarySM { b in
                                b.parameters.text = cta
                                b.parameters.onTouch = { parameters.onCTATap?() }
                            }
                            .fixedSize()
                        }
                    }
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
            let acquirers = parameters.header.acquirers
            let limit = 3
            let count = min(acquirers.count, limit)
            return HStack(spacing: -Ocean.size.spacingStackXxs) {
                ForEach(0..<count, id: \.self) { i in
                    ZStack {
                        Circle().fill(Color.white)
                            .frame(width: Ocean.size.spacingStackMd,
                                   height: Ocean.size.spacingStackMd)

                        if let icon = "acquirer\(acquirers[i])".toOceanIcon() {
                            Image(uiImage: icon).resizable()
                                .scaledToFit()
                                .frame(width: Ocean.size.spacingStackMd,
                                       height: Ocean.size.spacingStackMd)
                        } else {
                            OceanSwiftUI.Typography.eyebrow {view in
                               view.parameters.text = String(acquirers[i].prefix(1)).uppercased()
                               view.parameters.textColor = Ocean.color.colorBrandPrimaryDown
                            }
                        }
                    }
                }
                if acquirers.count > limit {
                    OceanSwiftUI.Badge { b in
                        b.parameters.count = acquirers.count - limit
                        b.parameters.status = .primaryInverted
                        b.parameters.size = .small
                        b.parameters.style = .count
                        b.parameters.valuePrefix = "+"
                    }
                }
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

        // MARK: Methods private

        private struct DescValueView: View {
            let description: String
            let value: Double?
            let showValue: Bool

            var body: some View {
                VStack(alignment: .leading, spacing: 0) {
                    OceanSwiftUI.Typography.caption { view in
                        view.parameters.text = description
                    }
                    OceanSwiftUI.Typography.heading4 { view in
                        view.parameters.text = (showValue ? (value?.toCurrency() ?? "") : "R$ ••••")
                    }
                }
            }
        }
    }
}
