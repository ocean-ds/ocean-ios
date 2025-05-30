//  OceanSwiftUI+Balance.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 12/04/24.

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class BalanceParameters: ObservableObject {

        @Published public var model: BalanceModel
        @Published public var isVisibleBalance: Bool
        @Published public var showSkeleton: Bool
        @Published public var state: BalanceState

        public enum BalanceState {
            case expanded, collapsed, scroll
        }

        public init(model: BalanceModel = .init(),
                    isVisibleBalance: Bool = true,
                    showSkeleton: Bool = false,
                    state: BalanceState = .collapsed) {
            self.model = model
            self.isVisibleBalance = isVisibleBalance
            self.showSkeleton = showSkeleton
            self.state = state
        }

        public func setStateWithAnimation(state: BalanceState) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.state = state
            }
        }
    }

    public enum BalanceDisplayMode {
        case amountMachines
        case awaitPayment
        case knowMore
        case addBalance
        case none
    }

    public class BalanceModel: ObservableObject, Identifiable {
        @Published public var title: String
        @Published public var value: Double?
        @Published public var item1Title: String
        @Published public var item1Value: Double
        @Published public var item2Title: String
        @Published public var item2Value: Double
        @Published public var item3Value: Double
        @Published public var description: String
        @Published public var pendingTitle: String
        @Published public var pendingValue: Double
        @Published public var actionCTA: String
        @Published public var acquirers: [String]
        @Published public var displayMode: BalanceDisplayMode
        @Published public var action: (() -> Void)?

        public init(title: String = "",
                    value: Double? = nil,
                    item1Title: String = "",
                    item1Value: Double = 0.0,
                    item2Title: String = "",
                    item2Value: Double = 0.0,
                    item3Value: Double = 0.0,
                    description: String = "",
                    pendingTitle: String = "",
                    pendingValue: Double = 0.0,
                    actionCTA: String = "",
                    acquirers: [String] = [],
                    displayMode: BalanceDisplayMode = .none,
                    action: (() -> Void)? = nil) {
            self.title = title
            self.value = value
            self.item1Title = item1Title
            self.item1Value = item1Value
            self.item2Title = item2Title
            self.item2Value = item2Value
            self.item3Value = item3Value
            self.description = description
            self.pendingTitle = pendingTitle
            self.pendingValue = pendingValue
            self.actionCTA = actionCTA
            self.acquirers = acquirers
            self.displayMode = displayMode
            self.action = action
        }
    }

    public struct Balance: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Balance) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: BalanceParameters

        // MARK: Private properties

        @ViewBuilder
        private var chevronIconView: some View {
            Image(uiImage: Ocean.icon.chevronRightSolid)
                .resizable()
                .renderingMode(.template)
                .frame(width: 16, height: 16, alignment: .center)
                .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
        }

        private var backgroundViewCornerRadius: CGFloat {
            parameters.state == .scroll ? 0 : Ocean.size.borderRadiusMd
        }

        private var backgroundViewPadding: EdgeInsets {
            parameters.state == .scroll
            ? .all(0)
            : .init(top: 0, leading: Ocean.size.spacingStackXs, bottom: Ocean.size.spacingStackXs, trailing: Ocean.size.spacingStackXs)
        }

        @ViewBuilder
        private var balanceFooterView: some View {
            VStack(alignment: .leading, spacing: 0) {
                Divider { $0.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4) }
                getBalanceFooterView()
            }
            .transition(.opacity.combined(with: .move(edge: .top)))
            .opacity(parameters.state == .scroll ? 0 : 1)
            .frame(height: parameters.state == .scroll ? 0 : nil)
            .clipped()
        }

        // MARK: Constructors

        public init(parameters: BalanceParameters = BalanceParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        @ViewBuilder
        private var balanceView: some View {
            VStack(alignment: .leading, spacing: 0) {
                getBalanceHeaderView(parameters.model, fontLarge: parameters.state != .scroll)

                VStack(alignment: .leading, spacing: 0) {
                    if self.parameters.state == .expanded {
                        VStack(alignment: .leading, spacing: 0) {
                            getBalanceWithDescriptionHStackView(
                                description: parameters.model.item1Title,
                                balance: parameters.model.item1Value,
                                isVisibleBalance: parameters.isVisibleBalance
                            )

                            Divider { $0.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4) }

                            getBalanceWithDescriptionHStackView(
                                description: parameters.model.item2Title,
                                balance: parameters.model.item2Value,
                                isVisibleBalance: parameters.isVisibleBalance
                            )
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: parameters.state)

                balanceFooterView
            }
        }

        public var body: some View {
            VStack(spacing: 0) {
                balanceView
                    .background(Color(Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)))
                    .cornerRadius(backgroundViewCornerRadius)
                    .padding(backgroundViewPadding)
                    .animation(.easeInOut, value: parameters.state)
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getBalanceWithDescriptionVStackView(
            description: String,
            balance: Double?,
            isVisibleBalance: Bool,
            showSkeleton: Bool,
            fontLarge: Bool = true,
            isShowValue: Bool = true,
            padding: EdgeInsets = .all(0)
        ) -> some View {

            VStack(alignment: .leading, spacing: 0) {
                Typography { label in
                    label.parameters.text = description
                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                    label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                }

                if isShowValue {
                    Typography { label in
                        label.parameters.text = isVisibleBalance ? balance?.toCurrency() ?? "" : "R$ ••••••"
                        label.parameters.font = .baseBold(size: fontLarge ? Ocean.font.fontSizeSm : Ocean.font.fontSizeXs)
                        label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        label.parameters.showSkeleton = showSkeleton
                    }
                    .animation(.easeInOut, value: fontLarge)
                }
            }
            .padding(padding)
        }

        @ViewBuilder
        private func getBalanceWithDescriptionHStackView(description: String, balance: Double?, isVisibleBalance: Bool) -> some View {
            HStack(alignment: .center, spacing: 0) {
                Typography { label in
                    label.parameters.text = description
                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                    label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                }

                Spacer()

                Typography { label in
                    label.parameters.text = isVisibleBalance ? balance?.toCurrency() ?? "" : "R$ ••••••"
                    label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                    label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                }
            }
            .padding(.vertical, Ocean.size.spacingStackXxsExtra)
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }

        @ViewBuilder
        private func getAcquirersView(acquirers: [String], limitShowAcquirers: Int = 3) -> some View {
            let exceededLimit = acquirers.count > limitShowAcquirers
            let acquiresToShow = exceededLimit ? 3 : acquirers.count

            HStack(spacing: -Ocean.size.spacingStackXxs) {
                ForEach(0..<acquiresToShow) { index in
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 24, height: 24)

                        let acquirer = acquirers[index]
                        if let icon = "acquirer\(acquirer)".toOceanIcon() {
                            Image(uiImage: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                        } else {
                            OceanSwiftUI.Typography.eyebrow { label in
                                label.parameters.text = acquirer.prefix(1).uppercased()
                                label.parameters.textColor = Ocean.color.colorBrandPrimaryDown
                            }
                        }
                    }
                }

                if exceededLimit {
                    Badge { badge in
                        badge.parameters.count = acquirers.count - limitShowAcquirers
                        badge.parameters.status = .primaryInverted
                        badge.parameters.size = .small
                        badge.parameters.style = .count
                        badge.parameters.valuePrefix = "+"
                    }
                }
            }
        }

        @ViewBuilder
        private func getBalanceHeaderView(_ item: BalanceModel, fontLarge: Bool) -> some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {

                getBalanceWithDescriptionVStackView(
                    description: item.title,
                    balance: item.value,
                    isVisibleBalance: parameters.isVisibleBalance,
                    showSkeleton: parameters.showSkeleton,
                    fontLarge: fontLarge
                )

                Spacer()

                chevronIconView
                    .rotationEffect(Angle(degrees: 90))
                    .rotationEffect(Angle(degrees: self.parameters.state == .expanded ? -180.0 : 0.0))
                    .animation(.easeInOut, value: parameters.state)
            }
            .padding(.vertical, Ocean.size.spacingStackXxsExtra)
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if parameters.state == .collapsed {
                        parameters.state = .expanded
                    } else {
                        parameters.state = .collapsed
                    }
                }
            }
        }

        @ViewBuilder
        private func getBalanceFooterView() -> some View {
            switch parameters.model.displayMode {
            case .amountMachines:
                balanceAcquirerRow()
            case .awaitPayment:
                balanceActionRow(showValue: true)
            case .knowMore, .addBalance:
                balanceActionRow(showValue: false)
            case .none:
                EmptyView()
            }
        }

        @ViewBuilder
        private func balanceAcquirerRow() -> some View {
            SwiftUI.Button {
                parameters.model.action?()
            } label: {
                HStack(spacing: Ocean.size.spacingStackXxs) {
                    getBalanceWithDescriptionVStackView(
                        description: parameters.model.description,
                        balance: parameters.model.item3Value,
                        isVisibleBalance: parameters.isVisibleBalance,
                        showSkeleton: parameters.showSkeleton
                    )

                    Spacer()

                    getAcquirersView(acquirers: parameters.model.acquirers)

                    chevronIconView
                }
            }
            .padding(.vertical, Ocean.size.spacingStackXxsExtra)
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }

        @ViewBuilder
        private func balanceActionRow(showValue: Bool) -> some View {
            HStack(spacing: Ocean.size.spacingStackXs) {
                getBalanceWithDescriptionVStackView(
                    description: parameters.model.pendingTitle,
                    balance: parameters.model.pendingValue,
                    isVisibleBalance: parameters.isVisibleBalance,
                    showSkeleton: parameters.showSkeleton,
                    isShowValue: showValue
                )

                Spacer()

                Button.secondarySM { button in
                    button.parameters.text = parameters.model.actionCTA
                    button.parameters.onTouch = {
                        parameters.model.action?()
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.vertical, Ocean.size.spacingStackXxsExtra)
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }
    }
}
