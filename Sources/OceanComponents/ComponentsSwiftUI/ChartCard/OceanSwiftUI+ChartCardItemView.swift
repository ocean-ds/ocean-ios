//
//  OceanSwiftUI+ChartCardItemView.swift
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

        public init(title: String = "",
                    subtitle: String = "",
                    value: Double = 0,
                    color: UIColor = Ocean.color.colorInterfaceLightDeep,
                    valueRepresentationType: ValueRepresentationType = .percent) {
            self.title = title
            self.subtitle = subtitle
            self.value = value
            self.color = color
            self.valueRepresentationType = valueRepresentationType
        }

        public enum ValueRepresentationType {
            case percent
            case decimal
            case monetary
        }
    }

    public struct ChartCardItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ChartCardItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ChartCardItemParameters

        // MARK: Properties private

        @ViewBuilder
        private var titleRow: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingInlineXxs) {
                Circle()
                    .fill(Color(self.parameters.color))
                    .frame(width: Ocean.size.spacingStackXxs,
                           height: Ocean.size.spacingStackXxs)

                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = parameters.title
                    label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                }
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

        private var formattedValue: String {
            switch parameters.valueRepresentationType {
            case .decimal:
                return parameters.value.toDecimal()
            case .percent:
                return "\(parameters.value.toPercent())"
            case .monetary:
                return parameters.value.toCurrency(symbolSpace: true) ?? ""
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

        // MARK: View SwiftUI

        public var body: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                VStack(alignment: .leading, spacing: Ocean.size.spacingInlineXxxs) {
                    titleRow

                    subtitleView
                        .padding(.leading, Ocean.size.spacingInlineXs)
                }

                Spacer()

                valueView
            }
        }
    }
}
