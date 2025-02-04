//
//  ChartCardSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/02/25.
//  Copyright © 2025 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import SwiftUI

class ChartCardSwiftUIViewController: UIViewController {

    lazy var view1: OceanSwiftUI.ChartCard = {
        return OceanSwiftUI.ChartCard { view in
            view.parameters.title = "Total do período: R$ 4.302,00"
            view.parameters.subtitle = ""
            view.parameters.valueCenterDonut = "4"
            view.parameters.labelCenterDonut = "Vendas"
            view.parameters.items = [
                OceanSwiftUI.ChartCardItemParameters(title: "Crédito parcelado",
                                                     subtitle: "1 venda",
                                                     value: 1452,
                                                     color: Ocean.color.colorBrandPrimaryDown,
                                                     valueRepresentationType: .monetary),
                OceanSwiftUI.ChartCardItemParameters(title: "Crédito à vista",
                                                     subtitle: "1 venda",
                                                     value: 2240,
                                                     color: Ocean.color.colorStatusPositivePure,
                                                     valueRepresentationType: .monetary),
                OceanSwiftUI.ChartCardItemParameters(title: "Débito",
                                                     subtitle: "2 vendas",
                                                     value: 940,
                                                     color: Ocean.color.colorComplementaryPure,
                                                     valueRepresentationType: .monetary)
            ]
            view.parameters.onSelect = { model in
                print("Touched!")
                print(model)
            }
            view.parameters.showSkeleton = true
        }
    }()



    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: 0) {
            view1
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct ChartCardSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ChartCardSwiftUIViewController()
        }
    }
}


