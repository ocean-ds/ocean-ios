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
        @Published public var entries: [BarChartModel] = []
        @Published public var color: UIColor
        @Published public var highlightColor: UIColor
        @Published public var isHighlight: Bool

        public init(entries: [BarChartModel] = [],
                    color: UIColor  = Ocean.color.colorBrandPrimaryUp,
                    highlightColor: UIColor = Ocean.color.colorBrandPrimaryPure,
                    isHighlight: Bool = true) {
            self.entries = entries
            self.color = color
            self.highlightColor = highlightColor
            self.isHighlight = isHighlight
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
            OceanBarChartView(entries: parameters.entries,
                              color: parameters.color,
                              highlightColor: parameters.highlightColor,
                              isHighlightColor: parameters.isHighlight)
            .frame(height: 150)
        }
    }
}
