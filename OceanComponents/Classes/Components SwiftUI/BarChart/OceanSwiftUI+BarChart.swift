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

    public class BarChartParameters: ObservableObject {
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

    public struct BarChart: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (BarChart) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: BarChartParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: BarChartParameters = BarChartParameters()) {
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
        }

        private var headerView: some View {
            HStack {
                VStack(alignment: .leading) {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = self.parameters.title
                    }
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxxs)
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.subtitle
                    }
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXs)
                }
                Spacer()
            }
        }
    }
}
