//
//  CardCrossSellViewController.swift
//  OceanDesignSystem
//
//  Created by Leticia Fernandes on 16/05/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class CardCrossSellViewController: UIViewController {
    private lazy var cardView1: Ocean.CardCrossSell = {
        Ocean.CardCrossSell { card in
            card.cardBackgroundColor = Ocean.color.colorBrandPrimaryPure
            card.title = "Mais saldo para seus pagamentos"
            card.subtitle = "Aproveite os recebíveis de outras maquininhas para pagar os boletos deste fornecedor."
            card.image = UIImage(named: "calendar-coin")
            card.buttonTitle = "Incluir no contrato"
            card.buttonIcon = Ocean.icon.plusOutline
            card.onTouchCard = {
                print("button tapped")
            }
            card.setSkeleton()
        }
    }()

    private lazy var cardView2: Ocean.CardCrossSell = {
        Ocean.CardCrossSell { card in
            card.cardBackgroundColors = [Ocean.color.colorBrandPrimaryDown,
                                         Ocean.color.colorInterfaceDarkDown]
            card.title = "Mais saldo para seus pagamentos"
            card.subtitle = "Aproveite os recebíveis de outras maquininhas para pagar os boletos deste fornecedor."
            card.image = UIImage(named: "calendar-coin")
            card.buttonTitle = "Incluir no contrato"
            card.onTouchCard = {
                print("button tapped")
            }
            card.setSkeleton()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubviews(cardView1, cardView2)
        cardView1.setConstraints(([.topToTop(16), .horizontalMargin(16)], toView: self.view))
        cardView2.setConstraints(([.horizontalMargin(16)], toView: self.view),
                                 ([.topToBottom(16)], toView: cardView1))
    }
}
