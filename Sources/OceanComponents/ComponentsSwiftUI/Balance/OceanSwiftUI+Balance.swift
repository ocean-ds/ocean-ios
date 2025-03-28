import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class BalanceParameters: ObservableObject {
        @Published public var model: BalanceModel
        @Published public var isVisibleBalance: Bool
        @Published public var state: BalanceState
        @Published public var showSkeleton: Bool

        public enum BalanceState {
            case expanded, collapsed, scroll
        }

        public init(model: BalanceModel = .init(),
                    isVisibleBalance: Bool = true,
                    state: BalanceState = .collapsed,
                    showSkeleton: Bool = false) {
            self.model = model
            self.isVisibleBalance = isVisibleBalance
            self.state = state
            self.showSkeleton = showSkeleton
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
        @Published public var actionCTA2: String
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
                    actionCTA2: String = "",
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
            self.actionCTA2 = actionCTA2
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

        @State private var shouldAnimate: Bool = false

        // MARK: Constructors

        public init(parameters: BalanceParameters = BalanceParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        private var scrollStateView: some View {
            VStack {
                getBalanceHeaderView(parameters.model, fontLarge: false)
                    .padding(.vertical, Ocean.size.spacingStackXxs)
                    .padding(.horizontal, Ocean.size.spacingStackXs)
            }
            .background(Color(Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)))
        }

        private var balanceView: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                getBalanceHeaderView(parameters.model, fontLarge: true)

                if self.parameters.state == .expanded {
                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                        HStack(spacing: Ocean.size.spacingStackXs) {
                            Typography { label in
                                label.parameters.text = parameters.model.item1Title
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = parameters.isVisibleBalance ? parameters.model.item1Value.toCurrency() ?? "" : "R$ ••••••"
                                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }
                        }

                        Divider { divider in
                            divider.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)
                        }

                        HStack(spacing: Ocean.size.spacingStackXs) {
                            Typography { label in
                                label.parameters.text = parameters.model.item2Title
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = parameters.isVisibleBalance ? parameters.model.item2Value.toCurrency() ?? "" : "R$ ••••••"
                                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }
                        }
                    }
                    .padding(.top, Ocean.size.spacingStackXs)
                }

                Divider { divider in
                    divider.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)
                }

                balanceFooterView()
            }
        }

        private var balanceCardView: some View {
            VStack {
                balanceView
                    .padding(.vertical, 12)
                    .padding(.horizontal, Ocean.size.spacingStackXs)
            }
            .background(Color(Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)))
            .cornerRadius(Ocean.size.borderRadiusMd)
        }

        @ViewBuilder
        private func balanceFooterView() -> some View {
            switch parameters.model.displayMode {
            case .amountMachines:
                HStack(spacing: Ocean.size.spacingStackXs) {
                    VStack(alignment: .leading, spacing: 0) {
                        Typography { label in
                            label.parameters.text = parameters.model.description
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                            label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                        }

                        Typography { label in
                            label.parameters.text = parameters.isVisibleBalance ? parameters.model.item3Value.toCurrency() ?? "" : "R$ ••••••"
                            label.parameters.font =  .baseBold(size: Ocean.font.fontSizeSm)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }
                    }

                    Spacer()

                    HStack(spacing: -Ocean.size.spacingStackXxs) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 24, height: 24)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 24, height: 24)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 24, height: 24)
                    }

                    Image(uiImage: Ocean.icon.chevronRightSolid?.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                }

            case .awaitPayment:
                balanceActionRow(showValue: true)

            case .knowMore, .addBalance:
                balanceActionRow(showValue: false)

            case .none:
                EmptyView()
            }
        }

        @ViewBuilder
        private func balanceActionRow(showValue: Bool) -> some View {
            HStack(spacing: Ocean.size.spacingStackXs) {
                VStack(alignment: .leading, spacing: 0) {
                    Typography { label in
                        label.parameters.text = parameters.model.pendingTitle
                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                    }

                    if showValue {
                        Typography { label in
                            label.parameters.text = parameters.isVisibleBalance ? parameters.model.pendingValue.toCurrency() ?? "" : "R$ ••••••"
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeSm)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }
                    }
                }

                Spacer()

                Button.secondarySM { button in
                    button.parameters.text = parameters.model.actionCTA2
                    button.parameters.onTouch = {
                        parameters.model.action?()
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
            }
        }

        public var body: some View {
            VStack(spacing: 0) {
                if parameters.state == .scroll {
                    scrollStateView
                } else {
                    balanceCardView
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.033) {
                                self.shouldAnimate = true
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .transform(condition: shouldAnimate) { $0.animation(.default) }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXs)
                }
            }
            .clipped()
        }

        // MARK: Methods private

        @ViewBuilder
        private func getBalanceHeaderView(_ item: BalanceModel, fontLarge: Bool) -> some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                VStack(alignment: .leading, spacing: 0) {
                    Typography { label in
                        label.parameters.text = item.title
                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                    }

                    Typography { label in
                        label.parameters.text = parameters.isVisibleBalance ? item.value?.toCurrency() ?? "" : "R$ ••••••"
                        label.parameters.font = fontLarge ? .baseBold(size: Ocean.font.fontSizeSm) : .baseBold(size: Ocean.font.fontSizeXs)
                        label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        label.parameters.showSkeleton = parameters.showSkeleton
                    }
                }

                Spacer()

                Image(uiImage: Ocean.icon.chevronUpSolid?.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16, alignment: .center)
                    .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                    .rotationEffect(Angle(degrees: self.parameters.state == .expanded ? 180.0 : 0.0))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if self.parameters.state == .collapsed {
                    self.parameters.state = .expanded
                } else {
                    self.parameters.state = .collapsed
                }
            }
        }
    }
}
