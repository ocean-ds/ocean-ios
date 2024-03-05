//
//  ChartHalfDonutViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class ChartHalfDonutViewController: UIViewController {
    var chart: OceanSwiftUI.ChartHalfDonut = {
        let chart = OceanSwiftUI.ChartHalfDonut()
        chart.parameters.currentValue = 700

        return chart
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
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
struct ChartHalfDonutViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ChartHalfDonutViewController()
        }
    }
}

