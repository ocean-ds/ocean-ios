import Foundation
import SwiftUI
import OceanTokens

class CardBalanceSwiftUIViewController: UIViewController {

    private lazy var cardBalanceDistributor: OceanSwiftUI.CardBalance = {
        OceanSwiftUI.CardBalance { view in
            view.parameters.context = .distributor
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: 12345.67,
                showValue: true,
                acquirers: ["Cielo", "Rede", "Stone", "Getnet"]
            )
            view.parameters.balanceRows = [
                .init(label: "Cielo", value: 5321.45),
                .init(label: "Rede", value: 2234.10),
                .init(label: "Stone", value: 3456.78)
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
            view.parameters.context = .retailer
            view.parameters.header = .init(
                title: "Saldo consolidado",
                value: 12345.67,
                showValue: true,
                acquirers: ["Cielo", "Rede", "Stone", "Getnet"]
            )
            view.parameters.balanceRows = [
                .init(label: "Cielo", value: 5321.45),
                .init(label: "Rede", value: 2234.10),
                .init(label: "Stone", value: 3456.78)
            ]
            view.parameters.footer = .init(
                description: "Confira todas as movimentações feitas na sua conta",
                title: "Confira todas as movimentações feitas na sua conta",
                ctaTitle: "Extrato"
            )
            view.parameters.state = .collapsed
            view.parameters.onToggle = { print("CardBalance toggled") }
            view.parameters.onCTATap = { print("CTA tapped") }
        }
    }()

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {
            Spacer()

            cardBalanceDistributor

            cardBalanceRetailer
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
