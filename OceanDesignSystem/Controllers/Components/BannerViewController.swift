//
//  BannerViewController.swift
//  OceanDesignSystem
//
//  Created by Leticia Fernandes on 16/05/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class BannerViewController: UIViewController {

    private lazy var bannerView: Ocean.Banner = {
        Ocean.Banner { banner in
            banner.title = "Mais saldo para seus pagamentos"
            banner.subtitle = "Aproveite os recebíveis de outras maquininhas para pagar os boletos deste fornecedor."
            banner.icon = UIImage(named: "icon-money")
            banner.buttonTitle = "Incluir no contrato"
            banner.onTouchButton = {
                print("button tapped")
            }
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(bannerView)
        bannerView.setConstraints(([.topToTop(16), .horizontalMargin(16)], toView: self.view))
    }
}
