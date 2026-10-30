//
//  OceanSwiftUI+Tab.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 15/01/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Configuração do `Tab` (barra de abas com o conteúdo da aba selecionada).
    ///
    /// No Figma é o set *Tab Bar* com o item *_Tab Item*. Use para 2 a 8 seções do mesmo nível;
    /// aba indisponível não deve aparecer (não existe aba desabilitada).
    public class TabParameters: ObservableObject {
        /// Abas exibidas, na ordem. Cada uma traz título, conteúdo e contador opcional.
        @Published public var tabs: [TabModel]
        /// Índice da aba selecionada. Muda pelo toque ou por `setSelectedIndex(_:)`. Default `0`.
        @Published private(set) public var tabSelectedIndex: Int = 0
        /// Altura ideal da área de conteúdo abaixo da barra. `nil` (default) deixa o conteúdo ocupar o espaço disponível.
        @Published public var contentIdealHeight: CGFloat? = nil
        /// `false` (default): as abas dividem a largura em partes iguais; se algum título não couber,
        /// a barra passa a rolar para o lado, para o texto nunca quebrar nem ser cortado.
        /// `true`: cada aba fica do tamanho do texto e a barra rola para o lado, com `spacingStackMd` nas laterais.
        @Published public var isScrollable: Bool
        /// Chamado com o índice da aba quando a pessoa toca nela. Não é chamado por `setSelectedIndex(_:)`.
        public var onTouch: ((Int) -> Void)

        public init(tabs: [TabModel] = [],
                    tabSelectedIndex: Int = 0,
                    contentIdealHeight: CGFloat? = nil,
                    isScrollable: Bool = false,
                    onTouch: @escaping ((Int) -> Void) = { _ in }) {
            self.tabs = tabs
            self.tabSelectedIndex = tabSelectedIndex
            self.contentIdealHeight = contentIdealHeight
            self.isScrollable = isScrollable
            self.onTouch = onTouch
        }

        /// Seleciona a aba do índice informado sem chamar `onTouch`. Índice fora da lista é ignorado.
        public func setSelectedIndex(_ index: Int) {
            guard tabs.indices.contains(index) else { return }
            tabSelectedIndex = index
        }

        /// Troca a aba do índice informado. Índice fora da lista é ignorado.
        public func updateTab(tab: TabModel, index: Int) {
            guard tabs.indices.contains(index) else { return }
            tabs[index] = tab
        }

        func selectTab(tab: TabModel, index: Int) {
            tabSelectedIndex = index
            onTouch(tabSelectedIndex)
        }
    }

    /// Uma aba do `Tab` e do `ScrollableTab`.
    public class TabModel: ObservableObject, Identifiable {
        /// Título da aba, em uma linha só (estilo `heading4`). Nunca quebra nem é cortado.
        @Published public var title: String
        /// Conteúdo mostrado quando a aba está selecionada.
        @Published public var view: any View
        /// Contador ao lado do título (Badge Count Small). `nil` (default) esconde o contador.
        @Published public var badgeNumber: Int?
        /// Cor do contador na aba selecionada ou pressionada. Default `.primary` (Figma).
        /// Nas abas inativas o contador é sempre neutro (cinza), como no Figma.
        @Published public var badgeStatus: BadgeParameters.Status

        public init(title: String = "",
                    view: any View = EmptyView(),
                    badgeNumber: Int? = nil,
                    badgeStatus: BadgeParameters.Status = .primary) {
            self.title = title
            self.view = view
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
        }

        /// Conteúdo da aba como `AnyView`.
        public var contentView: AnyView {
            AnyView(view)
        }
    }

    // MARK: Metrics

    /// Medidas do Tab que não têm token de tamanho no Ocean.
    enum TabMetrics {
        /// Altura do item (Figma _Tab Item: 56). Sem token de size equivalente; literal até existir.
        static let itemHeight: CGFloat = 56
        /// Altura da linha de seleção (Figma: 2). Sem token de size equivalente; literal até existir.
        static let indicatorHeight: CGFloat = 2
        /// Altura da linha de baixo da barra (Figma Divider: 1), igual ao default do `OceanSwiftUI.Divider`.
        static let dividerHeight: CGFloat = 1
        /// Altura total da barra: item + linha de baixo.
        static var barHeight: CGFloat { itemHeight + dividerHeight }

        /// No modo fixo as abas dividem a largura em partes iguais. Decide se todas cabem na sua parte
        /// sem cortar o texto; se alguma não couber, a barra usa o layout com rolagem.
        static func fitsEqually(itemWidths: [CGFloat], availableWidth: CGFloat) -> Bool {
            guard !itemWidths.isEmpty, availableWidth > 0 else { return true }
            let slot = availableWidth / CGFloat(itemWidths.count)
            return itemWidths.allSatisfy { $0 <= slot + 0.5 }
        }

        /// Cor do texto: azul na aba selecionada ou pressionada (Figma "Hover" no app), cinza nas outras.
        static func labelColor(isSelected: Bool, isPressed: Bool) -> UIColor {
            isSelected || isPressed ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkUp
        }

        /// Status do contador: o da aba (`badgeStatus`) quando selecionada ou pressionada; neutro nas outras.
        /// O neutro do Figma (fundo `colorInterfaceDarkUp`, texto `colorInterfaceLightUp`) é o `.disabled` do Badge.
        static func badgeStatus(_ status: BadgeParameters.Status,
                                isSelected: Bool,
                                isPressed: Bool) -> BadgeParameters.Status {
            isSelected || isPressed ? status : .disabled
        }

        /// Rótulo de acessibilidade: título e, se houver, o contador.
        static func accessibilityLabel(title: String, badgeNumber: Int?) -> String {
            guard let badgeNumber else { return title }
            return "\(title), \(badgeNumber)"
        }
    }

    // MARK: Item

    /// Item da barra (Figma _Tab Item), usado pelo `Tab` e pelo `ScrollableTab`.
    struct TabItem: View {
        let title: String
        let badgeNumber: Int?
        let badgeStatus: BadgeParameters.Status
        let isSelected: Bool
        var fillsWidth: Bool = false
        let action: () -> Void

        var body: some View {
            SwiftUI.Button(action: action) {
                TabItemLabel(title: title,
                             badgeNumber: badgeNumber,
                             badgeStatus: badgeStatus,
                             isSelected: isSelected)
            }
            .buttonStyle(TabItemPressStyle())
            .frame(maxWidth: fillsWidth ? .infinity : nil)
            .frame(height: TabMetrics.itemHeight)
            .overlay(Color(isSelected ? Ocean.color.colorBrandPrimaryPure : .clear)
                        .frame(height: TabMetrics.indicatorHeight),
                     alignment: .bottom)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(TabMetrics.accessibilityLabel(title: title, badgeNumber: badgeNumber))
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
        }
    }

    /// Conteúdo do item: texto e contador. Lê o estado pressionado do `TabItemPressStyle`.
    struct TabItemLabel: View {
        let title: String
        let badgeNumber: Int?
        let badgeStatus: BadgeParameters.Status
        let isSelected: Bool

        @Environment(\.oceanTabItemIsPressed) private var isPressed

        var body: some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                OceanSwiftUI.Typography.heading4 { view in
                    view.parameters.text = title
                    view.parameters.lineLimit = 1
                    view.parameters.textColor = TabMetrics.labelColor(isSelected: isSelected, isPressed: isPressed)
                }

                if let badgeNumber {
                    OceanSwiftUI.Badge { badge in
                        badge.parameters.count = badgeNumber
                        badge.parameters.status = TabMetrics.badgeStatus(badgeStatus,
                                                                         isSelected: isSelected,
                                                                         isPressed: isPressed)
                        badge.parameters.size = .small
                    }
                }
            }
            .fixedSize(horizontal: true, vertical: false)
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
    }

    /// Estado pressionado (Figma "Hover" no app): repassa `isPressed` para o conteúdo do item.
    struct TabItemPressStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .environment(\.oceanTabItemIsPressed, configuration.isPressed)
        }
    }

    public struct Tab: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Tab) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TabParameters

        // MARK: Properties private

        @State private var itemWidths: [Int: CGFloat] = [:]
        @State private var availableWidth: CGFloat = 0

        private var fixedLayoutFits: Bool {
            let widths = parameters.tabs.indices.compactMap { itemWidths[$0] }
            guard widths.count == parameters.tabs.count else { return true }
            return TabMetrics.fitsEqually(itemWidths: widths, availableWidth: availableWidth)
        }

        // MARK: Constructors

        public init(parameters: TabParameters = TabParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            // O espaçamento padrão entre a barra e o conteúdo é mantido para não mover o conteúdo das telas no ar.
            VStack {
                VStack(spacing: 0) {
                    if parameters.isScrollable || !fixedLayoutFits {
                        getScrollTabs()
                    } else {
                        getTabs()
                    }

                    OceanSwiftUI.Divider()
                }
                .background(Color(Ocean.color.colorInterfaceLightPure))
                .background(measurer)

                getContent()
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, idealHeight: self.parameters.contentIdealHeight, maxHeight: .infinity)
            }
        }

        // MARK: Methods private

        /// Mede, sem desenhar, a largura natural de cada item e a largura da barra,
        /// para decidir entre o layout fixo e o com rolagem.
        @ViewBuilder
        private var measurer: some View {
            if !parameters.isScrollable {
                GeometryReader { proxy in
                    HStack(spacing: 0) {
                        ForEach(0..<self.parameters.tabs.count, id: \.self) { index in
                            let tab = self.parameters.tabs[index]
                            TabItemLabel(title: tab.title,
                                         badgeNumber: tab.badgeNumber,
                                         badgeStatus: tab.badgeStatus,
                                         isSelected: false)
                                .fixedSize()
                                .background(GeometryReader { item in
                                    Color.clear.preference(key: TabItemWidthsKey.self,
                                                           value: [index: item.size.width])
                                })
                        }
                    }
                    .hidden()
                    .preference(key: TabBarWidthKey.self, value: proxy.size.width)
                }
                .accessibilityHidden(true)
                .onPreferenceChange(TabItemWidthsKey.self) { itemWidths = $0 }
                .onPreferenceChange(TabBarWidthKey.self) { availableWidth = $0 }
            }
        }

        @ViewBuilder
        private func getScrollTabs() -> some View {
            ScrollViewReader { scrollReader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<self.parameters.tabs.count, id: \.self) { index in
                            getTab(self.parameters.tabs[index], index: index, fillsWidth: false)
                                .id(index)
                                .onChange(of: parameters.tabSelectedIndex) { newValue in
                                    withAnimation {
                                        scrollReader.scrollTo(newValue, anchor: .center)
                                    }
                                }
                                .onAppear {
                                    if parameters.tabSelectedIndex != 0 {
                                        withAnimation {
                                            scrollReader.scrollTo(parameters.tabSelectedIndex, anchor: .center)
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, Ocean.size.spacingStackMd)
                }
            }
        }

        private func getTabs() -> some View {
            HStack(spacing: 0) {
                ForEach(0..<self.parameters.tabs.count, id: \.self) { index in
                    getTab(self.parameters.tabs[index], index: index, fillsWidth: true)
                }
            }
        }

        private func getTab(_ tab: TabModel, index: Int, fillsWidth: Bool) -> some View {
            TabItem(title: tab.title,
                    badgeNumber: tab.badgeNumber,
                    badgeStatus: tab.badgeStatus,
                    isSelected: parameters.tabSelectedIndex == index,
                    fillsWidth: fillsWidth) {
                parameters.selectTab(tab: tab, index: index)
            }
            .animation(.default, value: parameters.tabSelectedIndex)
        }

        private func getContent() -> some View {
            Group {
                if let tab = parameters.tabs[safe: parameters.tabSelectedIndex] {
                    tab.contentView
                }
            }
        }
    }
}

// MARK: - Support

private struct OceanTabItemIsPressedKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var oceanTabItemIsPressed: Bool {
        get { self[OceanTabItemIsPressedKey.self] }
        set { self[OceanTabItemIsPressedKey.self] = newValue }
    }
}

private struct TabItemWidthsKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]

    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { _, new in new }
    }
}

private struct TabBarWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
