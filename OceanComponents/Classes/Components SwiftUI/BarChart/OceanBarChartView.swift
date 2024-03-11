//
//  OceanBarChartView.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 06/03/24.
//

import SwiftUI
import OceanTokens
import DGCharts

struct OceanBarChartView: UIViewRepresentable {
    public let entries: [BarChartModel]
    public let color: UIColor
    public let highlightColor: UIColor
    public let shouldHighlightHighestValue: Bool

    public init(entries: [BarChartModel],
                color: UIColor,
                highlightColor: UIColor,
                shouldHighlightHighestValue: Bool) {
        self.entries = entries
        self.color = color
        self.highlightColor = highlightColor
        self.shouldHighlightHighestValue = shouldHighlightHighestValue
    }

    func makeUIView(context: Context) -> BarChartView {
        let chartView = BarChartView()

        return chartView
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        let model = convertToBarChartDataEntries(models: entries)
        let dataSet = BarChartDataSet(entries: model)
        dataSet.colors = getBarColors()
        let data = BarChartData(dataSet: dataSet)
        uiView.data = data
        uiView.barData?.barWidth = 0.4

        configureGrid(chart: uiView)
        configureLabelFormatter(chart: uiView, labels: entries.map { $0.label })
        configureNumberFormatter(dataSet: dataSet)
    }

    private func convertToBarChartDataEntries(models: [BarChartModel]) -> [BarChartDataEntry] {
        var entries: [BarChartDataEntry] = []

        for (index, model) in models.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: Double(model.value))
            entries.append(entry)
        }

        return entries
    }

    private func getBarColors() -> [UIColor] {
        let maxValues = entries.map { $0.value }.max()

        if let maxValue = maxValues {
            let maxIndices = entries.indices.filter { entries[$0].value == maxValue }

            if shouldHighlightHighestValue {
                return entries.indices.map { maxIndices.contains($0) ? highlightColor : color }
            } else {
                return Array(repeating: color, count: entries.count)
            }
        }

        return Array(repeating: color, count: entries.count)
    }

    private func configureGrid(chart: BarChartView) {
        chart.legend.enabled = false
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.axisLineColor = Ocean.color.colorInterfaceLightDown
        chart.xAxis.axisLineWidth = CGFloat(1)
    }

    private func configureLabelFormatter(chart: BarChartView, labels: [String]) {
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelTextColor = Ocean.color.colorInterfaceDarkUp
        chart.xAxis.labelFont = .baseRegular(size: Ocean.font.fontSizeXxxs) ?? .systemFont(ofSize: Ocean.font.fontSizeXxxs)

        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
    }

    private func configureNumberFormatter(dataSet: BarChartDataSet) {
        dataSet.highlightEnabled = false
        dataSet.valueColors = [Ocean.color.colorInterfaceDarkDown]
        dataSet.valueFont = .baseRegular(size: Ocean.font.fontSizeXxxs) ?? .systemFont(ofSize: Ocean.font.fontSizeXxxs)

        let formatterNumber = NumberFormatter()
        formatterNumber.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatterNumber)

    }
}
