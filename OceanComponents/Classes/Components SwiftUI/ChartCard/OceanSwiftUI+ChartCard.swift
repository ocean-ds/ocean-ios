//
//  OceanSwiftUI+ChartCard.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 04/02/25.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public class ChartCardParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var valueCenterDonut: String
        @Published public var labelCenterDonut: String
        @Published public var items: [ChartCardItemParameters]
        @Published public var showLegend: Bool
        @Published public var bottomTitle: String
        @Published public var buttonIsLoading: Bool
        @Published public var showSkeleton: Bool
        public var onSelect: ((ChartCardItemParameters?) -> Void)?
        public var buttonAction: (() -> Void)?

        public init(title: String = "",
                    subtitle: String = "",
                    valueCenterDonut: String = "",
                    labelCenterDonut: String = "",
                    items: [ChartCardItemParameters] = [],
                    showLegend: Bool = true,
                    bottomTitle: String = "",
                    buttonIsLoading: Bool = false,
                    showSkeleton: Bool = false,
                    onSelect: ((ChartCardItemParameters?) -> Void)? = nil,
                    buttonAction: (() -> Void)? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.valueCenterDonut = valueCenterDonut
            self.labelCenterDonut = labelCenterDonut
            self.items = items
            self.showLegend = showLegend
            self.bottomTitle = bottomTitle
            self.buttonIsLoading = buttonIsLoading
            self.showSkeleton = showSkeleton
            self.onSelect = onSelect
            self.buttonAction = buttonAction
        }
    }

    public struct ChartCard: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ChartCard) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ChartCardParameters

        // MARK: Properties private

        private var headerView: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                if !parameters.title.isEmpty {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = parameters.title
                    }
                }

                if !parameters.subtitle.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = parameters.subtitle
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Ocean.size.spacingStackSm)
            .padding(.top, Ocean.size.spacingStackSm)
        }

        // MARK: Constructors

        public init(parameters: ChartCardParameters = ChartCardParameters()) {
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

                ChartCardView(items: parameters.items,
                              valueCenterDonut: parameters.valueCenterDonut,
                              labelCenterDonut: parameters.labelCenterDonut,
                              onSelect: parameters.onSelect)
                .frame(height: 300)
                .allowsHitTesting(false)

                if parameters.showLegend {
                    legendView
                }

                if !parameters.bottomTitle.isEmpty {
                    ctaView
                }
            }
//            .background(Color(Ocean.color.colorInterfaceLightPure))
//            .clipShape(RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd))
//            .overlay(
//                RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
//                    .stroke(Color(Ocean.color.colorInterfaceLightDown), lineWidth: 1)
//            )
        }

        private var legendView: some View {
            VStack(spacing: Ocean.size.spacingStackXxs) {
                ForEach(0..<parameters.items.count, id: \.self) { index in
                        ChartCardItem(parameters: parameters.items[index])

                        if index < parameters.items.count - 1 {
                            Divider()
                        }

                }
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }

        @ViewBuilder
        private var ctaView: some View {
            CardCTA { view in
                view.parameters.text = parameters.bottomTitle
                view.parameters.onTouch = parameters.buttonAction ?? {}
                view.parameters.isLoading = parameters.buttonIsLoading
            }
        }

    }
}
