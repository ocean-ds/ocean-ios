//
//  OceanSwiftUI+SegmentedControl.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Configuração do `SegmentedControl` (controle com duas opções, uma sempre selecionada).
    ///
    /// No Figma é o set *Segmented Control* (MR-990). Use para trocar o escopo ou a visão do mesmo
    /// conteúdo (ex.: Loja | Rede). Não é aba (`Tab`), filtro (`FilterBar`) nem liga/desliga (`Switch`).
    /// O controle desenha **exatamente 2 opções**: só as duas primeiras de `options` aparecem; com menos de
    /// duas, aparecem as que existirem. Não existe estado desabilitado nem carregando: se a troca não está
    /// disponível, a tela não mostra o controle.
    public class SegmentedControlParameters: ObservableObject {
        /// As opções do controle, na ordem. Só as duas primeiras são desenhadas. Default `[]`.
        @Published public var options: [SegmentedControlOptionModel]
        /// Índice da opção selecionada (`0` ou `1`). Muda pelo toque ou por `setSelectedIndex(_:)`. Default `0`.
        @Published private(set) public var selectedIndex: Int
        /// Chamado com o índice da opção quando a pessoa toca numa opção diferente da selecionada.
        /// Não é chamado ao tocar na opção já selecionada nem por `setSelectedIndex(_:)`.
        public var onTouch: ((Int) -> Void)

        public init(options: [SegmentedControlOptionModel] = [],
                    selectedIndex: Int = 0,
                    onTouch: @escaping ((Int) -> Void) = { _ in }) {
            self.options = options
            self.selectedIndex = SegmentedControlMetrics.isValid(index: selectedIndex,
                                                                 optionsCount: options.count) ? selectedIndex : 0
            self.onTouch = onTouch
        }

        /// Opções desenhadas na tela: as duas primeiras de `options`.
        public var visibleOptions: [SegmentedControlOptionModel] {
            Array(options.prefix(SegmentedControlMetrics.maxOptions))
        }

        /// Seleciona a opção do índice informado sem chamar `onTouch`.
        /// Índice fora das opções desenhadas é ignorado.
        public func setSelectedIndex(_ index: Int) {
            guard SegmentedControlMetrics.isValid(index: index, optionsCount: options.count) else { return }
            selectedIndex = index
        }

        /// Toque numa opção: seleciona e chama `onTouch`. Índice fora das opções desenhadas é ignorado, e tocar na
        /// opção que já está selecionada não chama `onTouch` (nada mudou), como na web e no Android.
        func select(index: Int) {
            guard SegmentedControlMetrics.isValid(index: index, optionsCount: options.count),
                  index != selectedIndex else { return }
            selectedIndex = index
            onTouch(index)
        }
    }

    /// Uma opção do `SegmentedControl`.
    public struct SegmentedControlOptionModel: Equatable {
        /// Texto da opção (estilo `heading5`), em uma linha só; se não couber, é cortado com "…".
        public var title: String
        /// Ícone 16×16 antes do texto, na cor `colorBrandPrimaryPure`. `nil` (default) esconde o ícone.
        public var icon: UIImage?
        /// Contador depois do texto (Badge Count Small, status `.primary`). `nil` (default) esconde o contador.
        public var badgeNumber: Int?

        public init(title: String = "",
                    icon: UIImage? = nil,
                    badgeNumber: Int? = nil) {
            self.title = title
            self.icon = icon
            self.badgeNumber = badgeNumber
        }
    }

    // MARK: Metrics

    /// Medidas, cores e movimento do SegmentedControl (Figma MR-990).
    enum SegmentedControlMetrics {
        /// O controle desenha exatamente duas opções.
        static let maxOptions = 2

        /// Altura da opção (Figma: 32). Sem token de size equivalente; literal até existir.
        static let optionHeight: CGFloat = 32
        /// Ícone da opção (Figma: 16×16). Sem token de size de ícone; literal, como o `Button` small.
        static let iconSize: CGFloat = 16
        /// Padding do controle em volta das opções (Figma: 4).
        static let containerPadding: CGFloat = Ocean.size.spacingInsetXxs
        /// Espaço entre as duas opções (Figma: 4).
        static let optionsSpacing: CGFloat = Ocean.size.spacingInlineXxxs
        /// Padding horizontal da opção (Figma: 12).
        static let optionHorizontalPadding: CGFloat = Ocean.size.spacingInlineXxsExtra
        /// Padding vertical da opção (Figma: 4).
        static let optionVerticalPadding: CGFloat = Ocean.size.spacingInsetXxs
        /// Espaço entre ícone, texto e contador (Figma: 4).
        static let contentSpacing: CGFloat = Ocean.size.spacingInlineXxxs
        /// Borda do controle (Figma: 1).
        static let borderWidth: CGFloat = Ocean.size.borderWidthHairline
        /// Altura total do controle: opção + padding em cima e embaixo (Figma: 40).
        static var controlHeight: CGFloat { optionHeight + 2 * containerPadding }

        /// Raio circular (`borderRadiusCircular` é a fração da altura).
        static func cornerRadius(height: CGFloat) -> CGFloat {
            height * Ocean.size.borderRadiusCircular
        }

        /// O índice está entre as opções desenhadas.
        static func isValid(index: Int, optionsCount: Int) -> Bool {
            index >= 0 && index < min(optionsCount, maxOptions)
        }

        /// Fundo do controle: `colorInterfaceLightUp` pressionado (Figma "Hover" no app), `colorInterfaceLightPure` no padrão.
        static func containerColor(isPressed: Bool) -> UIColor {
            isPressed ? Ocean.color.colorInterfaceLightUp : Ocean.color.colorInterfaceLightPure
        }

        /// Opacidade do fundo de seleção (`colorBrandPrimaryUp`): 48% pressionado, 32% no padrão.
        static func selectionOpacity(isPressed: Bool) -> Double {
            isPressed ? 0.48 : 0.32
        }

        // MARK: Motion (mesma curva da linha de seleção do Tab)

        /// Fundo de seleção deslizando entre as opções: 0,30s, curva (0.65, 0, 0.35, 1). `nil` com Reduzir movimento.
        static func selectionAnimation(reduceMotion: Bool) -> Animation? {
            reduceMotion ? nil : .timingCurve(0.65, 0, 0.35, 1, duration: 0.30)
        }

        /// Troca de cor do fundo do controle e da seleção: 0,15s easeInOut. `nil` com Reduzir movimento.
        static func colorAnimation(reduceMotion: Bool) -> Animation? {
            reduceMotion ? nil : .easeInOut(duration: 0.15)
        }

        /// Rótulo de acessibilidade: texto e, se houver, o contador.
        static func accessibilityLabel(title: String, badgeNumber: Int?) -> String {
            guard let badgeNumber else { return title }
            return "\(title), \(badgeNumber)"
        }
    }

    // MARK: Option

    /// Conteúdo da opção: ícone, texto e contador.
    struct SegmentedControlOptionLabel: View {
        let option: SegmentedControlOptionModel

        var body: some View {
            HStack(spacing: SegmentedControlMetrics.contentSpacing) {
                if let icon = option.icon {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(Ocean.color.colorBrandPrimaryPure))
                        .frame(width: SegmentedControlMetrics.iconSize,
                               height: SegmentedControlMetrics.iconSize)
                }

                OceanSwiftUI.Typography.heading5 { view in
                    view.parameters.text = option.title
                    view.parameters.lineLimit = 1
                    view.parameters.textColor = Ocean.color.colorBrandPrimaryPure
                }
                .truncationMode(.tail)
                .layoutPriority(-1)

                if let badgeNumber = option.badgeNumber {
                    OceanSwiftUI.Badge { badge in
                        badge.parameters.count = badgeNumber
                        badge.parameters.status = .primary
                        badge.parameters.size = .small
                    }
                    .fixedSize()
                }
            }
            .padding(.horizontal, SegmentedControlMetrics.optionHorizontalPadding)
            .padding(.vertical, SegmentedControlMetrics.optionVerticalPadding)
            .frame(height: SegmentedControlMetrics.optionHeight)
            .contentShape(Rectangle())
        }
    }

    /// Uma opção do controle, como botão.
    struct SegmentedControlOption: View {
        let option: SegmentedControlOptionModel
        let index: Int
        let isSelected: Bool
        let action: () -> Void

        var body: some View {
            SwiftUI.Button(action: action) {
                SegmentedControlOptionLabel(option: option)
            }
            .buttonStyle(SegmentedControlPressStyle())
            .anchorPreference(key: SegmentedControlOptionBoundsKey.self, value: .bounds) { [index: $0] }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(SegmentedControlMetrics.accessibilityLabel(title: option.title,
                                                                           badgeNumber: option.badgeNumber))
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
        }
    }

    /// Estado pressionado (Figma "Hover" no app): avisa o controle, que muda o fundo e a seleção inteiros.
    struct SegmentedControlPressStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .preference(key: SegmentedControlIsPressedKey.self, value: configuration.isPressed)
        }
    }

    /// Fundo de seleção único: acompanha a posição e a largura da opção selecionada e
    /// desliza entre as opções (não some e reaparece).
    struct SegmentedControlSelectionBackground: ViewModifier {
        let selectedIndex: Int
        let isPressed: Bool
        let reduceMotion: Bool

        func body(content: Content) -> some View {
            content.backgroundPreferenceValue(SegmentedControlOptionBoundsKey.self) { bounds in
                GeometryReader { proxy in
                    if let anchor = bounds[selectedIndex] {
                        let rect = proxy[anchor]
                        RoundedRectangle(cornerRadius: SegmentedControlMetrics.cornerRadius(height: rect.height))
                            .fill(Color(Ocean.color.colorBrandPrimaryUp)
                                .opacity(SegmentedControlMetrics.selectionOpacity(isPressed: isPressed)))
                            .animation(SegmentedControlMetrics.colorAnimation(reduceMotion: reduceMotion),
                                       value: isPressed)
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY)
                    }
                }
                .animation(SegmentedControlMetrics.selectionAnimation(reduceMotion: reduceMotion),
                           value: selectedIndex)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
            }
        }
    }

    // MARK: View

    public struct SegmentedControl: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (SegmentedControl) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SegmentedControlParameters

        // MARK: Properties private

        @State private var isPressed = false
        @Environment(\.accessibilityReduceMotion) private var reduceMotion

        // MARK: Constructors

        public init(parameters: SegmentedControlParameters = SegmentedControlParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(spacing: SegmentedControlMetrics.optionsSpacing) {
                ForEach(Array(parameters.visibleOptions.enumerated()), id: \.offset) { index, option in
                    SegmentedControlOption(option: option,
                                           index: index,
                                           isSelected: parameters.selectedIndex == index) {
                        parameters.select(index: index)
                    }
                }
            }
            .modifier(SegmentedControlSelectionBackground(selectedIndex: parameters.selectedIndex,
                                                          isPressed: isPressed,
                                                          reduceMotion: reduceMotion))
            .padding(SegmentedControlMetrics.containerPadding)
            .frame(height: SegmentedControlMetrics.controlHeight)
            .background(
                RoundedRectangle(cornerRadius: SegmentedControlMetrics.cornerRadius(height: SegmentedControlMetrics.controlHeight))
                    .fill(Color(SegmentedControlMetrics.containerColor(isPressed: isPressed)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: SegmentedControlMetrics.cornerRadius(height: SegmentedControlMetrics.controlHeight))
                    .strokeBorder(Color(Ocean.color.colorInterfaceLightDown),
                                  lineWidth: SegmentedControlMetrics.borderWidth)
            )
            .animation(SegmentedControlMetrics.colorAnimation(reduceMotion: reduceMotion), value: isPressed)
            .onPreferenceChange(SegmentedControlIsPressedKey.self) { isPressed = $0 }
            .accessibilityElement(children: .contain)
        }
    }
}

// MARK: - Support

struct SegmentedControlOptionBoundsKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGRect>] = [:]

    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue()) { _, new in new }
    }
}

/// Alguma opção está pressionada.
struct SegmentedControlIsPressedKey: PreferenceKey {
    static var defaultValue = false

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}
