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

        // MARK: Motion (igual ao web aprovado no MR-980)

        /// Distância mínima da borda visível da barra para a aba selecionada não pedir rolagem.
        static let scrollEdgeMargin: CGFloat = 24

        /// Linha de seleção deslizando entre as abas: 0,30s, curva (0.65, 0, 0.35, 1). `nil` com Reduzir movimento.
        static func indicatorAnimation(reduceMotion: Bool) -> Animation? {
            reduceMotion ? nil : .timingCurve(0.65, 0, 0.35, 1, duration: 0.30)
        }

        /// Troca de cor do texto e do contador: 0,15s easeInOut. `nil` com Reduzir movimento.
        static func colorAnimation(reduceMotion: Bool) -> Animation? {
            reduceMotion ? nil : .easeInOut(duration: 0.15)
        }

        /// Rolagem da barra até a aba selecionada: 0,40s, curva (0.65, 0, 0.35, 1). `nil` com Reduzir movimento.
        static func scrollAnimation(reduceMotion: Bool) -> Animation? {
            reduceMotion ? nil : .timingCurve(0.65, 0, 0.35, 1, duration: 0.40)
        }

        /// A barra só rola quando a aba selecionada não está toda visível ou está a menos de
        /// `scrollEdgeMargin` de uma borda. `itemFrame` está no espaço da área visível da barra;
        /// sem medida, rola (para nunca deixar a aba selecionada fora da tela).
        static func needsScroll(itemFrame: CGRect?,
                                viewportWidth: CGFloat,
                                edgeMargin: CGFloat = scrollEdgeMargin) -> Bool {
            guard let itemFrame, viewportWidth > 0 else { return true }
            return itemFrame.minX < edgeMargin || itemFrame.maxX > viewportWidth - edgeMargin
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
        /// Posição na barra: identifica o item para a linha de seleção e para a rolagem.
        var index: Int = 0
        /// Espaço de coordenadas da área visível da barra com rolagem; `nil` não mede.
        var viewportSpace: String? = nil
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
            .anchorPreference(key: TabItemBoundsKey.self, value: .bounds) { [index: $0] }
            .background(viewportReporter)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(TabMetrics.accessibilityLabel(title: title, badgeNumber: badgeNumber))
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
        }

        @ViewBuilder
        private var viewportReporter: some View {
            if let viewportSpace {
                GeometryReader { proxy in
                    Color.clear.preference(key: TabItemFramesKey.self,
                                           value: [index: proxy.frame(in: .named(viewportSpace))])
                }
            }
        }
    }

    /// Linha de seleção única da barra: acompanha a posição e a largura da aba selecionada e
    /// desliza entre as abas (não some e reaparece).
    struct TabIndicatorOverlay: ViewModifier {
        let selectedIndex: Int
        let reduceMotion: Bool

        func body(content: Content) -> some View {
            content.overlayPreferenceValue(TabItemBoundsKey.self) { bounds in
                GeometryReader { proxy in
                    if let anchor = bounds[selectedIndex] {
                        let rect = proxy[anchor]
                        Color(Ocean.color.colorBrandPrimaryPure)
                            .frame(width: rect.width, height: TabMetrics.indicatorHeight)
                            .offset(x: rect.minX, y: rect.maxY - TabMetrics.indicatorHeight)
                    }
                }
                .animation(TabMetrics.indicatorAnimation(reduceMotion: reduceMotion), value: selectedIndex)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
            }
        }
    }

    /// Medidas da área visível de uma barra com rolagem. É uma referência (não `@Published`) para
    /// a rolagem do conteúdo não redesenhar a barra a cada quadro.
    final class TabBarViewport {
        var itemFrames: [Int: CGRect] = [:]
        var width: CGFloat = 0

        func needsScroll(to index: Int) -> Bool {
            TabMetrics.needsScroll(itemFrame: itemFrames[index], viewportWidth: width)
        }
    }

    /// Conteúdo do item: texto e contador. Lê o estado pressionado do `TabItemPressStyle`.
    struct TabItemLabel: View {
        let title: String
        let badgeNumber: Int?
        let badgeStatus: BadgeParameters.Status
        let isSelected: Bool

        @Environment(\.oceanTabItemIsPressed) private var isPressed
        @Environment(\.accessibilityReduceMotion) private var reduceMotion

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
            .animation(TabMetrics.colorAnimation(reduceMotion: reduceMotion), value: isSelected)
            .animation(TabMetrics.colorAnimation(reduceMotion: reduceMotion), value: isPressed)
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
        @State private var viewport = TabBarViewport()
        @Environment(\.accessibilityReduceMotion) private var reduceMotion

        private let viewportSpace = "OceanSwiftUI.Tab.viewport"

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
                        }
                    }
                    .modifier(TabIndicatorOverlay(selectedIndex: parameters.tabSelectedIndex,
                                                  reduceMotion: reduceMotion))
                    .padding(.horizontal, Ocean.size.spacingStackMd)
                }
                .coordinateSpace(name: viewportSpace)
                .background(GeometryReader { proxy in
                    Color.clear.preference(key: TabViewportWidthKey.self, value: proxy.size.width)
                })
                .onPreferenceChange(TabItemFramesKey.self) { viewport.itemFrames = $0 }
                .onPreferenceChange(TabViewportWidthKey.self) { viewport.width = $0 }
                .onChange(of: parameters.tabSelectedIndex) { newValue in
                    guard viewport.needsScroll(to: newValue) else { return }
                    withAnimation(TabMetrics.scrollAnimation(reduceMotion: reduceMotion)) {
                        scrollReader.scrollTo(newValue, anchor: .center)
                    }
                }
                .onAppear {
                    // Aparição inicial sem animação.
                    if parameters.tabSelectedIndex != 0 {
                        scrollReader.scrollTo(parameters.tabSelectedIndex, anchor: .center)
                    }
                }
            }
        }

        private func getTabs() -> some View {
            HStack(spacing: 0) {
                ForEach(0..<self.parameters.tabs.count, id: \.self) { index in
                    getTab(self.parameters.tabs[index], index: index, fillsWidth: true)
                }
            }
            .modifier(TabIndicatorOverlay(selectedIndex: parameters.tabSelectedIndex,
                                          reduceMotion: reduceMotion))
        }

        private func getTab(_ tab: TabModel, index: Int, fillsWidth: Bool) -> some View {
            TabItem(title: tab.title,
                    badgeNumber: tab.badgeNumber,
                    badgeStatus: tab.badgeStatus,
                    isSelected: parameters.tabSelectedIndex == index,
                    fillsWidth: fillsWidth,
                    index: index,
                    viewportSpace: fillsWidth ? nil : viewportSpace) {
                parameters.selectTab(tab: tab, index: index)
            }
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

struct TabItemBoundsKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGRect>] = [:]

    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue()) { _, new in new }
    }
}

struct TabItemFramesKey: PreferenceKey {
    static var defaultValue: [Int: CGRect] = [:]

    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue()) { _, new in new }
    }
}

struct TabViewportWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct TabBarWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
