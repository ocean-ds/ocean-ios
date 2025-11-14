import Foundation
import SwiftUI
import OceanTokens

class CardBalanceSwiftUIViewController: UIViewController {

    private lazy var cardBalanceWithBlockedAcquirers: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(title: "Saldo total",
                                           value: 1000000.00,
                                           acquirers: ["Blu", "Rede", "Stone", "Getnet", "Asaas"],
                                           hasBlockedAcquirers: true)
            view.parameters.rows = [.simple(label: "Saldo atual Blu", value: 500000.00),
                                           .simple(label: "Agenda Blu", value: 500000.00),
                                    .locked(title: "Conforme você for usando mais a Blu, estas agendas ficarão disponíveis para você.", items: [("Agenda Getnet", 500000.00),
                                                                                                                                                ("Agenda Rede", 600000.00)])]
            view.parameters.footer = .init(description: "Confira todas as movimentações feitas na sua conta",
                                           ctaTitle: "Extrato")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance with blocked acquirers toggled") }
            view.parameters.footer.onCTATap = { print("Extract CTA tapped") }
        }
    }()

    private lazy var cardBalanceBlockedWithPromotion: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(title: "Saldo total",
                                           value: 2000000.00,
                                           acquirers: ["Blu", "Rede", "Stone", "Getnet", "Asaas"],
                                           hasBlockedAcquirers: true)
            view.parameters.rows = [.simple(label: "Saldo atual Blu", value: 500000.00),
                                           .simple(label: "Agenda Blu", value: 5321.45),
                                           .promotionalAnticipation(anticipation: .init(remainingTime: "00h24m00s",
                                                                                        description: "Oferta: taxa de 7,69% (era 11,06%) para antecipar sua agenda Blu — e ter dinheiro hoje.",
                                                                                        ctaTitle: "Simular antecipação",
                                                                                        onCTATap: { print("Promotional offer CTA tapped - Blu") })),
                                    .locked(title: "Conforme você for usando mais a Blu, estas agendas ficarão disponíveis para você.", items: [("Agenda Getnet", 500000.00),
                                                                                                                                                ("Agenda Rede", 600000.00)])]
            view.parameters.footer = .init(description: nil,
                                           title: "Disponível para saque",
                                           value: 500000.00,
                                           ctaTitle: "Receber")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance blocked with promotion toggled") }
            view.parameters.footer.onCTATap = { print("Receive CTA tapped") }
        }
    }()

    private lazy var cardBalanceWithPromotionWhenRemainingTimeNil: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(title: "Saldo total",
                                           value: 2000000.00,
                                           acquirers: ["Blu", "Rede", "Stone", "Getnet", "Asaas"],
                                           hasBlockedAcquirers: true)
            view.parameters.rows = [.simple(label: "Saldo atual Blu", value: 500000.00),
                                           .simple(label: "Agenda Blu", value: 5321.45),
                                           .promotionalAnticipation(anticipation: .init(description: "Oferta: taxa de 7,69% (era 11,06%) para antecipar sua agenda Blu — e ter dinheiro hoje.",
                                                                                        ctaTitle: "Simular antecipação",
                                                                                        onCTATap: { print("Promotional offer CTA tapped - Blu") })),
                                    .locked(title: "Conforme você for usando mais a Blu, estas agendas ficarão disponíveis para você.", items: [("Agenda Getnet", 500000.00),
                                                                                                                                                ("Agenda Rede", 600000.00)])]
            view.parameters.footer = .init(description: nil,
                                           title: "Disponível para saque",
                                           value: 500000.00,
                                           ctaTitle: "Receber")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance blocked with promotion toggled") }
            view.parameters.footer.onCTATap = { print("Receive CTA tapped") }
        }
    }()

    private lazy var cardBalanceDistributor: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(title: "Saldo consolidado",
                                           value: 12345.67,
                                           acquirers: ["Blu", "Rede", "Stone", "Getnet", "Asaas"])
            view.parameters.rows = [
                .simple(label: "Saldo atual Blu", value: 10765.45),
                .simple(label: "Agenda Blu",value: 5321.45),
                .promotionalAnticipation(anticipation: .init(remainingTime: "00h24m00s",
                                                             description: "Oferta: taxa de 7,69% (era 11,06%) para antecipar sua agenda Blu — e ter dinheiro hoje.",
                                                             ctaTitle: "Simular antecipação",
                                                             onCTATap: { print("Promotional offer CTA tapped - Blu") })),
                .simple(label: "Agenda Rede", value: 2234.10),
                .simple(label: "Agenda Getnet", value: 3456.78)
            ]
            view.parameters.footer = .init(description: nil,
                                           title: "Disponível para saque",
                                           value: 7890.12,
                                           ctaTitle: "Receber")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.footer.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var cardBalanceDistributor2: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(title: "Saldo consolidado",
                                           value: 12345.67,
                                           acquirers: ["Blu", "Getnet"])
            view.parameters.rows = [
                .simple(label: "Saldo atual Blu", value: 10765.45),
                .simple(label: "Agenda Blu", value: 5321.45),
                .simple(label: "Agenda Rede", value: 2234.10),
                .promotionalAnticipation(anticipation: .init(remainingTime: "00h24m00s",
                                                             description: "Oferta: taxa de 7,69% (era 11,06%) para antecipar sua agenda Blu — e ter dinheiro hoje.",
                                                             ctaTitle: "Simular antecipação",
                                                             onCTATap: { print("Promotional offer CTA tapped - Getnet") }))
            ]
            view.parameters.footer = .init(description: nil,
                                           title: "Disponível para saque",
                                           value: 7890.12,
                                           ctaTitle: "Receber")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.footer.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var cardBalanceRetailer: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: -12345.67,
                acquirers: ["Blu","Cielo", "Rede", "Stone", "Getnet"]
            )
            view.parameters.rows = [.simple(label: "Saldo atual Blu", value: -10765.45),
                                           .simple(label: "Agenda Blu", value: 5321.45),
                                           .simple(label: "Agenda Rede", value: 2234.10),
                                           .simple(label: "Agenda Getnet", value: 3456.78)]
            view.parameters.footer = .init(description: "Confira todas as movimentações feitas na sua conta",
                                           ctaTitle: "Extrato")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.footer.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var cardBalanceSkeleton: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: -12345.67,
                acquirers: ["Blu","Cielo", "Rede", "Stone", "Getnet"]
            )
            view.parameters.rows = [.simple(label: "Saldo atual Blu", value: -10765.45),
                                           .simple(label: "Agenda Blu", value: 5321.45),
                                           .simple(label: "Agenda Rede", value: 2234.10),
                                           .simple(label: "Agenda Getnet", value: 3456.78)]
            view.parameters.footer = .init(description: "Confira todas as movimentações feitas na sua conta",
                                           ctaTitle: "Extrato")
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.footer.onCTATap = { print("CTA tapped") }
            view.parameters.showSkeleton = true
        }
    }()

    private lazy var toggleShowValueButton: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.secondarySM { b in
            b.parameters.text = "Balance Show Toggle"
            b.parameters.onTouch = {
                let newValue = !(self.cardBalanceDistributor.parameters.showValue)
                
                self.cardBalanceDistributor.parameters.showValue = newValue
                self.cardBalanceDistributor2.parameters.showValue = newValue
                self.cardBalanceRetailer.parameters.showValue = newValue
                self.cardBalanceWithBlockedAcquirers.parameters.showValue = newValue
                self.cardBalanceBlockedWithPromotion.parameters.showValue = newValue
                self.cardBalanceWithPromotionWhenRemainingTimeNil.parameters.showValue = newValue
            }
        }
    }()

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {

            cardBalanceWithBlockedAcquirers

            cardBalanceBlockedWithPromotion

            cardBalanceWithPromotionWhenRemainingTimeNil

            Spacer()

            cardBalanceDistributor

            cardBalanceDistributor2

            cardBalanceRetailer

            cardBalanceSkeleton

            toggleShowValueButton
        }
    })

    private lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

@available(iOS 17.0, *)
#Preview {
    CardBalanceSwiftUIViewController()
}

