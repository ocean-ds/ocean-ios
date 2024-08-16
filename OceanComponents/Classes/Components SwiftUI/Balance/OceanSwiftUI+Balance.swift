//
//  OceanSwiftUI+Balance.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 12/04/24.
//

import SwiftUI
import OceanTokens
import SkeletonUI

extension OceanSwiftUI {
    // MARK: Parameters

    public class BalanceParameters: ObservableObject {
        @Published public var model: BalanceModel
        @Published public var state: BalanceState
        @Published public var showSkeleton: Bool

        public enum BalanceState {
            case expanded, collapsed, scroll
        }

        public init(model: BalanceModel = .init(),
                    state: BalanceState = .collapsed,
                    showSkeleton: Bool = false) {
            self.model = model
            self.state = state
            self.showSkeleton = showSkeleton
        }
    }

    public class BalanceModel: ObservableObject, Identifiable {
        @Published public var title: String
        @Published public var value: Double?
        @Published public var item1Title: String
        @Published public var item1Value: Double
        @Published public var item2Title: String
        @Published public var item2Value: Double
        @Published public var description: String
        @Published public var actionCTA: String
        @Published public var actionCTACollapsed: String
        @Published public var action: (() -> Void)?

        public init(title: String = "",
                    value: Double? = nil,
                    item1Title: String = "",
                    item1Value: Double = 0.0,
                    item2Title: String = "",
                    item2Value: Double = 0.0,
                    description: String = "",
                    actionCTA: String = "",
                    actionCTACollapsed: String = "",
                    action: (() -> Void)? = nil) {
            self.title = title
            self.value = value
            self.item1Title = item1Title
            self.item1Value = item1Value
            self.item2Title = item2Title
            self.item2Value = item2Value
            self.description = description
            self.actionCTA = actionCTA
            self.actionCTACollapsed = actionCTACollapsed
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

        @State private var isValueVisible: Bool = true
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

        private var eyesIconView: some View {
            Image(uiImage: isValueVisible
                  ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                  : Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate))
            .resizable()
            .renderingMode(.template)
            .frame(width: 24, height: 24)
            .foregroundColor(Color(Ocean.color.colorBrandPrimaryUp))
            .padding(.trailing, 16)
            .onTapGesture {
                isValueVisible.toggle()
            }
        }

        private var balanceView: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
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
                                label.parameters.text = isValueVisible ? parameters.model.item1Value.toCurrency() ?? "" : "R$ ••••••"
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
                                label.parameters.text = isValueVisible ? parameters.model.item2Value.toCurrency() ?? "" : "R$ ••••••"
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

                HStack(spacing: Ocean.size.spacingStackXxs) {
                    Typography.description { label in
                        label.parameters.text = parameters.model.description
                        label.parameters.textColor = Ocean.color.colorInterfaceLightDown
                    }
                    .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    Button.secondarySM { button in
                        button.parameters.text = parameters.model.actionCTA
                        button.parameters.onTouch = {
                            parameters.model.action?()
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                }
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
                eyesIconView

                VStack(alignment: .leading, spacing: 0) {
                    Typography { label in
                        label.parameters.text = item.title
                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                    }

                    Typography { label in
                        label.parameters.text = isValueVisible ? item.value?.toCurrency() ?? "" : "R$ ••••••"
                        label.parameters.font = fontLarge ? .baseBold(size: Ocean.font.fontSizeSm) : .baseBold(size: Ocean.font.fontSizeXs)
                        label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        label.parameters.showSkeleton = parameters.showSkeleton
                    }
                }

                Spacer()

                Image(uiImage: Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate))
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
