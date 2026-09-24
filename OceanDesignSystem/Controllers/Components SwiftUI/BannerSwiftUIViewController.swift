//
//  BannerSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Mateus Amarante on 09/06/26.
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class BannerSwiftUIViewController: UIViewController {

    // Large - Default
    lazy var bannerLargeDefault: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .large
            view.parameters.bannerType = .default
            view.parameters.title = "Banner Large Default"
            view.parameters.description = "Descrição opcional do banner no tamanho large com tipo default."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Ação Primária"),
                OceanSwiftUI.ButtonParameters(text: "Ação Secundária")
            ]
        }
    }()

    // Large - Warning
    lazy var bannerLargeWarning: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .large
            view.parameters.bannerType = .warning
            view.parameters.title = "Banner Large Warning"
            view.parameters.description = "Atenção! Este é um banner de aviso com tipo warning."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Entendi"),
                OceanSwiftUI.ButtonParameters(text: "Cancelar")
            ]
        }
    }()

    // Large - Negative
    lazy var bannerLargeNegative: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .large
            view.parameters.bannerType = .negative
            view.parameters.title = "Banner Large Negative"
            view.parameters.description = "Ocorreu um erro. Este é um banner do tipo negativo."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Tentar novamente"),
                OceanSwiftUI.ButtonParameters(text: "Cancelar")
            ]
        }
    }()

    // Large - Emphasys
    lazy var bannerLargeEmphasys: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .large
            view.parameters.bannerType = .emphasys
            view.parameters.title = "Banner Large Emphasys"
            view.parameters.description = "Destaque máximo! Este é um banner do tipo emphasys com fundo brand."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Saiba mais"),
                OceanSwiftUI.ButtonParameters(text: "Fechar")
            ]
        }
    }()

    // Small - Default
    lazy var bannerSmallDefault: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .small
            view.parameters.bannerType = .default
            view.parameters.title = "Banner Small Default"
            view.parameters.description = "Descrição do banner small com tipo default."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Ação Primária"),
                OceanSwiftUI.ButtonParameters(text: "Ação Secundária")
            ]
        }
    }()

    // Small - Warning
    lazy var bannerSmallWarning: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .small
            view.parameters.bannerType = .warning
            view.parameters.title = "Banner Small Warning"
            view.parameters.description = "Atenção! Este é um banner de aviso compacto."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Entendi"),
                OceanSwiftUI.ButtonParameters(text: "Cancelar")
            ]
        }
    }()

    // Small - Negative
    lazy var bannerSmallNegative: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .small
            view.parameters.bannerType = .negative
            view.parameters.title = "Banner Small Negative"
            view.parameters.description = "Ocorreu um erro. Banner negativo compacto."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Tentar novamente"),
                OceanSwiftUI.ButtonParameters(text: "Cancelar")
            ]
        }
    }()

    // Small - Emphasys
    lazy var bannerSmallEmphasys: OceanSwiftUI.Banner = {
        OceanSwiftUI.Banner { view in
            view.parameters.size = .small
            view.parameters.bannerType = .emphasys
            view.parameters.title = "Banner Small Emphasys"
            view.parameters.description = "Destaque compacto com fundo brand."
            view.parameters.buttons = [
                OceanSwiftUI.ButtonParameters(text: "Saiba mais"),
                OceanSwiftUI.ButtonParameters(text: "Fechar")
            ]
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: AnyView(ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            bannerLargeDefault
            bannerLargeWarning
            bannerLargeNegative
            bannerLargeEmphasys
            bannerSmallDefault
            bannerSmallWarning
            bannerSmallNegative
            bannerSmallEmphasys
        }
        .padding(.all, Ocean.size.spacingStackXs)
    }))

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
struct BannerSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            BannerSwiftUIViewController()
        }
    }
}
