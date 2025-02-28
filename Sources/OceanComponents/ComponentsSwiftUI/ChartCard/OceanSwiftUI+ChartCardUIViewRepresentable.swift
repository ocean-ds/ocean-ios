//
//  OceanSwiftUI+ChartCardUIViewRepresentable.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 04/02/25.
//

import Foundation
import UIKit
import SwiftUI
import OceanTokens
import DGCharts

extension OceanSwiftUI {

    struct ChartCardUIViewRepresentable: UIViewRepresentable {

        // MARK: Properties

        public let items: [ChartCardItemParameters]
        public let valueCenterDonut: String
        public let labelCenterDonut: String

        public init(items: [ChartCardItemParameters],
                    valueCenterDonut: String,
                    labelCenterDonut: String) {
            self.items = items
            self.valueCenterDonut = valueCenterDonut
            self.labelCenterDonut = labelCenterDonut
        }

        // MARK: UIViewRepresentable

        func makeUIView(context: Context) -> PieChartView {
            let chartView = PieChartView()
            setupChartView(chartView, context: context)
            return chartView
        }

        func updateUIView(_ chartView: PieChartView, context: Context) {
            updateChartData(chartView)
            updateCenterText(chartView)
        }

        // MARK: Private methods

        private func setupChartView(_ chartView: PieChartView, context: Context) {
            chartView.configurePieChartViewAppearance()
            chartView.animate(xAxisDuration: 1, yAxisDuration: 1.5)
        }

        private func updateChartData(_ chartView: PieChartView) {
            let dataSet = createDataSet()
            chartView.data = PieChartData(dataSet: dataSet)
        }

        private func createDataSet() -> PieChartDataSet {
            if items.allSatisfy({ $0.value == 0 }) {
                return createEmptyDataSet()
            }

            let entries = items.map { PieChartDataEntry(value: $0.value, data: $0.value) }
            let colors = items.map { $0.color }

            let dataSet = PieChartDataSet(entries: entries)
            dataSet.configureDataSetAppearance()
            dataSet.colors = colors

            return dataSet
        }

        private func createEmptyDataSet() -> PieChartDataSet {
            let emptyEntry = PieChartDataEntry(value: 1, data: 0)
            let dataSet = PieChartDataSet(entries: [emptyEntry])
            dataSet.configureDataSetAppearance()
            dataSet.colors = [Ocean.color.colorInterfaceLightDeep]
            return dataSet
        }

        private func updateCenterText(_ chartView: PieChartView) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributedString = NSMutableAttributedString(
                string: "\(valueCenterDonut)\n",
                attributes: [
                    .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                                  size: Ocean.font.fontSizeSm) as Any,
                    .foregroundColor: Ocean.color.colorInterfaceDarkDeep,
                    .paragraphStyle: paragraphStyle
                ])

            attributedString.append(
                NSAttributedString(
                    string: labelCenterDonut,
                    attributes: [
                        .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                                      size: Ocean.font.fontSizeXxxs) as Any,
                        .foregroundColor: Ocean.color.colorInterfaceDarkDown,
                        .paragraphStyle: paragraphStyle
                    ]))

            chartView.centerAttributedText = attributedString
        }
    }
}
