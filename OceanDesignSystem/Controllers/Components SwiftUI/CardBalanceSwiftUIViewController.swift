import Foundation
import SwiftUI
import OceanTokens

class CardBalanceSwiftUIViewController: UIViewController {

    private lazy var cardBalanceDistributor: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: 12345.67,
                showValue: true,
                acquirers: ["Blu", "Rede", "Stone", "Getnet", "Asaas"]
            )
            view.parameters.balanceRows = [
                .init(label: "Saldo atual na Blu", value: 10765.45),
                .init(label: "Agenda na Blu", value: 5321.45),
                .init(label: "Agenda na Rede", value: 2234.10),
                .init(label: "Agenda na Getnet", value: 3456.78)
            ]
            view.parameters.footer = .init(
                description: nil,
                title: "Disponível para saque",
                value: 7890.12,
                ctaTitle: "Receber"
            )
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var cardBalanceDistributor2: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: 12345.67,
                showValue: true,
                acquirers: ["Blu", "Getnet"]
            )
            view.parameters.balanceRows = [
                .init(label: "Saldo atual na Blu", value: 10765.45),
                .init(label: "Agenda na Blu", value: 5321.45),
                .init(label: "Agenda na Rede", value: 2234.10),
                .init(label: "Agenda na Getnet", value: 3456.78)
            ]
            view.parameters.footer = .init(
                description: nil,
                title: "Disponível para saque",
                value: 7890.12,
                ctaTitle: "Receber"
            )
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var cardBalanceRetailer: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: 12345.67,
                showValue: true,
                acquirers: ["Cielo", "Rede", "Stone", "Getnet"]
            )
            view.parameters.balanceRows = [
                .init(label: "Saldo atual na Blu", value: 10765.45),
                .init(label: "Agenda na Blu", value: 5321.45),
                .init(label: "Agenda na Rede", value: 2234.10),
                .init(label: "Agenda na Getnet", value: 3456.78)
            ]
            view.parameters.footer = .init(
                description: "Confira todas as movimentações feitas na sua conta",
                ctaTitle: "Extrato"
            )
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var toggleShowValueButton: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.secondarySM { b in
            b.parameters.text = "Balance Show Toggle"
            b.parameters.onTouch = {
                let newValue = !(self.cardBalanceDistributor.parameters.header.showValue)

                self.cardBalanceDistributor.parameters.header = .init(
                    title: self.cardBalanceDistributor.parameters.header.title,
                    value: self.cardBalanceDistributor.parameters.header.value,
                    showValue: newValue,
                    acquirers: self.cardBalanceDistributor.parameters.header.acquirers
                )
                self.cardBalanceDistributor2.parameters.header = .init(
                    title: self.cardBalanceDistributor2.parameters.header.title,
                    value: self.cardBalanceDistributor2.parameters.header.value,
                    showValue: newValue,
                    acquirers: self.cardBalanceDistributor2.parameters.header.acquirers
                )
                self.cardBalanceRetailer.parameters.header = .init(
                    title: self.cardBalanceRetailer.parameters.header.title,
                    value: self.cardBalanceRetailer.parameters.header.value,
                    showValue: newValue,
                    acquirers: self.cardBalanceRetailer.parameters.header.acquirers
                )
            }
        }
    }()

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {
            Spacer()

            cardBalanceDistributor

            cardBalanceDistributor2

            cardBalanceRetailer

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

