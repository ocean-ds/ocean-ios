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
    var chart: OceanSwiftUI.BarChart = {
        let chart = OceanSwiftUI.BarChart()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        chart.parameters.entries = [
            .init(date: dateFormatter.date(from: "10/01/2024")!,
                  consultationCount: 20),
            .init(date: dateFormatter.date(from: "11/02/2024")!,
                  consultationCount: 50),
            .init(date: dateFormatter.date(from: "01/03/2024")!,
                  consultationCount: 16),
            .init(date: dateFormatter.date(from: "01/04/2024")!,
                  consultationCount: 30),
            .init(date: dateFormatter.date(from: "01/05/2024")!,
                  consultationCount: 10),
            .init(date: dateFormatter.date(from: "01/06/2024")!,
                  consultationCount: 60)
        ]

        return chart
    }()

    public lazy var hostingController = UIHostingController(rootView:  ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            chart
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

