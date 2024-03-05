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
    let centerText: String
    let entries: [PieChartDataEntry]
    let colors: [UIColor]

    public init(centerText: String = "",
                entries: [PieChartDataEntry],
                colors: [UIColor]) {
        self.centerText = centerText
        self.entries = entries
        self.colors = colors
    }

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.centerAttributedText = buildAttributedString(text: centerText)
        uiView.configurePieChartViewHalfDonut()

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
