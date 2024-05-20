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
        @Published public var items: [BalanceModel]
        @Published public var state: BalanceState
        @Published public var showSkeleton: Bool

        public enum BalanceState {
            case expanded, collapsed, scroll
        }

        public init(items: [BalanceModel] = [],
                    state: BalanceState = .collapsed,
                    showSkeleton: Bool = false) {
            self.items = items
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
        @Published public var cellType: BalanceCellType

        public enum BalanceCellType {
            case withValue, withoutValue
        }

        public init(title: String = "",
                    value: Double? = nil,
                    item1Title: String = "",
                    item1Value: Double = 0.0,
                    item2Title: String = "",
                    item2Value: Double = 0.0,
                    description: String = "",
                    actionCTA: String = "",
                    actionCTACollapsed: String = "",
                    action: (() -> Void)? = nil,
                    cellType: BalanceCellType = .withValue) {
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
            self.cellType = cellType
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

        @State private var isVisibility: Bool = true
        @State private var currentPage = 0
        @State private var screenWidth: CGFloat = 0
        @State private var screenHeight: CGFloat = 0
        @State private var expandedHeight: CGFloat = 0
        @State private var shouldAnimate: Bool = false
        @GestureState private var dragOffset = CGSize.zero

        // MARK: Constructors

        public init(parameters: BalanceParameters = BalanceParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: 0) {
                if self.parameters.state == .scroll {
                    let index = self.currentPage
                    self.getItemScroll(self.parameters.items[index], index: index)
                } else {
                    GeometryReader { geometry in
                        HStack(alignment: .top, spacing: 0) {
                            Spacer()
                                .frame(width: Ocean.size.spacingStackXs)

                            ForEach(0..<self.parameters.items.count, id: \.self) { index in
                                self.getItem(self.parameters.items[index], index: index)
                                    .frame(width: screenWidth)
                                    .background(GeometryReader { geometry in
                                        Color.clear.onAppear {
                                            let height = geometry.size.height

                                            if height > screenHeight || index == parameters.items.count - 1 {
                                                screenHeight = height
                                            }
                                        }
                                    })

                                Spacer()
                                    .frame(width: Ocean.size.spacingStackXxs)
                            }

                            Spacer()
                                .frame(width: Ocean.size.spacingStackXxs)
                        }
                        .offset(x: -CGFloat(currentPage) * (screenWidth + Ocean.size.spacingStackXxs) + dragOffset.width)
                        .onAppear {
                            screenWidth = geometry.size.width - (Ocean.size.spacingStackXs * 2) - (Ocean.size.spacingStackXxs / 2)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.033) {
                                self.shouldAnimate = true
                            }
                        }
                        .transform(condition: shouldAnimate) { $0.animation(.default) }
                    }
                    .frame(maxWidth: .infinity)
                    .transform(condition: screenHeight != 0, transform: { view in
                        view.frame(height: parameters.state == .expanded ? screenHeight + expandedHeight : screenHeight)
                    })
                    .gesture(
                        DragGesture()
                            .updating(self.$dragOffset) { value, dragOffset, _ in
                                if !parameters.showSkeleton {
                                    dragOffset = value.translation
                                }
                            }
                            .onEnded { value in
                                let threshold = screenWidth * 0.2
                                if value.translation.width < -threshold && self.currentPage < parameters.items.count - 1 {
                                    self.currentPage += 1
                                } else if value.translation.width > threshold && self.currentPage > 0 {
                                    self.currentPage -= 1
                                }
                            })

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)

                    OceanSwiftUI.PageIndicator { pageIndicator in
                        pageIndicator.parameters.numberOfPages = self.parameters.items.count
                        pageIndicator.parameters.currentPage = self.currentPage
                        pageIndicator.parameters.pageIndicatorColor = Ocean.color.colorBrandPrimaryDown
                        pageIndicator.parameters.currentPageIndicatorColor = Ocean.color.colorInterfaceLightPure
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)
                }
            }
            .clipped()
        }

        // MARK: Methods private

        @ViewBuilder
        private func getItem(_ item: BalanceModel, index: Int) -> some View {
            HStack(alignment: .top, spacing: 0) {
                if item.cellType == .withValue {
                    getBalanceBluView(item)
                        .padding(.vertical, 12)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                } else {
                    getBalanceOthersAcquirersView(item)
                        .padding(.vertical, Ocean.size.spacingStackXs)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                }

                Spacer()
            }
            .background(Color(Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)))
            .cornerRadius(Ocean.size.borderRadiusMd)
        }

        @ViewBuilder
        private func getBalanceBluViewHeader(_ item: BalanceModel, fontLarge: Bool) -> some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                eyesIconView

                VStack(alignment: .leading, spacing: 0) {
                    Typography { label in
                        label.parameters.text = item.title
                        label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                    }

                    Typography { label in
                        label.parameters.text = isVisibility ? item.value?.toCurrency() ?? "" : "R$ ••••••"
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

        @ViewBuilder
        private func getBalanceBluView(_ item: BalanceModel) -> some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                self.getBalanceBluViewHeader(item, fontLarge: true)

                if self.parameters.state == .expanded {
                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                        HStack(spacing: Ocean.size.spacingStackXs) {
                            Typography { label in
                                label.parameters.text = item.item1Title
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = isVisibility ? item.item1Value.toCurrency() ?? "" : "R$ ••••••"
                                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }
                        }

                        Divider { divider in
                            divider.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)
                        }

                        HStack(spacing: Ocean.size.spacingStackXs) {
                            Typography { label in
                                label.parameters.text = item.item2Title
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }

                            Spacer()

                            Typography { label in
                                label.parameters.text = isVisibility ? item.item2Value.toCurrency() ?? "" : "R$ ••••••"
                                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                                label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                            }
                        }
                    }
                    .padding(.top, Ocean.size.spacingStackXs)
                    .overlay(GeometryReader { geometry in
                        Color.clear.onAppear {
                            expandedHeight = geometry.size.height + Ocean.size.spacingStackXs
                        }
                    })
                }

                Divider { divider in
                    divider.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)
                }

                HStack(spacing: Ocean.size.spacingStackXxs) {
                    Typography.description { label in
                        label.parameters.text = item.description
                        label.parameters.textColor = Ocean.color.colorInterfaceLightDown
                    }
                    .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    Button.secondarySM { button in
                        button.parameters.text = item.actionCTA
                        button.parameters.onTouch = {
                            item.action?()
                        }
                    }
                    .frame(width: 80)
                }
            }
        }

        @ViewBuilder
        private func getBalanceOthersAcquirersView(_ item: BalanceModel) -> some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                Typography { label in
                    label.parameters.text = item.title
                    label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                    label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                }

                Typography.description { label in
                    label.parameters.text = item.description
                    label.parameters.textColor = Ocean.color.colorInterfaceLightDown
                }
                .padding(.bottom, Ocean.size.spacingStackXxxs)

                Button.secondarySM { button in
                    button.parameters.text = item.actionCTA
                    button.parameters.onTouch = {
                        item.action?()
                    }
                }
                .frame(width: 185)
            }
        }

        @ViewBuilder
        private func getBalanceOthersAcquirersViewScroll(_ item: BalanceModel) -> some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                Typography.description { label in
                    label.parameters.text = item.description
                    label.parameters.textColor = Ocean.color.colorInterfaceLightDown
                }

                Spacer()

                Button.secondarySM { button in
                    button.parameters.text = item.actionCTACollapsed
                    button.parameters.onTouch = {
                        item.action?()
                    }
                }
                .frame(width: 120)
            }
        }

        @ViewBuilder
        private func getItemScroll(_ item: BalanceModel, index: Int) -> some View {
            HStack(alignment: .top, spacing: 0) {
                if item.cellType == .withValue {
                    getBalanceBluViewHeader(item, fontLarge: false)
                        .padding(.vertical, Ocean.size.spacingStackXxs)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                } else {
                    getBalanceOthersAcquirersViewScroll(item)
                        .padding(.vertical, Ocean.size.spacingStackXs)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                }

                Spacer()
            }
            .background(Color(Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)))
        }

        @ViewBuilder
        private var eyesIconView: some View {
            Image(uiImage: isVisibility
                  ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                  : Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate))
            .resizable()
            .renderingMode(.template)
            .frame(width: 24, height: 24)
            .foregroundColor(Color(Ocean.color.colorBrandPrimaryUp))
            .padding(.trailing, 16)
            .onTapGesture {
                isVisibility.toggle()
            }
        }

        private func getIdealHeight() -> CGFloat {
            if self.parameters.state == .expanded {
                return 220
            } else {
                return 150
            }
        }
    }
}
