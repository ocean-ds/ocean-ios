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
            view.parameters.value1Status = .positive
            view.parameters.tagTitle = "Pago"
            view.parameters.tagStatus = .positive
            view.parameters.hasChevron = true
            view.parameters.hasCheckbox = true
            view.parameters.isSelected = true
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
            view.parameters.value1Status = .negative
            view.parameters.tagTitle = "Pendente"
            view.parameters.tagStatus = .warning
            view.parameters.hasCheckbox = true
            view.parameters.isSelected = true
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
            view.parameters.value1Status = .positive
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
            view.parameters.value1Status = .negative
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
            view.parameters.value1Status = .neutral
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
            view.parameters.value1Status = .neutral
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
            view.parameters.value1Status = .positive
            view.parameters.hasDivider = false
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem8: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Transferência recebida"
            view.parameters.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.parameters.level3 = "Lente de contato Mônica"
            view.parameters.level4 = "Lojista 2"
            view.parameters.value1 = 2500
            view.parameters.value3 = "09:00"
            view.parameters.value1Status = .positive
            view.parameters.tagTitle = "Pago"
            view.parameters.tagStatus = .positive
            view.parameters.hasChevron = true
            view.parameters.hasCheckbox = true
            view.parameters.isSelected = true
            view.parameters.isEnabled = false
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem9: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Transferência recebida"
            view.parameters.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.parameters.level3 = "Lente de contato Mônica"
            view.parameters.level4 = "Lojista 1"
            view.parameters.value1Text = "Grátis"
            view.parameters.value1Status = .positive
            view.parameters.hasChevron = true
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem10: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Level 1 - cancelled"
            view.parameters.level2 = "Level 2"
            view.parameters.level3 = "Level 3"
            view.parameters.level4 = "Level 4"
            view.parameters.value1 = 1000
            view.parameters.value3 = "Value 3"
            view.parameters.value1Status = .cancelled
            view.parameters.tagTitle = "Tag title"
            view.parameters.tagStatus = .positive
            view.parameters.hasChevron = true
            view.parameters.hasCheckbox = true
            view.parameters.isSelected = true
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem11: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Level 1 - processing"
            view.parameters.level2 = "Level 2"
            view.parameters.level3 = "Level 3"
            view.parameters.level4 = "Level 4"
            view.parameters.value1 = 1000
            view.parameters.value3 = "Value 3"
            view.parameters.value1Status = .processing
            view.parameters.tagTitle = "Tag title"
            view.parameters.tagStatus = .positive
            view.parameters.hasChevron = true
            view.parameters.hasCheckbox = true
            view.parameters.isSelected = true
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem12: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Crédito parcelado"
            view.parameters.level2 = "Maquininha Blu"
            view.parameters.level3 = "Valor dividido com Pascon Empreendimentos e Participações S/A"
            view.parameters.tagTitle = "Processando"
            view.parameters.tagStatus = .neutralInterface
            view.parameters.value1 = 1452.00
            view.parameters.value3 = "08:30"
            view.parameters.value1Status = .processing
            view.parameters.hasDivider = false
            view.parameters.hasChevron = true
            view.parameters.lineLimitLevel3 = 2
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem13: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Crédito à vista"
            view.parameters.level2 = "Blu Tap"
            view.parameters.tagTitle = "Confirmada"
            view.parameters.tagStatus = .positive
            view.parameters.value1 = 2240
            view.parameters.value3 = "08:30"
            view.parameters.value1Status = .neutral
            view.parameters.hasDivider = false
            view.parameters.hasChevron = true
            view.parameters.lineLimitLevel3 = 2
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem14: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Débito"
            view.parameters.level2 = "Blu Tap"
            view.parameters.tagTitle = "Cancelada"
            view.parameters.tagStatus = .negative
            view.parameters.value1 = 1120
            view.parameters.value3 = "08:33"
            view.parameters.value1Status = .cancelled
            view.parameters.hasDivider = false
            view.parameters.hasChevron = true
            view.parameters.lineLimitLevel3 = 2
            view.parameters.onTouch = {
                print("Touched!")
            }
        }
    }()

    public lazy var transactionListItem15: OceanSwiftUI.TransactionListItem = {
        OceanSwiftUI.TransactionListItem { view in
            view.parameters.level1 = "Débito"
            view.parameters.level2 = "Blu Tap"
            view.parameters.tagTitle = "Contestada"
            view.parameters.tagStatus = .warning
            view.parameters.value1 = 942
            view.parameters.value3 = "08:30"
            view.parameters.value1Status = .cancelled
            view.parameters.hasDivider = false
            view.parameters.hasChevron = true
            view.parameters.lineLimitLevel3 = 2
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
            transactionListItem9
            transactionListItem10
            transactionListItem11
            transactionListItem12
            transactionListItem13
            transactionListItem14
            transactionListItem15
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
