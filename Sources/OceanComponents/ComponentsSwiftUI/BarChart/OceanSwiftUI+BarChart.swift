//
//  OceanSwiftUI+BarChart.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 06/03/24.
//

import SwiftUI
import OceanTokens
import DGCharts

extension OceanSwiftUI {

    public class ChartBarParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var entries: [BarChartModel]
        @Published public var color: UIColor
        @Published public var highlightColor: UIColor
        @Published public var shouldHighlightHighestValue: Bool

        public init(title: String = "",
                    subtitle: String = "",
                    entries: [BarChartModel] = [],
                    color: UIColor  = Ocean.color.colorBrandPrimaryUp,
                    highlightColor: UIColor = Ocean.color.colorBrandPrimaryPure,
                    shouldHighlightHighestValue: Bool = true) {
            self.title = title
            self.subtitle = subtitle
            self.entries = entries
            self.color = color
            self.highlightColor = highlightColor
            self.shouldHighlightHighestValue = shouldHighlightHighestValue
        }
    }

    public struct ChartBar: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ChartBar) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ChartBarParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: ChartBarParameters = ChartBarParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            headerView
            OceanBarChartView(entries: parameters.entries,
                              color: parameters.color,
                              highlightColor: parameters.highlightColor,
                              shouldHighlightHighestValue: parameters.shouldHighlightHighestValue)
            .frame(height: 150)
            .allowsHitTesting(false)
        }

        private var headerView: some View {
            VStack(alignment: .leading) {
                if !parameters.title.isEmpty {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = self.parameters.title
                    }
                }

                if !parameters.subtitle.isEmpty {
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxxs)

                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.subtitle
                    }
                }

                if !parameters.title.isEmpty || !parameters.subtitle.isEmpty {
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXs)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
