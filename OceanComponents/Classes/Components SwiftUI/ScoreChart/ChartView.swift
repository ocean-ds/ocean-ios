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
    public let diffValue: Double
    public let currentValue: Double

    public init(currentValue: Double, diffValue: Double) {
        self.currentValue = currentValue
        self.diffValue = diffValue
    }

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        let centerText = currentValue.toDecimal()
        uiView.centerAttributedText = buildAttributedString(text: centerText)
        uiView.configurePieChartViewHalfDonut()

        let entries: [PieChartDataEntry] = [.init(value: currentValue), .init(value: diffValue)]
        
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
            return Ocean.color.colorStatusNegativePure
        } else if currentValue < 501 {
            return Ocean.color.colorStatusNeutralDeep
        } else if currentValue < 701 {
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
