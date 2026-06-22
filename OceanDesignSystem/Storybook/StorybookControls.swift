//
//  StorybookControls.swift
//  OceanDesignSystem
//
//  Componentes reutilizáveis de UI para o Storybook: canvas de pré-visualização
//  e controles (knobs) que alteram os parâmetros do componente em tempo real.
//

import SwiftUI

/// Área de pré-visualização onde o componente é renderizado isolado, sobre um
/// fundo neutro que evidencia seus limites.
struct StorybookCanvas<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(8)
    }
}

/// Cabeçalho do painel de controles.
struct StorybookControlsHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("CONTROLS")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
        }
    }
}

/// Seleção única entre poucas opções (ex.: size, type).
struct StorybookSegmentedControl: View {
    let title: String
    let options: [String]
    @Binding var selection: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Picker(title, selection: $selection) {
                ForEach(options.indices, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

/// Controle de texto livre (ex.: title, description).
struct StorybookTextControl: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

/// Controle booleano (ex.: exibir/ocultar botão).
struct StorybookToggleControl: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(title, isOn: $isOn)
    }
}
