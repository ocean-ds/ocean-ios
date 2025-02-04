//
//  ChartCardItemView.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 04/02/25.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public class ChartCardItemParameters: ObservableObject {
        @Published public var id = UUID()
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var value: Double
        @Published public var color: UIColor
        @Published public var valueRepresentationType: ValueRepresentationType
        @Published public var showSkeleton: Bool

        public init(title: String = "",
                    subtitle: String = "",
                    value: Double = 0,
                    color: UIColor = Ocean.color.colorBrandPrimaryPure,
                    valueRepresentationType: ValueRepresentationType = .percent,
                    showSkeleton: Bool = true) {
            self.title = title
            self.subtitle = subtitle
            self.value = value
            self.color = color
            self.valueRepresentationType = valueRepresentationType
            self.showSkeleton = showSkeleton
        }
    }

    public enum ValueRepresentationType {
        case percent
        case decimal
        case monetary
    }

    public struct ChartCardItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ChartCardItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ChartCardItemParameters
        @State private var isActive: Bool = true

        private var formattedValue: String {
            switch parameters.valueRepresentationType {
            case .decimal:
                return String(format: "%.2f", parameters.value)
            case .percent:
                return String(format: "%.1f%%", parameters.value)
            case .monetary:
                return String(format: "R$ %.2f", parameters.value)
            }
        }

        // MARK: Constructors

        public init(parameters: ChartCardItemParameters = ChartCardItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: - View
        
        public var body: some View {
            GeometryReader { geometry in
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {

                    VStack(alignment: .leading, spacing: Ocean.size.spacingInlineXxxs) {

                        HStack(alignment: .center, spacing: Ocean.size.spacingInlineXxs) {
                            indicatorView

                            titleRow
                        }

                        subtitleView
                            .padding(.leading, Ocean.size.spacingInlineXs)
                    }

                    Spacer()

                    valueView
                }
                .oceanSkeleton(isActive: parameters.showSkeleton,
                               size: .init(width: geometry.size.width, height: 30),
                               shape: .rounded(.radius(8, style: .continuous)),
                               lines: 2,
                               scales: [0: 0.7, 1: 1])
            }
        }

        // MARK: - Subviews

        @ViewBuilder
        private var indicatorView: some View {
            Circle()
                .fill(Color(self.parameters.color))
                .frame(width: Ocean.size.spacingStackXxs,
                       height: Ocean.size.spacingStackXxs)
        }

        @ViewBuilder
        private var titleRow: some View {
            OceanSwiftUI.Typography.description { label in
                label.parameters.text = parameters.title
                label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
            }
        }

        @ViewBuilder
        private var subtitleView: some View {
            if !parameters.subtitle.isEmpty {
                OceanSwiftUI.Typography.caption { label in
                    label.parameters.text = parameters.subtitle
                    label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                }
            }
        }

        @ViewBuilder
        private var valueView: some View {
            OceanSwiftUI.Typography.description { label in
                label.parameters.text = formattedValue
                label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
            }
        }
    }
}
