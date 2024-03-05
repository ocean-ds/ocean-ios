//
//  ScoreChartSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class ScoreChartSwiftUIViewController: UIViewController {
    var chartHighRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 200

        return chart
    }()
    var chartMediumRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 400

        return chart
    }()
    var chartLowRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 600

        return chart
    }()
    var chartVeryLowRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 900

        return chart
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            chartHighRisk
            chartMediumRisk
            chartLowRisk
            chartVeryLowRisk
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct ScoreChartSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ScoreChartSwiftUIViewController()
        }
    }
}
