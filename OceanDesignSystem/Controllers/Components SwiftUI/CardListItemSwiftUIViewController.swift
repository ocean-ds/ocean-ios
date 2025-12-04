//
//  CardListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 26/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class CardListItemSwiftUIViewController: UIViewController {
    
    lazy var card1 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.tagLabel = "Tag"
        builder.parameters.tagSize = .small
        builder.parameters.tagStatus = .warning
        builder.parameters.onTouch = {
            print("card1")
            builder.parameters.showSkeleton = !builder.parameters.showSkeleton
        }
    }

    lazy var card2 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.onTouch = { print("card2") }
    }

    lazy var card3 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.caption = "Caption"
        builder.parameters.onTouch = { print("card3") }
    }

    lazy var card4 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.onTouch = { print("card4") }
    }

    lazy var card5 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card5") }
    }

    lazy var card51 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.tagLabel = "Até 21x"
        builder.parameters.tagStatus = .neutralPrimary
        builder.parameters.tagIsTrailing = true
        builder.parameters.onTouch = { print("card5") }
    }

    lazy var card52 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.tagLabel = "Até 21x"
        builder.parameters.tagStatus = .neutralPrimary
        builder.parameters.tagIsTrailing = true
        builder.parameters.isEnabled = false
        builder.parameters.onTouch = { print("card5") }
    }

    lazy var card6 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card6") }
    }

    lazy var card7 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.caption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card7") }
    }

    lazy var card8 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.caption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card8") }
        builder.parameters.titleLineLimit = 1
        builder.parameters.subtitleLineLimit = 1
        builder.parameters.captionLineLimit = 1
    }

    lazy var card9 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "title title title"
        builder.parameters.caption = "caption caption caption"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = nil
        builder.parameters.onTouch = { print("card8") }
        builder.parameters.titleLineLimit = 1
        builder.parameters.subtitleLineLimit = 1
        builder.parameters.captionLineLimit = 1
        builder.parameters.showSkeleton = true
    }

    lazy var card10 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "title title title"
        view.parameters.subtitle = "subtitle subtitle subtitle"
        view.parameters.caption = "caption caption caption"
        view.parameters.hasCheckbox = true
        view.parameters.onCheckboxSelect = { $0 ? print("Checked") : print("Unchecked") }
        view.parameters.onTouch = { print("card10") }
    }

    lazy var card11 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "title title title"
        view.parameters.subtitle = "subtitle subtitle subtitle"
        view.parameters.caption = "caption caption caption"
        view.parameters.hasRadioButton = true
        view.parameters.onTouch = { print("Checked") }
    }

    lazy var card12 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "À vista"
        view.parameters.subtitle = "Receba R$ 927,10 (Taxa 7,99%)"
        view.parameters.tagLabel = "Mais econômico"
        view.parameters.tagStatus = .positive
        view.parameters.highlightCaption = "Receber à vista agora é mais barato do que antecipar depois!"
        view.parameters.hasRadioButton = true
        view.parameters.onTouch = { print("Checked") }
    }

    lazy var card13 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "Crédito parcelado"
        view.parameters.titleColor = Ocean.color.colorInterfaceDarkDeep
        view.parameters.subtitle = "Parcele tudo em até 12 vezes com a 1ª parcela para 30 dias"
        view.parameters.caption = "Crédito aprovado: R$ 10.000,00"
        view.parameters.captionColor = Ocean.color.colorBrandPrimaryPure
        view.parameters.highlightCaption = "Melhor escolha para o caixa da sua loja."
        view.parameters.hasRadioButton = true
        view.parameters.onTouch = { print("Checked") }
    }
    
    lazy var card14 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "Crédito parcelado"
        view.parameters.titleColor = Ocean.color.colorInterfaceDarkDeep
        view.parameters.subtitle = "Parcele tudo em até 12 vezes com a 1ª parcela para 30 dias"
        view.parameters.caption = "Crédito aprovado: R$ 10.000,00"
        view.parameters.captionColor = Ocean.color.colorBrandPrimaryPure
        view.parameters.hasRadioButton = true
        view.parameters.isEnabled = false
        view.parameters.onTouch = { print("Checked") }
    }

    lazy var card15 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "Item desabilitado com toque"
        view.parameters.subtitle = "Este item está desabilitado mas ainda responde ao toque"
        view.parameters.caption = "Toque para ver a mensagem"
        view.parameters.leadingIcon = Ocean.icon.BluLogoOutline
        view.parameters.isEnabled = false
        view.parameters.onTouch = {
            print("Este não será chamado pois está desabilitado")
        }
        view.parameters.onTouchWhenDisabled = {
            print("Toque no item desabilitado!")
        }
    }

    lazy var card16 = OceanSwiftUI.CardListItem { view in
        view.parameters.title = "Opção bloqueada"
        view.parameters.subtitle = "insufficient_credit_limit"
        view.parameters.hasRadioButton = true
        view.parameters.isEnabled = false
        view.parameters.onTouchWhenDisabled = {
            print("Modal explicativa")
        }
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            card51
            card52
            card16
            card15
            card14
            card13
            card12
            card1
            card2
            card3
            card4
            card5
            card6
            card7
            card8
            card9
            card10
            card11
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
struct CardListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardListItemSwiftUIViewController()
        }
    }
}
