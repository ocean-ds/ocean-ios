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

    lazy var cardGroup00: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Crédito"
            view.parameters.tagLabelHeader = "Boletos disponíveis"
            view.parameters.tagStatusHeader = .highlightNeutral
            view.parameters.hasTagLabelBold = true
            view.parameters.headerBackgroundColor = Ocean.color.colorInterfaceLightUp
            view.parameters.hasDivider = false
            view.parameters.view = OceanSwiftUI.InvertedTextListItem { item in
                item.parameters.title = "Limite para pagar boletos"
                item.parameters.subtitle = "R$ 9.000,00"
                item.parameters.caption = "Pague em até 12 vezes"
                item.parameters.hasCaptionBold = true
                item.parameters.icon = Ocean.icon.fingerPrintSolid
                item.parameters.iconWidth = 56
                item.parameters.iconHeight = 56
                item.parameters.alignmentIcon = .leading
                item.parameters.status = .highlight
                item.parameters.backgroundColor = Ocean.color.colorInterfaceLightUp
            }
            view.parameters.ctaText = "Ir para boletos"
            view.parameters.ctaBadgeCount = 3
            view.parameters.ctaBadgeStatus = .warning
            view.parameters.contentBackgroundColor = Ocean.color.colorInterfaceLightUp
            view.parameters.highlightText = "Pague seu boleto da Ortobom Colchões hoje usando seu limite de crédito."
            view.parameters.highlightContentBackgroundColor = Ocean.color.colorBrandPrimaryPure
            view.parameters.onTouch = {
                print("Ir para boletos tapped")
            }
        }
    }()

    lazy var cardGroup: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()

    lazy var cardGroup1: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()

    lazy var cardGroup2: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()

    lazy var cardGroup3: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()

    lazy var cardGroup4: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()

    lazy var cardGroup5: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
        }
    }()

    lazy var cardGroup6: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()
    
    lazy var cardGroup7: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
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
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            cardGroup00
            cardGroup
            cardGroup1
            cardGroup2
            cardGroup3
            cardGroup4
            cardGroup5
            cardGroup6
            cardGroup7
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
struct CardGroupSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardGroupSwiftUIViewController()
        }
    }
}
