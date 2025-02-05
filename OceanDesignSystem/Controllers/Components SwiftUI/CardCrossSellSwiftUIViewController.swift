//
//  CardCrossSellSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 09/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class CardCrossSellSwiftUIViewController: UIViewController {
    lazy var cardCrossSell: OceanSwiftUI.CardCrossSell = {
        OceanSwiftUI.CardCrossSell { view in
            view.parameters.title = "Mais saldo para seus pagamentos"
            view.parameters.subtitle = "Aproveite os recebíveis de outras maquininhas para pagar os boletos deste fornecedor."
            view.parameters.image = UIImage(named: "calendar-coin")
            view.parameters.ctaText = "Incluir no contrato"
            view.parameters.ctaIcon = Ocean.icon.plusOutline
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()

    lazy var cardCrossSell1: OceanSwiftUI.CardCrossSell = {
        OceanSwiftUI.CardCrossSell { view in
            view.parameters.title = "Mais saldo para seus pagamentos"
            view.parameters.subtitle = "Aproveite os recebíveis de outras maquininhas para pagar os boletos deste fornecedor."
            view.parameters.image = UIImage(named: "calendar-coin")
            view.parameters.ctaText = "Incluir no contrato"
            view.parameters.ctaIcon = Ocean.icon.plusOutline
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
            view.parameters.showSkeleton = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            cardCrossSell

            cardCrossSell1
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
struct CardCrossSellSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardCrossSellSwiftUIViewController()
        }
    }
}
