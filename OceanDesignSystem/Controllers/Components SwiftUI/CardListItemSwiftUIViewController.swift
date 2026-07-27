//
//  CardListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 26/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class CardListItemSwiftUIViewController: UIViewController {

    // MARK: - State

    fileprivate class State: ObservableObject {
        @Published var hasLeadingIcon: Bool = false
        @Published var hasTrailingIcon: Bool = false
        @Published var hasSubtitle: Bool = true
        @Published var hasCaption: Bool = true
        @Published var hasTag: Bool = false
        @Published var tagPosition: OceanSwiftUI.CardListItemParameters.TagPosition = .leading
        @Published var tagStatus: OceanSwiftUI.TagParameters.Status = .neutralPrimary
        @Published var hasHighlight: Bool = false
        @Published var hasHighlightIcon: Bool = true
        @Published var hasCornerTag: Bool = false
        @Published var cornerTagStatus: OceanSwiftUI.TagParameters.Status = .highlightNeutral
        @Published var selectionMode: SelectionMode = .none
        @Published var isEnabled: Bool = true
        @Published var hasError: Bool = false
        @Published var showSkeleton: Bool = false
    }

    enum SelectionMode: String, CaseIterable {
        case none = "None"
        case checkbox = "Checkbox"
        case radioButton = "Radio Button"
    }

    // MARK: - Component

    lazy var previewCard = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.onTouch = { print("card touched") }
        builder.parameters.onTouchWhenDisabled = { print("card touched (disabled)") }
    }

    private let state = State()

    // MARK: - Layout

    public lazy var hostingController: UIHostingController<AnyView> = {
        let content = AnyView(CardListItemPreviewView(state: self.state, card: self.previewCard))
        return UIHostingController(rootView: content)
    }()

    public lazy var uiView: UIView = {
        return self.hostingController.getUIView()
    }()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(uiView)
        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

// MARK: - SwiftUI View

private struct CardListItemPreviewView: View {

    @ObservedObject var state: CardListItemSwiftUIViewController.State
    var card: OceanSwiftUI.CardListItem

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Preview area
            VStack {
                card
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, Ocean.size.spacingStackXs)
            }
            .padding(.vertical, Ocean.size.spacingStackSm)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemBackground))
            .onChange(of: state.hasLeadingIcon)   { _ in updateCard() }
            .onChange(of: state.hasTrailingIcon)  { _ in updateCard() }
            .onChange(of: state.hasSubtitle)      { _ in updateCard() }
            .onChange(of: state.hasCaption)       { _ in updateCard() }
            .onChange(of: state.hasTag)           { _ in updateCard() }
            .onChange(of: state.tagPosition)      { _ in updateCard() }
            .onChange(of: state.tagStatus)        { _ in updateCard() }
            .onChange(of: state.hasHighlight)     { _ in updateCard() }
            .onChange(of: state.hasHighlightIcon) { _ in updateCard() }
            .onChange(of: state.hasCornerTag)     { _ in updateCard() }
            .onChange(of: state.cornerTagStatus)  { _ in updateCard() }
            .onChange(of: state.selectionMode)    { _ in updateCard() }
            .onChange(of: state.isEnabled)        { _ in updateCard() }
            .onChange(of: state.hasError)         { _ in updateCard() }
            .onChange(of: state.showSkeleton)     { _ in updateCard() }

            Divider()

            // MARK: Controls
            ScrollView {
                VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Content").font(.headline)

                        Toggle("Leading Icon", isOn: $state.hasLeadingIcon)
                        Toggle("Trailing Icon", isOn: $state.hasTrailingIcon)
                        Toggle("Subtitle", isOn: $state.hasSubtitle)
                        Toggle("Caption", isOn: $state.hasCaption)
                    }
                    .padding(.bottom, Ocean.size.spacingStackXxs)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tag").font(.headline)

                        Toggle("Has Tag", isOn: $state.hasTag)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Position")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Picker("Tag Position", selection: $state.tagPosition) {
                                Text("Leading").tag(OceanSwiftUI.CardListItemParameters.TagPosition.leading)
                                Text("Trailing").tag(OceanSwiftUI.CardListItemParameters.TagPosition.trailing)
                                Text("Above").tag(OceanSwiftUI.CardListItemParameters.TagPosition.above)
                                Text("Below").tag(OceanSwiftUI.CardListItemParameters.TagPosition.below)
                            }
                            .pickerStyle(SegmentedPickerStyle())

                            Text("Status")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Picker("Tag Status", selection: $state.tagStatus) {
                                Text("Neutral").tag(OceanSwiftUI.TagParameters.Status.neutralPrimary)
                                Text("Positive").tag(OceanSwiftUI.TagParameters.Status.positive)
                                Text("Warning").tag(OceanSwiftUI.TagParameters.Status.warning)
                                Text("Negative").tag(OceanSwiftUI.TagParameters.Status.negative)
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 120)
                            .clipped()
                        }
                        .disabled(!state.hasTag)
                        .opacity(state.hasTag ? 1 : 0.3)
                    }
                    .padding(.bottom, Ocean.size.spacingStackXxs)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Highlight").font(.headline)

                        Toggle("Has Highlight", isOn: $state.hasHighlight)

                        Toggle("Has Highlight Icon", isOn: $state.hasHighlightIcon)
                            .disabled(!state.hasHighlight)
                            .opacity(state.hasHighlight ? 1 : 0.3)
                    }
                    .padding(.bottom, Ocean.size.spacingStackXxs)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Corner Tag").font(.headline)

                        Toggle("Has Corner Tag", isOn: $state.hasCornerTag)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Status")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Picker("Corner Tag Status", selection: $state.cornerTagStatus) {
                                Text("Highlight Neutral").tag(OceanSwiftUI.TagParameters.Status.highlightNeutral)
                                Text("Highlight Complementary").tag(OceanSwiftUI.TagParameters.Status.highlightComplementary)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .disabled(!state.hasCornerTag)
                        .opacity(state.hasCornerTag ? 1 : 0.3)
                    }
                    .padding(.bottom, Ocean.size.spacingStackXxs)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Selection Mode").font(.headline)

                        Picker("Selection Mode", selection: $state.selectionMode) {
                            ForEach(CardListItemSwiftUIViewController.SelectionMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.bottom, Ocean.size.spacingStackXxs)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("State").font(.headline)

                        Toggle("Enabled", isOn: $state.isEnabled)
                        Toggle("Has Error", isOn: $state.hasError)
                        Toggle("Show Skeleton", isOn: $state.showSkeleton)
                    }
                }
                .padding(.horizontal, Ocean.size.spacingStackMd)
                .padding(.vertical, Ocean.size.spacingStackXs)
            }
        }
    }

    // MARK: - Update

    private func updateCard() {
        card.parameters.leadingIcon = state.hasLeadingIcon ? Ocean.icon.archiveOutline : nil
        card.parameters.trailingIcon = state.hasTrailingIcon ? Ocean.icon.chevronRightSolid : nil
        card.parameters.subtitle = state.hasSubtitle ? "Subtitle" : ""
        card.parameters.caption = state.hasCaption ? "Caption" : ""
        card.parameters.tagLabel = state.hasTag ? "Tag" : ""
        card.parameters.tagPosition = state.tagPosition
        card.parameters.tagStatus = state.tagStatus
        card.parameters.highlightCaption = state.hasHighlight ? "This is a highlight message for this card item." : ""
        card.parameters.highlightIcon = state.hasHighlight && state.hasHighlightIcon ? Ocean.icon.sparklesSolid : nil
        card.parameters.cornerTag = state.hasCornerTag
            ? OceanSwiftUI.TagParameters(label: "Recomendado",
                                         status: state.cornerTagStatus,
                                         size: .corner,
                                         font: UIFont.baseExtraBold(size: 10))
            : nil
        card.parameters.hasCheckbox = state.selectionMode == CardListItemSwiftUIViewController.SelectionMode.checkbox
        card.parameters.hasRadioButton = state.selectionMode == CardListItemSwiftUIViewController.SelectionMode.radioButton

        card.parameters.isEnabled = state.isEnabled
        card.parameters.hasError = state.hasError
        card.parameters.showSkeleton = state.showSkeleton
    }
}

@available(iOS 13.0, *)
struct CardListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardListItemSwiftUIViewController()
        }
    }
}

/// As quatro posições de tag lado a lado (MR-555). `.leading` e `.trailing` são o
/// comportamento atual; `.above` e `.below` empilham dentro do bloco de conteúdo.
@available(iOS 14.0, *)
struct CardListItemTagPosition_Preview: PreviewProvider {

    private static func card(
        _ title: String,
        _ position: OceanSwiftUI.CardListItemParameters.TagPosition,
        selectable: Bool = false
    ) -> some View {
        OceanSwiftUI.CardListItem { view in
            view.parameters.title = title
            view.parameters.subtitle = "Pague em até 3x"
            view.parameters.caption = "Caption"
            view.parameters.tagLabel = "3x sem acréscimo"
            view.parameters.tagStatus = .positive
            view.parameters.tagPosition = position
            view.parameters.hasRadioButton = selectable
            view.parameters.isChecked = selectable
        }
    }

    static var previews: some View {
        ScrollView {
            VStack(spacing: Ocean.size.spacingStackXs) {
                card(".leading (default)", .leading)
                card(".trailing", .trailing)
                card(".above", .above)
                card(".below", .below)
                card(".above + radio (caso MR-523)", .above, selectable: true)
            }
            .padding(Ocean.size.spacingStackXs)
        }
        .previewDisplayName("Tag position")
    }
}
