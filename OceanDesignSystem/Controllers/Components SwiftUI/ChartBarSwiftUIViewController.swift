//
//  ChartBarSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 06/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class ChartBarSwiftUIViewController: UIViewController {
    var chart1: OceanSwiftUI.BarChart = {
        let chart = OceanSwiftUI.BarChart()

        chart.parameters.entries = [
            .init(value: 20, label: "10/23"),
            .init(value: 30, label: "11/23"),
            .init(value: 56, label: "12/23"),
            .init(value: 25, label: "01/24"),
            .init(value: 56, label: "02/24"),
            .init(value: 56, label: "03/24")
        ]

        return chart
    }()

    var chart2: OceanSwiftUI.BarChart = {
        let chart = OceanSwiftUI.BarChart()
        chart.parameters.color = Ocean.color.colorComplementaryUp
        chart.parameters.highlightColor = Ocean.color.colorComplementaryPure
        chart.parameters.entries = [
            .init(value: 25, label: "01/24"),
            .init(value: 56, label: "02/24"),
            .init(value: 56, label: "03/24")
        ]

        return chart
    }()

    var chart3: OceanSwiftUI.BarChart = {
        let chart = OceanSwiftUI.BarChart()
        chart.parameters.color = Ocean.color.colorStatusPositiveUp
        chart.parameters.isHighlight = false

        chart.parameters.entries = [
            .init(value: 20, label: "10/23"),
            .init(value: 30, label: "11/23"),
            .init(value: 56, label: "12/23"),
            .init(value: 25, label: "01/24"),
            .init(value: 56, label: "02/24"),
            .init(value: 56, label: "03/24")
        ]

        return chart
    }()

    public lazy var hostingController = UIHostingController(rootView:  ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            chart1
            chart2
            chart3
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
struct ChartBarSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ChartBarSwiftUIViewController()
        }
    }
}

