//
//  StorybookView.swift
//  OceanDesignSystem
//
//  Tela raiz do Storybook: lista de componentes agrupados que navega para a
//  visualização isolada de cada story.
//

import SwiftUI

private struct StorybookSection: Identifiable {
    let group: String
    let stories: [StorybookStory]
    var id: String { group }
}

struct StorybookView: View {
    private var sections: [StorybookSection] {
        Dictionary(grouping: StorybookCatalog.stories, by: { $0.group })
            .map { StorybookSection(group: $0.key, stories: $0.value.sorted { $0.name < $1.name }) }
            .sorted { $0.group < $1.group }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(sections) { section in
                    Section(header: Text(section.group)) {
                        ForEach(section.stories) { story in
                            NavigationLink(
                                destination: story.makeView()
                                    .navigationBarTitle(story.name, displayMode: .inline)
                            ) {
                                Text(story.name)
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Storybook", displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
