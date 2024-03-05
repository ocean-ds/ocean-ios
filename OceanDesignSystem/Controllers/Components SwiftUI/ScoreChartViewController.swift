//
//  ScoreChartViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class ScoreChartViewController: UIViewController {
    var chartHighRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.scoreCurrent = 200

        return chart
    }()
    var chartMediumRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.scoreCurrent = 400

        return chart
    }()
    var chartLowRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.scoreCurrent = 600

        return chart
    }()
    var chartVeryLowRisk: OceanSwiftUI.ScoreChart = {
        let chart = OceanSwiftUI.ScoreChart()
        chart.parameters.scoreCurrent = 900

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
struct ScoreChartViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ScoreChartViewController()
        }
    }
}
