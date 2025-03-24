//
//  PieChartView+Extensions.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 05/02/25.
//

import Foundation
import DGCharts

extension PieChartView {
    public func configurePieChartViewAppearance() {
        holeRadiusPercent = 0.65
        transparentCircleRadiusPercent = 0.5
        chartDescription.enabled = false
        setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        drawHoleEnabled = true
        rotationAngle = 0
        rotationEnabled = false
        highlightPerTapEnabled = true
        drawEntryLabelsEnabled = false
        drawCenterTextEnabled = true
        legend.enabled = false
        rotationAngle = 270
    }
}
