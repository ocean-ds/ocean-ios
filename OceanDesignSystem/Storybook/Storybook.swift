//
//  Storybook.swift
//  OceanDesignSystem
//
//  Catálogo interativo de componentes do Ocean DS (estilo Storybook) para
//  testar e validar visualmente cada componente em isolamento.
//

import SwiftUI

/// Descreve uma "story": um componente do Ocean DS renderizado isoladamente,
/// com um painel de controles interativos para validar suas variantes.
///
/// Para adicionar um novo componente, crie a story (ver `BannerStory` como
/// referência) e registre-a em `StorybookCatalog.stories`.
struct StorybookStory: Identifiable {
    let id = UUID()
    let name: String
    let group: String
    let makeView: () -> AnyView
}

/// Catálogo central de stories. Cada componente que entrar no Storybook
/// deve ser registrado aqui.
enum StorybookCatalog {
    static let stories: [StorybookStory] = [
        BannerStory.story
    ]
}
