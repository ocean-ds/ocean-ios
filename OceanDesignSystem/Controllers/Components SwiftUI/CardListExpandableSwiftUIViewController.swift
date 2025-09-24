//
//  CardListExpandableSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 24/09/25.
//  Copyright © 2025 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class CardListExpandableSwiftUIViewController: UIViewController {

    var chart1: OceanSwiftUI.ChartBar = {
        let chart = OceanSwiftUI.ChartBar()
        chart.parameters.title = "Consultas"
        chart.parameters.subtitle = "Última consulta em 10/11/2023"

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

    var view1 = OceanSwiftUI.CardListExpandable { view in
        view.parameters.contentList.title = "Informações do parcelamento"
        view.parameters.content = {
            OceanSwiftUI.ContentList { contentList in
                contentList.parameters.description = "12x de R$ 315,32"
                contentList.parameters.descriptionColor = Ocean.color.colorInterfaceDarkDeep
                contentList.parameters.caption = "Primeiro pagamento: 28/09/2025. Boletos disponíveis aqui, na sua conta Blu."
            }
        }
    }

    var view2 = OceanSwiftUI.CardListExpandable { view in
        view.parameters.contentList.title = "Título do card"
        view.parameters.contentList.description = "Descrição do card"
        view.parameters.contentList.type = .highlight
        view.parameters.content = {
            OceanSwiftUI.ContentList { contentList in
                contentList.parameters.description = "12x de R$ 315,32"
                contentList.parameters.caption = "Primeiro pagamento: 28/09/2025. Boletos disponíveis aqui, na sua conta Blu."
                contentList.parameters.type = .inverted
            }
        }
    }

    lazy var view3 = OceanSwiftUI.CardListExpandable { view in
        view.parameters.contentList.title = "Card com view customizada"
        view.parameters.contentList.description = "Com qualquer e vários componentes"
        view.parameters.content = {
            VStack(spacing: Ocean.size.spacingStackSm) {
                OceanSwiftUI.CardGroup { cardView in
                    cardView.parameters.title = "Title"
                    cardView.parameters.subtitle = "Subtitle"
                    cardView.parameters.caption = "Caption"
                    cardView.parameters.ctaText = "Call to action"
                    cardView.parameters.isInverted = true
                    cardView.parameters.onTouch = {
                        cardView.parameters.isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            cardView.parameters.isLoading = false
                        }
                    }
                }

                self.chart1
                    .padding(.bottom, Ocean.size.spacingStackSm)
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
        }
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            view1
            view2
            view3
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .topToTop(to: self.view, constant: Ocean.size.spacingStackXs)
            .bottomToBottom(to: self.view)
            .leadingToLeading(to: self.view, constant: Ocean.size.spacingStackXs)
            .trailingToTrailing(to: self.view, constant: -Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct CardListExpandableSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardListExpandableSwiftUIViewController()
        }
    }
}
