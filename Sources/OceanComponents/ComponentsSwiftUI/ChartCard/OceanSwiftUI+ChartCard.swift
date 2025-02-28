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
        @Published public var buttonTitle: String
        @Published public var buttonIsLoading: Bool
        @Published public var showSkeleton: Bool

        public var buttonAction: (() -> Void)?

        public init(title: String = "",
                    subtitle: String = "",
                    valueCenterDonut: String = "",
                    labelCenterDonut: String = "",
                    items: [ChartCardItemParameters] = [],
                    showLegend: Bool = true,
                    buttonTitle: String = "",
                    buttonIsLoading: Bool = false,
                    showSkeleton: Bool = false,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs),
                    buttonAction: (() -> Void)? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.valueCenterDonut = valueCenterDonut
            self.labelCenterDonut = labelCenterDonut
            self.items = items
            self.showLegend = showLegend
            self.buttonTitle = buttonTitle
            self.buttonIsLoading = buttonIsLoading
            self.showSkeleton = showSkeleton
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

        @ViewBuilder
        private var headerView: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                if !parameters.title.isEmpty {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = parameters.title
                        label.parameters.showSkeleton = parameters.showSkeleton
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

        @ViewBuilder
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
                view.parameters.text = parameters.buttonTitle
                view.parameters.onTouch = parameters.buttonAction ?? {}
                view.parameters.isLoading = parameters.buttonIsLoading
            }
        }

        @ViewBuilder
        private var legendSkeletonView: some View {
            VStack(spacing: Ocean.size.spacingStackXxs) {
                ForEach(0..<3, id: \.self) { index in
                    Skeleton()

                    if index < parameters.items.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }

        @ViewBuilder
        private var donutSkeletonView: some View {
            Circle()
                .frame(width: 300, height: 300)
                .oceanSkeleton(isActive: true)
                .overlay(
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                )
        }

        @ViewBuilder
        private var skeletonView: some View {
            VStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
                donutSkeletonView

                legendSkeletonView
            }
            .padding(.vertical, Ocean.size.spacingStackXs)
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
            if parameters.showSkeleton {
                skeletonView
            } else {
                VStack(spacing: 0) {
                    headerView

                    ChartCardUIViewRepresentable(items: parameters.items,
                                                 valueCenterDonut: parameters.valueCenterDonut,
                                                 labelCenterDonut: parameters.labelCenterDonut)
                    .frame(height: 300)
                    .allowsHitTesting(false)

                    if parameters.showLegend {
                        legendView
                    }

                    if !parameters.buttonTitle.isEmpty, !parameters.showSkeleton {
                        Divider()
                            .padding(.top, Ocean.size.spacingStackSm)

                        ctaView
                    }
                }
            }
        }
    }
}
