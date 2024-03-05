//
//  OceanSwiftUI+ChartHalfDonut.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 04/03/24.
//

import UIKit
import SwiftUI
import OceanTokens
import Charts

struct MyChart: UIViewRepresentable {
    let textCenter: String
    let entries: [PieChartDataEntry]
    let colors: [UIColor]

    public init(textCenter: String = "",
                entries: [PieChartDataEntry],
                colors: [UIColor]) {
        self.textCenter = textCenter
        self.entries = entries
        self.colors = colors
    }

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.centerText = textCenter
        uiView.configurePieChartViewHalfDonut()

        let dataSet = PieChartDataSet(entries: entries)
        dataSet.configureDataSetAppearance()
        dataSet.colors = colors
        let data = PieChartData(dataSet: dataSet)
        uiView.data = data
    }
}


extension OceanSwiftUI {
    // MARK: Parameters

    public class ChartHalfDonutParameters: ObservableObject {
        @Published public var valueMin: Double
        @Published public var valueMax: Double
        @Published public var currentValue: Double
        @Published public var colorPrimary: UIColor
        @Published public var colorSecondary: UIColor

        public init(valueMin: Double = 0,
                    valueMax: Double = 1000, 
                    currentValue: Double = 0,
                    colorPrimary: UIColor = Ocean.color.colorStatusPositivePure,
                    colorSecondary: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.valueMin = valueMin
            self.valueMax = valueMax
            self.currentValue = currentValue
            self.colorPrimary = colorPrimary
            self.colorSecondary = colorSecondary
        }
    }

    public struct ChartHalfDonut: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ChartHalfDonut) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ChartHalfDonutParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: ChartHalfDonutParameters = ChartHalfDonutParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                MyChart(textCenter: self.parameters.currentValue.toDecimal(),
                        entries: [.init(value: self.parameters.currentValue),
                                  .init(value: self.parameters.valueMax)],
                        colors: [self.parameters.colorPrimary,
                                 self.parameters.colorSecondary])
                .frame(width: 300, height: 150)
            }
            .padding(.bottom, -10)
            .background(Color.blue)
            HStack {
                Text(self.parameters.valueMin.toDecimal())
                Spacer()
                Text(self.parameters.valueMax.toDecimal())
            }
            .padding(.horizontal, 32)
        }

        // MARK: Methods private
    }
}

extension PieChartView {
    func configurePieChartViewHalfDonut() {
        holeRadiusPercent = 0.58
        drawHoleEnabled = true
        rotationEnabled = false
        highlightPerTapEnabled = true
        drawEntryLabelsEnabled = false
        drawCenterTextEnabled = true
        legend.enabled = false
        maxAngle = 180
        rotationAngle = 180
        centerTextOffset = CGPoint(x: 0, y: -30)
    }
}
