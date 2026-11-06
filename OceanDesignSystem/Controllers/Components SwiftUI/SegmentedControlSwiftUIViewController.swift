//
//  SegmentedControlSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens
import OceanComponents

class SegmentedControlSwiftUIViewController: UIViewController {

    private typealias Option = OceanSwiftUI.SegmentedControlOptionModel

    private lazy var firstSelected = makeControl([Option(title: "Opção 1"), Option(title: "Opção 2")],
                                                 selectedIndex: 0)

    private lazy var secondSelected = makeControl([Option(title: "Opção 1"), Option(title: "Opção 2")],
                                                  selectedIndex: 1)

    private lazy var withIcon = makeControl([Option(title: "Lista", icon: Ocean.icon.viewListOutline),
                                             Option(title: "Grade", icon: Ocean.icon.viewGridOutline)])

    private lazy var withBadge = makeControl([Option(title: "Pendentes", badgeNumber: 3),
                                              Option(title: "Concluídas", badgeNumber: 120)])

    private lazy var withIconAndBadge = makeControl([Option(title: "Loja", icon: Ocean.icon.shoppingBagOutline, badgeNumber: 2),
                                                     Option(title: "Rede", icon: Ocean.icon.officeBuildingOutline)])

    private lazy var longLabel = makeControl([Option(title: "Lançamentos futuros detalhados por loja e por período"),
                                              Option(title: "Rede")])

    private lazy var storeNetwork = makeControl([Option(title: "Loja"), Option(title: "Rede")],
                                                onTouch: { [weak self] index in
                                                    self?.storeNetworkContent.parameters.text = Self.storeNetworkText(index)
                                                })

    private lazy var storeNetworkContent = OceanSwiftUI.Typography.description { label in
        label.parameters.text = Self.storeNetworkText(0)
    }

    private lazy var catalog = AnyView(ScrollView {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackSm) {
            section("selectedIndex: 0 · icon: nil · badgeNumber: nil", firstSelected)
            section("selectedIndex: 1", secondSelected)
            section("icon: viewListOutline | viewGridOutline", withIcon)
            section("badgeNumber: 3 | 120 (99+)", withBadge)
            section("icon + badgeNumber: 2 | icon + badgeNumber: nil", withIconAndBadge)
            section("title: longo (uma linha, corta com …)", longLabel)
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                section("exemplo: Loja | Rede (onTouch troca o conteúdo)", storeNetwork)
                storeNetworkContent
                    .padding(.horizontal, Ocean.size.spacingStackXs)
            }
        }
        .padding(.vertical, Ocean.size.spacingStackXs)
        .frame(maxWidth: .infinity, alignment: .leading)
    })

    public lazy var hostingController = UIHostingController(rootView: catalog)

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }

    private func makeControl(_ options: [Option],
                             selectedIndex: Int = 0,
                             onTouch: ((Int) -> Void)? = nil) -> OceanSwiftUI.SegmentedControl {
        OceanSwiftUI.SegmentedControl { control in
            control.parameters.options = options
            control.parameters.setSelectedIndex(selectedIndex)
            control.parameters.onTouch = onTouch ?? { index in
                print("SegmentedControl: opção selecionada \(index)")
            }
        }
    }

    private func section(_ label: String, _ control: OceanSwiftUI.SegmentedControl) -> some View {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
            OceanSwiftUI.Typography.caption { view in
                view.parameters.text = label
            }

            control
        }
        .padding(.horizontal, Ocean.size.spacingStackXs)
    }

    private static func storeNetworkText(_ index: Int) -> String {
        index == 0 ? "Vendas desta loja." : "Vendas de todas as lojas da rede."
    }
}

@available(iOS 13.0, *)
struct SegmentedControlSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SegmentedControlSwiftUIViewController()
        }
    }
}
