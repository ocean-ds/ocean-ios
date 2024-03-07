//
//  ChartView.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 05/03/24.
//

import SwiftUI
import OceanTokens
import DGCharts

struct ChartView: UIViewRepresentable {
    public let minValue: Double
    public let maxValue: Double
    public let currentValue: Double

    public init(minValue: Double, 
                maxValue: Double,
                currentValue: Double) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.currentValue = currentValue
    }

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        let diffValue = maxValue - currentValue
        var currentValueCalculate: Double = 0.0
        var centerText: String = ""
        
        if currentValue > minValue {
            currentValueCalculate = currentValue - minValue
            centerText = currentValue.toDecimal()
        }

        uiView.centerAttributedText = buildAttributedString(text: centerText)
        uiView.configurePieChartViewHalfDonut()
        
        uiView.animate(xAxisDuration: 1,
                       yAxisDuration: 1.5,
                       easingOption: .easeInOutSine)

        let entries: [PieChartDataEntry] = [.init(value: currentValueCalculate), .init(value: diffValue)]

        let primaryColor = getPrimaryColor()
        let secondaryColor = Ocean.color.colorInterfaceLightDeep
        let colors: [UIColor] = [primaryColor, secondaryColor]

        let dataSet = PieChartDataSet(entries: entries)
        dataSet.configureDataSetAppearance()
        dataSet.colors = colors
        
        let data = PieChartData(dataSet: dataSet)
        uiView.data = data
    }

    private func buildAttributedString(text: String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        return NSMutableAttributedString(
            string: text,
            attributes: [
                .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                              size: Ocean.font.fontSizeSm) as Any,
                .foregroundColor: Ocean.color.colorInterfaceDarkDeep,
                .paragraphStyle: paragraphStyle
            ])
    }

    private func getPrimaryColor() -> UIColor {
        if currentValue < 301 {
            return Ocean.color.colorInterfaceLightDeep
        } else if currentValue < 501 {
            return Ocean.color.colorStatusNegativeDeep
        } else if currentValue < 601 {
            return Ocean.color.colorStatusNegativePure
        } else if currentValue < 701 {
            return Ocean.color.colorStatusNeutralDeep
        } else if currentValue < 901 {
            return Ocean.color.colorStatusPositivePure
        } else {
            return Ocean.color.colorStatusPositiveDeep
        }
    }
}

extension PieChartView {
    func configurePieChartViewHalfDonut() {
        holeRadiusPercent = 0.55
        drawHoleEnabled = true
        rotationEnabled = false
        highlightPerTapEnabled = true
        drawEntryLabelsEnabled = false
        drawCenterTextEnabled = true
        legend.enabled = false
        maxAngle = 180
        rotationAngle = 180
        centerTextOffset = CGPoint(x: 0, y: -10)
    }
}
