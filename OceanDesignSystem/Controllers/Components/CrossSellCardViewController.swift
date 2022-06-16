//
//  CrossSellCardViewController.swift
//  OceanDesignSystem
//
//  Created by Leticia Fernandes on 16/05/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class CrossSellCardViewController: UIViewController {

    private lazy var crossSellCardView: Ocean.CrossSellCard = {
        Ocean.CrossSellCard { card in
            card.title = "Mais saldo para seus pagamentos"
            card.subtitle = "Aproveite os recebíveis de outras maquininhas para pagar os boletos deste fornecedor."
            card.image = UIImage(named: "calendar-coin")
            card.buttonTitle = "Incluir no contrato"
            card.buttonIcon = Ocean.icon.plusOutline
            card.cardBackgroundColor = Ocean.color.colorBrandPrimaryDown
            card.onTouchCard = {
                print("button tapped")
            }
            card.setSkeleton()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(crossSellCardView)
        crossSellCardView.setConstraints(([.topToTop(16), .horizontalMargin(16)], toView: self.view))
    }
}
