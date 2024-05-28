//
//  OceanSwiftUI+SimpleBalance.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 24/05/24.
//

import Foundation
import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class SimpleBalanceParameters: ObservableObject {
        @Published public var isExpanded: Bool
        @Published public var isVisible: Bool
        @Published public var balanceAvailable: Double
        @Published public var currentBalance: Double
        @Published public var scheduleBlu: Double
        @Published public var showSkeleton: Bool
        public var onStateChanged: ((Bool) -> Void)?

        public init(isExpanded: Bool = false,
                    isVisible: Bool = true,
                    balanceAvailable: Double = 0.0,
                    currentBalance: Double = 0.0,
                    scheduleBlu: Double = 0.0,
                    showSkeleton: Bool = false,
                    onStateChanged: ((Bool) -> Void)? = nil) {
            self.isExpanded = isExpanded
            self.isVisible = isVisible
            self.balanceAvailable = balanceAvailable
            self.currentBalance = currentBalance
            self.scheduleBlu = scheduleBlu
            self.showSkeleton = showSkeleton
            self.onStateChanged = onStateChanged
        }
    }

    public struct SimpleBalance: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (SimpleBalance) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SimpleBalanceParameters

        // MARK: Properties private

        @State private var isVisible: Bool = true

        private var eyesIconView: some View {
            Image(uiImage: isVisible
                  ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                  : Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate))
            .resizable()
            .renderingMode(.template)
            .frame(width: 24, height: 24)
            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
            .padding(.trailing, Ocean.size.spacingStackXs)
            .onTapGesture {
                isVisible.toggle()
                parameters.onStateChanged?(parameters.isExpanded)
            }
        }

        private var chevronIconView: some View {
            Image(uiImage: Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate))
                .resizable()
                .renderingMode(.template)
                .frame(width: 16, height: 16, alignment: .center)
                .foregroundColor(Color(parameters.isExpanded ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkUp))
                .rotationEffect(Angle(degrees: parameters.isExpanded ? 180.0 : 0.0))
        }

        @ViewBuilder
        private var headerView: some View {
                HStack(alignment: .center, spacing: 0) {
                    if !parameters.isExpanded {
                        eyesIconView
                        VStack(alignment: .leading, spacing: 0) {
                            Typography { label in
                                label.parameters.text = "Saldo na Blu"
                                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                                label.parameters.lineSpacing = Ocean.font.lineHeightComfy
                            }

                            Typography { label in
                                label.parameters.text = isVisible ? parameters.balanceAvailable.toCurrency() ?? "" : "R$ ••••••"
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = getValueColor(value: parameters.balanceAvailable)
                                label.parameters.showSkeleton = parameters.showSkeleton
                            }
                        }
                    } else {
                        Typography { label in
                            label.parameters.text = "Saldo na Blu"
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                            label.parameters.textColor = Ocean.color.colorBrandPrimaryPure
                        }
                    }

                    Spacer()

                    chevronIconView
                }
                .background(Color(Ocean.color.colorInterfaceLightPure))
                .frame(height: 56)
            }

        // MARK: Constructors

        public init(parameters: SimpleBalanceParameters = SimpleBalanceParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            ZStack(alignment: .top) {
                if parameters.isExpanded {
                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                        Spacer()
                            .frame(height: 56)

                        HStack {
                            Typography { label in
                                label.parameters.text = "Saldo total"
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = parameters.balanceAvailable.toCurrency() ?? "-"
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = getValueColor(value: parameters.balanceAvailable)
                            }
                        }

                        Divider()

                        HStack {
                            Typography { label in
                                label.parameters.text = "Saldo atual"
                                label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = parameters.currentBalance.toCurrency() ?? "-"
                                label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = getValueColor(value: parameters.currentBalance)
                            }
                        }

                        Divider()

                        HStack {
                            Typography { label in
                                label.parameters.text = "Agenda"
                                label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = parameters.scheduleBlu.toCurrency() ?? "-"
                                label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = getValueColor(value: parameters.scheduleBlu)
                            }
                        }
                    }
                    .transition(.move(edge: .top))
                    .animation(.easeInOut)
                }

                headerView
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    parameters.isExpanded = !parameters.isExpanded
                }
            }
        }

        private func getValueColor(value: Double) -> UIColor {
            return value < 0 ? Ocean.color.colorStatusNegativePure : Ocean.color.colorInterfaceDarkDeep
        }
    }
}
