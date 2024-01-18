//
//  TransactionListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 18/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TransactionListItemSwiftUIViewController: UIViewController {

    public lazy var transactionListItem1: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Transferência recebida"
            view.parameters.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.parameters.level3 = "Lente de contato Mônica"
            view.parameters.level4 = "Lojista 2"
            view.parameters.value1 = 2500
            view.parameters.value3 = "09:00"
            view.parameters.valueStatus = .positive
            view.parameters.tagTitle = "Pago"
            view.parameters.tagStatus = .positive
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem2: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Boleto pago"
            view.parameters.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.parameters.level3 = "Lente de contato Mônica"
            view.parameters.value1 = 1546.90
            view.parameters.value3 = "19:00"
            view.parameters.valueStatus = .negative
            view.parameters.tagTitle = "Pendente"
            view.parameters.tagStatus = .warning
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem3: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Transferência recebida"
            view.parameters.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.parameters.value1 = 500
            view.parameters.value3 = "12:00"
            view.parameters.valueStatus = .positive
            view.parameters.tagTitle = "Cancelado"
            view.parameters.tagStatus = .negative
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem4: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Transferência enviada"
            view.parameters.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.parameters.value1 = 200
            view.parameters.value3 = "12:00"
            view.parameters.valueStatus = .negative
            view.parameters.tagIcon = Ocean.icon.documentAddSolid
            view.parameters.tagTitle = "Pendente"
            view.parameters.tagStatus = .warning
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem5: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Antecipação de recebíveis"
            view.parameters.value1 = 800
            view.parameters.value3 = "13:00"
            view.parameters.valueStatus = .neutral
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem6: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Maskel Indústria e Comércio de Colchões da Silva Sauro Industrial"
            view.parameters.value1 = 15000
            view.parameters.value3 = "Agendado 24 Jun 2021"
            view.parameters.valueStatus = .neutral
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem7: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Amex"
            view.parameters.level2 = "Rede"
            view.parameters.value1 = 15000
            view.parameters.value2 = 1490.00
            view.parameters.value3 = "Confirmado às 14:00"
            view.parameters.valueStatus = .positive
            view.parameters.hasDivider = false
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            Spacer(minLength: 40)
            transactionListItem1
            transactionListItem2
            transactionListItem3
            transactionListItem4
            transactionListItem5
            transactionListItem6
            transactionListItem7
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

struct TransactionListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TransactionListItemSwiftUIViewController()
        }
    }
}

struct UIViewControllerPreview<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T

    init(_ builder: @escaping () -> T) {
        viewController = builder()
    }

    func makeUIViewController(context: Context) -> T {
        viewController
    }

    func updateUIViewController(_ uiViewController: T, context: UIViewControllerRepresentableContext<UIViewControllerPreview<T>>) {
        return
    }
}
