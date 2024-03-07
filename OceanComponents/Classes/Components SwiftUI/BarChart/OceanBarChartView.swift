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

    public init(entries: [BarChartModel] = []) {
        self.entries = entries
    }

    func makeUIView(context: Context) -> BarChartView {
        let chartView = BarChartView()

        return chartView
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        let model = convertToBarChartDataEntries(models: entries)
        let dataSet = BarChartDataSet(entries: model)
        let data = BarChartData(dataSet: dataSet)
        uiView.data = data

        // cor das barras
//        dataSet.colors = [Ocean.color.colorBrandPrimaryPure]
        dataSet.colors = [Ocean.color.colorBrandPrimaryUp]

        // cor do texto acima das barras
        dataSet.valueColors = [Ocean.color.colorInterfaceDarkDown]

        // fonte do texto acima das barras
        dataSet.valueFont = .baseRegular(size: Ocean.font.fontSizeXxxs) ?? .systemFont(ofSize: Ocean.font.fontSizeXxxs)

        // desabilita touch nas barras
        dataSet.highlightEnabled = false

        // usar essa propriedade para controlar o alpha das outras barras
//        dataSet.highlightAlpha = 0.8

        // hide na grade
        uiView.rightAxis.enabled = false
        uiView.leftAxis.enabled = false

        // hide na linha no meio das barras (vertical)
        uiView.xAxis.drawGridLinesEnabled = false

        // espessura da linha da base
        uiView.xAxis.axisLineWidth = CGFloat(1)

        // cor da linha abaixo das barras
        uiView.xAxis.axisLineColor = Ocean.color.colorInterfaceLightDown

//        uiView.xAxis.axisLineDashPhase = CGFloat(10)

        // hide na legenda abaixo do grafico
        uiView.legend.enabled = false

        // desabilitando zoom
        uiView.pinchZoomEnabled = false
        uiView.doubleTapToZoomEnabled = false

        // legendas abaixo das barras
        uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["jan/2021",
                                                                       "fev/2021",
                                                                       "mar/2021",
                                                                       "jun/2021",
                                                                       "jul/2021",
                                                                       "ago/2021"])

        // posicao do texto (ENVIANDO PARA ABAIXO DAS BARRAS)
        uiView.xAxis.labelPosition = .bottom

        // fonte texto abaixo da barra
        uiView.xAxis.labelFont = .baseRegular(size: Ocean.font.fontSizeXxxs) ?? .systemFont(ofSize: Ocean.font.fontSizeXxxs)

        // cor do texto abaixo da barra
        uiView.xAxis.labelTextColor = Ocean.color.colorInterfaceDarkUp
        uiView.drawBarShadowEnabled = false
        uiView.drawValueAboveBarEnabled = true

        // formando o valor acima das barras (DECLARAR APOS A INSERÇÃO DOS DADOS)
        let formatterNumber = NumberFormatter()
        formatterNumber.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatterNumber)

//        uiView.barData?.barWidth = 16.0 / UIScreen.main.scale // Define a largura da barra em 16px

        uiView.barData?.barWidth = 0.4
    }

    private func convertToBarChartDataEntries(models: [BarChartModel]) -> [BarChartDataEntry] {
        var entries: [BarChartDataEntry] = []

        for (index, model) in models.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: Double(model.consultationCount))
            entries.append(entry)
        }

        return entries
    }
}
