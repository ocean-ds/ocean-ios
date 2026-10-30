//
//  TabSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 16/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens
import OceanComponents

class TabSwiftUIViewController: UIViewController {

    private static var badgeNumber: Int = 0

    lazy var tabContentView: any View = {
        ScrollView {
            VStack(alignment: .center) {
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Voltar para inicio"
                    button.parameters.onTouch = {
                        self.customTab.parameters.setSelectedIndex(0)
                    }
                }
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Alterar titulo da Aba 1"
                    button.parameters.onTouch = self.updateTab
                }
            }
            .padding()
        }
    }()

    lazy var customTab: OceanSwiftUI.Tab = {
        OceanSwiftUI.Tab { tab in
            tab.parameters.tabs = [
                .init(title: "Aba 1",
                      view: getTextview("Aba 1")),
                .init(title: "Aba 2",
                      view: getTextview("Aba 2")),
                .init(title: "Aba 3",
                      view: getTextview("Aba 3")),
                .init(title: "Aba 4",
                      view: getTextview("Aba 4")),
                .init(title: "Titulo Grande Titulo",
                      view: tabContentView,
                      badgeNumber: 10),
            ]
            tab.parameters.setSelectedIndex(4)
            tab.parameters.isScrollable = true
            tab.parameters.contentIdealHeight = 220
            tab.parameters.onTouch = tabSelected
        }
    }()

    private lazy var fixedTwoTabs = makeTab(titles: ["Recebidos", "Enviados"], isScrollable: false)

    private lazy var fixedThreeTabs = makeTab(titles: ["Todas", "Abertas", "Pagas"], isScrollable: false)

    private lazy var fixedWithBadge = makeTab(titles: ["Pendentes", "Concluídas", "Canceladas"],
                                              isScrollable: false,
                                              badges: [3, nil, 12])

    private lazy var fixedLongLabel = makeTab(titles: ["Resumo", "Lançamentos futuros detalhados", "Extrato"],
                                              isScrollable: false)

    private lazy var scrollableFiveTabs = makeTab(titles: ["Aba 1", "Aba 2", "Aba 3", "Aba 4", "Aba 5"],
                                                  isScrollable: true)

    private lazy var scrollableWithBadge = makeTab(titles: ["Pendentes", "Concluídas", "Canceladas", "Estornadas", "Em análise"],
                                                   isScrollable: true,
                                                   badges: [3, 120, nil, 1, nil])

    private lazy var catalog = AnyView(ScrollView {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackSm) {
            section("isScrollable: false · 2 abas", fixedTwoTabs)
            section("isScrollable: false · 3 abas", fixedThreeTabs)
            section("isScrollable: false · badgeNumber: 3, nil, 12", fixedWithBadge)
            section("isScrollable: false · título longo (não cabe: a barra rola)", fixedLongLabel)
            section("isScrollable: true · 5 abas", scrollableFiveTabs)
            section("isScrollable: true · badgeNumber: 3, 120, nil, 1, nil", scrollableWithBadge)
            section("isScrollable: true · interativo (onTouch, setSelectedIndex, updateTab)", customTab)
        }
        .padding(.vertical, Ocean.size.spacingStackXs)
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

    private func makeTab(titles: [String], isScrollable: Bool, badges: [Int?] = []) -> OceanSwiftUI.Tab {
        OceanSwiftUI.Tab { tab in
            tab.parameters.tabs = titles.enumerated().map { index, title in
                .init(title: title,
                      view: self.getCaption("Conteúdo de \(title)"),
                      badgeNumber: badges.indices.contains(index) ? badges[index] : nil)
            }
            tab.parameters.isScrollable = isScrollable
            tab.parameters.contentIdealHeight = 48
            tab.parameters.onTouch = self.tabSelected
        }
    }

    private func section(_ label: String, _ tab: OceanSwiftUI.Tab) -> some View {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
            OceanSwiftUI.Typography.caption { view in
                view.parameters.text = label
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)

            tab
        }
    }

    private func getCaption(_ text: String) -> some View {
        OceanSwiftUI.Typography.description { label in
            label.parameters.text = text
        }
        .padding(.horizontal, Ocean.size.spacingStackXs)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func tabSelected(_ tab: Int) {
        print("QWERT: Tab selecionada: \(tab)")
    }

    private func updateTab() {
        TabSwiftUIViewController.badgeNumber += 1
        self.customTab.parameters.updateTab(
            tab: .init(title: "Atualizada",
                       view: getTextview("0000"),
                       badgeNumber: TabSwiftUIViewController.badgeNumber,
                       badgeStatus: .highlight),
            index: 1)
    }

    private func getTextview(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
            OceanSwiftUI.Typography.heading2 { label in
                label.parameters.text = text
            }

            OceanSwiftUI.Typography.description { label in
                label.parameters.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \nwhen an unknown printer took a galley of type and scrambled it to make a type specimen book."
                label.parameters.multilineTextAlignment = .leading
            }
        }
        .padding(Ocean.size.spacingStackXs)
    }
}

@available(iOS 13.0, *)
struct TabSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TabSwiftUIViewController()
        }
    }
}
