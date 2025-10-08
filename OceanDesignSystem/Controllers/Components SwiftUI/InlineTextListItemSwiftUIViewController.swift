//
//  InlineTextListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 27/01/25.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class InlineTextListItemSwiftUIViewController: UIViewController {

    lazy var inlineTextListItem0: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Teste",
            value: "Ícone: arrow-u-turn-lef-outline",
            valueColor: Ocean.color.colorStatusPositiveDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .normal
            textListItem.parameters.icon = .init(icon: Ocean.icon.arrowUturnLeftOutline!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
        }
    }()

    lazy var inlineTextListItem01: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Teste",
            value: "Ícone: link-alt-outline",
            valueColor: Ocean.color.colorStatusPositiveDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .normal
            textListItem.parameters.icon = .init(icon: Ocean.icon.linkAltOutline!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
        }
    }()

    lazy var inlineTextListItem1: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Default",
            valueColor: Ocean.color.colorInterfaceDarkDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .normal
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem2: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Default",
            valueColor: Ocean.color.colorInterfaceDarkDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .normal
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem3: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Innactive",
            valueColor: Ocean.color.colorInterfaceDarkUp
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .innactive
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem4: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Innactive",
            valueColor: Ocean.color.colorInterfaceDarkUp
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .innactive
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem5: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Positive",
            valueColor: Ocean.color.colorStatusPositiveDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .normal
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
        }
    }()

    lazy var inlineTextListItem6: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Positive",
            valueColor: Ocean.color.colorStatusPositiveDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem7: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Warning",
            valueColor: Ocean.color.colorStatusWarningDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusWarningDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.state = .warning
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem8: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Warning",
            valueColor: Ocean.color.colorStatusWarningDeep)

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.tag = .init(label: "Oferta",
                                                icon: Ocean.icon.fireSolid!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusWarningDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.state = .warning
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem9: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Highlight",
            valueColor: Ocean.color.colorInterfaceDarkDeep,
            isBoldValue: true
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .highlight
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem10: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "Description - Highlight",
            valueColor: Ocean.color.colorInterfaceDarkDeep,
            isBoldValue: true
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .highlight
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem11: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title - Strikethrough",
            value: "Valor antigo",
            valueColor: Ocean.color.colorInterfaceDarkDeep,
            newValue: "Valor novo",
            newValueColor: Ocean.color.colorStatusPositiveDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.size = .normal
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem12: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title - Strikethrough",
            value: "Valor antigo",
            valueColor: Ocean.color.colorInterfaceDarkDeep,
            newValue: "Valor novo",
            newValueColor: Ocean.color.colorStatusPositiveDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.size = .small
            textListItem.parameters.onTouch = { print("touched") }
        }
    }()

    lazy var inlineTextListItem13: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "",
            valueColor: Ocean.color.colorInterfaceDarkDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .withAction
            textListItem.parameters.size = .normal
            textListItem.parameters.button = .init(text: "Saiba mais",
                                                   style: .primary,
                                                   size: .small,
                                                   onTouch: { print("Oieee") })
            textListItem.parameters.onTouch = { print("touched") }
        }
    }()

    lazy var inlineTextListItem14: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Title",
            value: "",
            valueColor: Ocean.color.colorInterfaceDarkDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .withAction
            textListItem.parameters.size = .small
            textListItem.parameters.button = .init(text: "Saiba mais",
                                                   style: .primary,
                                                   size: .small,
                                                   onTouch: { print("Oieee") })
            textListItem.parameters.onTouch = { print("touched") }
        }
    }()

    lazy var inlineTextListItem15: OceanSwiftUI.InlineTextListItem = {
        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.showSkeleton = true
        }
    }()

    lazy var inlineTextListItem16: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Recebimentos futuros",
            value: "RS 2.300,00",
            valueColor: Ocean.color.colorInterfaceDarkDeep)

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.tag = .init(label: "Oferta",
                                                icon: Ocean.icon.fireSolid!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem17: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Recebimentos futuros",
            value: "RS 2.300,00",
            valueColor: Ocean.color.colorInterfaceDarkDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.tag = .init(label: "Oferta",
                                                icon: Ocean.icon.fireSolid!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem18: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Ícone do lighthouse",
            value: "",
            valueColor: Ocean.color.colorInterfaceDarkDeep
        )

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.tag = .init(label: "New",
                                                icon: Ocean.icon.lighthouseOutline!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem19: OceanSwiftUI.InlineTextListItem = {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Ícone do lighthouse",
            value: "",
            valueColor: Ocean.color.colorInterfaceDarkDeep)

        return OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.item = item
            textListItem.parameters.tag = .init(label: "New",
                                                icon: " lighthouseOutline ".toOceanIcon()!,
                                                status: .positive,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()


    lazy var inlineTextListItem1Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Default"
            textListItem.parameters.state = .normal
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem2Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Default"
            textListItem.parameters.state = .normal
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem3Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Innactive"
            textListItem.parameters.state = .innactive
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem4Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Innactive"
            textListItem.parameters.state = .innactive
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem5Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Positive"
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .normal
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
        }
    }()

    lazy var inlineTextListItem6Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Positive"
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem7Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Warning"
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusWarningDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.state = .warning
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem8Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Warning"
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusWarningDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.state = .warning
            textListItem.parameters.size = .small
            textListItem.parameters.tag = .init(label: "Oferta",
                                                icon: Ocean.icon.fireSolid!,
                                                status: .warning,
                                                size: .medium)
        }
    }()

    lazy var inlineTextListItem9Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Highlight"
            textListItem.parameters.state = .highlight
            textListItem.parameters.size = .normal
        }
    }()

    lazy var inlineTextListItem10Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Highlight"
            textListItem.parameters.state = .highlight
            textListItem.parameters.size = .small
        }
    }()

    lazy var inlineTextListItem11Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title - Strikethrough"
            textListItem.parameters.description = "Valor novo"
            textListItem.parameters.strikethroughText = "Valor Antigo"
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.size = .normal
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem12Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title - Strikethrough"
            textListItem.parameters.description = "Valor novo"
            textListItem.parameters.strikethroughText = "Valor Antigo"
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.size = .small
            textListItem.parameters.onTouch = { print("touched") }
        }
    }()

    lazy var inlineTextListItem13Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.state = .withAction
            textListItem.parameters.size = .normal
            textListItem.parameters.button = .init(text: "Saiba mais",
                                                   style: .primary,
                                                   size: .small,
                                                   onTouch: { print("Oieee") })
            textListItem.parameters.onTouch = { print("touched") }
        }
    }()

    lazy var inlineTextListItem14Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.state = .withAction
            textListItem.parameters.size = .small
            textListItem.parameters.button = .init(text: "Saiba mais",
                                                   style: .primary,
                                                   size: .small,
                                                   onTouch: { print("Oieee") })
            textListItem.parameters.onTouch = { print("touched") }
        }
    }()

    lazy var inlineTextListItem15Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.showSkeleton = true
        }
    }()

    lazy var inlineTextListItem16Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Recebimentos futuros"
            textListItem.parameters.description = "RS 2.300,00"
            textListItem.parameters.tag = .init(label: "Oferta",
                                                icon: Ocean.icon.fireSolid!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem17Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Recebimentos futuros"
            textListItem.parameters.description = "RS 2.300,00"
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.icon = .init(icon: Ocean.icon.placeholderSolid!,
                                                 color: Ocean.color.colorStatusPositiveDeep,
                                                 backgroundColor: Ocean.color.colorInterfaceLightPure)
            textListItem.parameters.tag = .init(label: "Oferta",
                                                icon: Ocean.icon.fireSolid!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem18Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Ícone do lighthouse"
            textListItem.parameters.tag = .init(label: "New",
                                                icon: Ocean.icon.lighthouseOutline!,
                                                status: .warning,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    lazy var inlineTextListItem19Direct: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Ícone do lighthouse"
            textListItem.parameters.tag = .init(label: "New",
                                                icon: " lighthouseOutline ".toOceanIcon()!,
                                                status: .positive,
                                                size: .medium)
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            inlineTextListItem0
            inlineTextListItem01
            inlineTextListItem1
            inlineTextListItem2
            inlineTextListItem3
            inlineTextListItem4
            inlineTextListItem5
            inlineTextListItem6
            inlineTextListItem7
            inlineTextListItem8
            inlineTextListItem9
            inlineTextListItem10
            inlineTextListItem11
            inlineTextListItem12
            inlineTextListItem13
            inlineTextListItem14
            inlineTextListItem15
            inlineTextListItem16
            inlineTextListItem17
            inlineTextListItem18
            inlineTextListItem19
        }

        VStack(spacing: Ocean.size.spacingStackXs) {
            OceanSwiftUI.Typography.heading1 { label in
                label.parameters.text = "Passando os itens direto"
            }

            inlineTextListItem1Direct
            inlineTextListItem2Direct
            inlineTextListItem3Direct
            inlineTextListItem4Direct
            inlineTextListItem5Direct
            inlineTextListItem6Direct
            inlineTextListItem7Direct
            inlineTextListItem8Direct
            inlineTextListItem9Direct
            inlineTextListItem10Direct
            inlineTextListItem11Direct
            inlineTextListItem12Direct
            inlineTextListItem13Direct
            inlineTextListItem14Direct
            inlineTextListItem15Direct
            inlineTextListItem16Direct
            inlineTextListItem17Direct
            inlineTextListItem18Direct
            inlineTextListItem19Direct
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
struct InlineTextListItemSwiftUIViewController_Preview: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            InlineTextListItemSwiftUIViewController()
        }
    }
}
