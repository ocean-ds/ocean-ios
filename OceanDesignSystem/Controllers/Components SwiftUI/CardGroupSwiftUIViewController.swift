//
//  CardGroupSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 09/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class CardGroupSwiftUIViewController: UIViewController {
    lazy var cardGroup = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.subtitle = "Subtitle"
        view.parameters.caption = "Caption"
        view.parameters.ctaText = "Call to action"
        view.parameters.isInverted = true
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup1 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.subtitle = "Subtitle"
        view.parameters.icon = Ocean.icon.cloudOutline
        view.parameters.badgeCount = 5
        view.parameters.ctaText = "Call to action"
        view.parameters.view = HStack(alignment: .center) { Text("Content View").padding() }
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup2 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.subtitle = "Subtitle"
        view.parameters.icon = Ocean.icon.cloudOutline
        view.parameters.badgeCount = 5
        view.parameters.badgeStatus = .highlight
        view.parameters.recommend = true
        view.parameters.ctaText = "Call to action"
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup3 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.badgeCount = 5
        view.parameters.badgeStatus = .disabled
        view.parameters.ctaText = "Call to action"
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup4 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.ctaText = "Call to action"
        view.parameters.tagLabel = "Label"
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup5 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
    }

    lazy var cardGroup6 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.subtitle = "Subtitle"
        view.parameters.progress = 0.5
        view.parameters.ctaText = "Call to action"
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup7 = OceanSwiftUI.CardGroup { view in
        view.parameters.title = "Title"
        view.parameters.subtitle = "Subtitle"
        view.parameters.progress = 0.5
        view.parameters.ctaText = "Call to action"
        view.parameters.showSkeleton = true
        view.parameters.onTouch = {
            view.parameters.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                view.parameters.isLoading = false
            }
        }
    }

    lazy var cardGroup8 = factoryCardGroup(headerBackground: Ocean.color.colorInterfaceLightUp)

    lazy var cardGroup9 = factoryCardGroup(
        showSubtitle: false,
        headerBackground: Ocean.color.colorInterfaceLightUp
    )

    lazy var cardGroup10 = factoryCardGroup()

    lazy var cardGroup11 = factoryCardGroup(showSubtitle: false)

    lazy var cardGroup12 = factoryCardGroup(
        highlightText: "Pague seu boleto da Ortobom Colchões hoje usando seu limite de crédito.",
        highlightContentBackground: Ocean.color.colorStatusWarningDown
    )

    lazy var cardGroup13 = factoryCardGroup(
        showSubtitle: false,
        highlightText: "Pague seu boleto da Ortobom Colchões hoje usando seu limite de crédito.",
        highlightContentBackground: Ocean.color.colorStatusWarningDown
    )

    lazy var cardGroup14 = factoryCardGroup(
        headerBackground: Ocean.color.colorInterfaceLightUp,
        highlightText: "Pague seu boleto da Ortobom Colchões hoje usando seu limite de crédito.",
        highlightContentBackground: Ocean.color.colorBrandPrimaryPure,
        highlightTextColor: Ocean.color.colorInterfaceLightUp,
        tagLabelHeader: "Boletos disponíveis",
        hasTagBold: true,
        ctaText: "Ir para boletos",
        ctaBadgeCount: 3,
        ctaBadgeStatus: .warning
    )

    lazy var cardGroup15 = factoryCardGroup(
        showSubtitle: false,
        headerBackground: Ocean.color.colorInterfaceLightUp,
        highlightText: "Pague seu boleto da Ortobom Colchões hoje usando seu limite de crédito.",
        highlightContentBackground: Ocean.color.colorBrandPrimaryPure,
        highlightTextColor: Ocean.color.colorInterfaceLightUp,
        tagLabelHeader: "Boletos disponíveis",
        hasTagBold: true,
        ctaText: "Ir para boletos",
        ctaBadgeCount: 3,
        ctaBadgeStatus: .warning,
    )

    // MARK: - Hosting
    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            cardGroup
            cardGroup1
            cardGroup2
            cardGroup3
            cardGroup4
            cardGroup5
            cardGroup6
            cardGroup7
            cardGroup8
            cardGroup9
            cardGroup10
            cardGroup11
            cardGroup12
            cardGroup13
            cardGroup14
            cardGroup15
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

    private func factoryCardGroup(
        title: String = "Crédito",
        subtitle: String = "R$ 9.000,00",
        showSubtitle: Bool = true,
        caption: String = "Pague em até 12 vezes",
        headerBackground: UIColor = Ocean.color.colorInterfaceLightPure,
        highlightText: String? = nil,
        highlightContentBackground: UIColor? = nil,
        highlightTextColor: UIColor = Ocean.color.colorInterfaceDarkDeep,
        tagLabelHeader: String? = nil,
        tagStatusHeader: OceanSwiftUI.TagParameters.Status = .highlightNeutral,
        hasTagBold: Bool = false,
        ctaText: String = "Como usar crédito",
        ctaBadgeCount: Int? = nil,
        ctaBadgeStatus: OceanSwiftUI.BadgeParameters.Status = .warning,
        includeDivider: Bool = false
    ) -> OceanSwiftUI.CardGroup {

        OceanSwiftUI.CardGroup { view in
            view.parameters.title = title
            view.parameters.headerBackgroundColor = headerBackground
            view.parameters.hasDivider = includeDivider
            view.parameters.ctaText = ctaText
            view.parameters.ctaBadgeCount = ctaBadgeCount
            view.parameters.ctaBadgeStatus = ctaBadgeStatus
            view.parameters.highlightText = highlightText
            view.parameters.highlightContentBackgroundColor = highlightContentBackground
            view.parameters.highlightTextColor = highlightTextColor
            view.parameters.tagLabelHeader = tagLabelHeader
            view.parameters.tagStatusHeader = tagStatusHeader
            view.parameters.hasTagLabelBold = hasTagBold
            view.parameters.view = OceanSwiftUI.InvertedTextListItem { item in
                item.parameters.title = "Limite para pagar boletos"
                item.parameters.subtitle = subtitle
                item.parameters.showSubtitle = showSubtitle
                item.parameters.caption = caption
                item.parameters.hasCaptionBold = true
                item.parameters.leadingImage = Ocean.icon.fingerPrintSolid
                item.parameters.status = .highlight
                item.parameters.backgroundColor = headerBackground
            }
            view.parameters.onTouch = {
                print("Ir para boletos tapped")
            }
        }
    }
}

@available(iOS 13.0, *)
struct CardGroupSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardGroupSwiftUIViewController()
        }
    }
}
