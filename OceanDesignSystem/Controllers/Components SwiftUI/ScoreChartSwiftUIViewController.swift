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
    var chart1: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 100

        return chart
    }()
    var chart2: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 200

        return chart
    }()
    var chart3: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 300

        return chart
    }()
    var chart4: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 400

        return chart
    }()
    var chart5: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 500

        return chart
    }()
    var chart6: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 600

        return chart
    }()
    var chart7: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 700

        return chart
    }()
    var chart8: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 800

        return chart
    }()
    var chart9: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 900

        return chart
    }()
    var chart10: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.currentValue = 1000

        return chart
    }()
    var chart11: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.title = "Score"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"
        chart.parameters.minValue = 0
        chart.parameters.maxValue = 1000
        chart.parameters.currentValue = 310

        return chart
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            chart1
            chart2
            chart3
            chart4
            chart5
            chart6
            chart7
            chart8
            chart9
            chart10
            chart11
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
