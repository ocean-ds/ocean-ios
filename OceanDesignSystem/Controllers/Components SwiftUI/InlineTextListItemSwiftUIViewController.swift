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
    lazy var inlineTextListItem1: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Default"
            textListItem.parameters.state = .normal
            textListItem.parameters.size = .normal
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem2: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Default"
            textListItem.parameters.state = .normal
            textListItem.parameters.size = .small
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem3: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Innactive"
            textListItem.parameters.state = .innactive
            textListItem.parameters.size = .normal
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem4: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Innactive"
            textListItem.parameters.state = .innactive
            textListItem.parameters.size = .small
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem5: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Positive"
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .normal
            textListItem.parameters.icon = OceanSwiftUI.RoundedIcon { icon in
                icon.parameters.icon = Ocean.icon.BluLogoSolid!
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem6: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Positive"
            textListItem.parameters.icon = OceanSwiftUI.RoundedIcon { icon in
                icon.parameters.icon = Ocean.icon.placeholderSolid!
            }
            textListItem.parameters.state = .positive
            textListItem.parameters.size = .small
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem7: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Warning"
            textListItem.parameters.icon = OceanSwiftUI.RoundedIcon { icon in
                icon.parameters.icon = Ocean.icon.placeholderSolid!
            }
            textListItem.parameters.state = .warning
            textListItem.parameters.size = .normal
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem8: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Warning"
            textListItem.parameters.icon = OceanSwiftUI.RoundedIcon { icon in
                icon.parameters.icon = Ocean.icon.placeholderSolid!
            }
            textListItem.parameters.state = .warning
            textListItem.parameters.size = .small
            textListItem.parameters.tag = OceanSwiftUI.Tag { tag in
                tag.parameters.label = "Oferta"
                tag.parameters.icon = Ocean.icon.fireSolid
                tag.parameters.status = .warning
                tag.parameters.size = .medium
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem9: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Highlight"
            textListItem.parameters.state = .highlight
            textListItem.parameters.size = .normal
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem10: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.description = "Description - Highlight"
            textListItem.parameters.state = .highlight
            textListItem.parameters.size = .small
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem11: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title - Strikethrough"
            textListItem.parameters.description = "Valor novo"
            textListItem.parameters.strikethroughText = "Valor Antigo"
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.size = .normal
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem12: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title - Strikethrough"
            textListItem.parameters.description = "Valor novo"
            textListItem.parameters.strikethroughText = "Valor Antigo"
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.size = .small
            textListItem.parameters.onTouch = { print("touched") }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem13: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.state = .withAction
            textListItem.parameters.size = .normal
            textListItem.parameters.button = OceanSwiftUI.Button.primarySM { button in
                button.parameters.text = "Saiba mais"
                button.parameters.isLoading = button.parameters.isLoading
                button.parameters.onTouch = button.parameters.onTouch
            }
            textListItem.parameters.onTouch = { print("touched") }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem14: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.state = .withAction
            textListItem.parameters.size = .small
            textListItem.parameters.button = OceanSwiftUI.Button.primarySM { button in
                button.parameters.text = "Saiba mais"
                button.parameters.isLoading = button.parameters.isLoading
                button.parameters.onTouch = button.parameters.onTouch
            }
            textListItem.parameters.onTouch = { print("touched") }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem15: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title"
            textListItem.parameters.showSkeleton = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem16: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Recebimentos futuros"
            textListItem.parameters.description = "RS 2.300,00"
            textListItem.parameters.tag = OceanSwiftUI.Tag { tag in
                tag.parameters.label = "Oferta"
                tag.parameters.icon = Ocean.icon.fireSolid
                tag.parameters.status = .warning
                tag.parameters.size = .medium
            }
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var inlineTextListItem17: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Recebimentos futuros"
            textListItem.parameters.description = "RS 2.300,00"
            textListItem.parameters.state = .strikethrough
            textListItem.parameters.icon = OceanSwiftUI.RoundedIcon { icon in
                icon.parameters.icon = Ocean.icon.placeholderSolid!
            }
            textListItem.parameters.tag = OceanSwiftUI.Tag { tag in
                tag.parameters.label = "Oferta"
                tag.parameters.icon = Ocean.icon.fireSolid
                tag.parameters.status = .warning
                tag.parameters.size = .medium
            }
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {

        VStack(spacing: Ocean.size.spacingStackXs) {
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
