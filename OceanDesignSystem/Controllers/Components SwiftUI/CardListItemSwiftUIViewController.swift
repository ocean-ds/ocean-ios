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

    @Published private var hasLeadingIcon: Bool = false
    @Published private var hasTrailingIcon: Bool = false
    @Published private var hasSubtitle: Bool = true
    @Published private var hasCaption: Bool = true
    @Published private var hasTag: Bool = false
    @Published private var tagPosition: OceanSwiftUI.CardListItemParameters.TagPosition = .leading
    @Published private var tagStatus: OceanSwiftUI.TagParameters.Status = .neutralPrimary
    @Published private var hasHighlight: Bool = false
    @Published private var selectionMode: SelectionMode = .none
    @Published private var isEnabled: Bool = true
    @Published private var hasError: Bool = false
    @Published private var showSkeleton: Bool = false

    private enum SelectionMode: String, CaseIterable {
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

    // MARK: - Layout

    public lazy var hostingController: UIHostingController<AnyView> = {
        let content = AnyView(
            VStack(spacing: 0) {
                // MARK: Preview area
                VStack {
                    previewCard
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                }
                .padding(.vertical, Ocean.size.spacingStackSm)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))

                Divider()

                // MARK: Controls
                ScrollView {
                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Content")
                                .font(.headline)

                            Toggle("Leading Icon", isOn: Binding(
                                get: { self.hasLeadingIcon },
                                set: { self.hasLeadingIcon = $0; self.updateCard() }
                            ))

                            Toggle("Trailing Icon", isOn: Binding(
                                get: { self.hasTrailingIcon },
                                set: { self.hasTrailingIcon = $0; self.updateCard() }
                            ))

                            Toggle("Subtitle", isOn: Binding(
                                get: { self.hasSubtitle },
                                set: { self.hasSubtitle = $0; self.updateCard() }
                            ))

                            Toggle("Caption", isOn: Binding(
                                get: { self.hasCaption },
                                set: { self.hasCaption = $0; self.updateCard() }
                            ))
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxs)

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tag")
                                .font(.headline)

                            Toggle("Has Tag", isOn: Binding(
                                get: { self.hasTag },
                                set: { self.hasTag = $0; self.updateCard() }
                            ))

                            if self.hasTag {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Position")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Picker("Tag Position", selection: Binding(
                                        get: { self.tagPosition },
                                        set: { self.tagPosition = $0; self.updateCard() }
                                    )) {
                                        Text("Leading").tag(OceanSwiftUI.CardListItemParameters.TagPosition.leading)
                                        Text("Trailing").tag(OceanSwiftUI.CardListItemParameters.TagPosition.trailing)
                                    }
                                    .pickerStyle(SegmentedPickerStyle())

                                    Text("Status")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Picker("Tag Status", selection: Binding(
                                        get: { self.tagStatus },
                                        set: { self.tagStatus = $0; self.updateCard() }
                                    )) {
                                        Text("Neutral").tag(OceanSwiftUI.TagParameters.Status.neutralPrimary)
                                        Text("Positive").tag(OceanSwiftUI.TagParameters.Status.positive)
                                        Text("Warning").tag(OceanSwiftUI.TagParameters.Status.warning)
                                        Text("Negative").tag(OceanSwiftUI.TagParameters.Status.negative)
                                    }
                                    .pickerStyle(WheelPickerStyle())
                                    .frame(height: 120)
                                    .clipped()
                                }
                            }
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxs)

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Highlight")
                                .font(.headline)

                            Toggle("Has Highlight", isOn: Binding(
                                get: { self.hasHighlight },
                                set: { self.hasHighlight = $0; self.updateCard() }
                            ))
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxs)

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Selection Mode")
                                .font(.headline)

                            Picker("Selection Mode", selection: Binding(
                                get: { self.selectionMode },
                                set: { self.selectionMode = $0; self.updateCard() }
                            )) {
                                ForEach(SelectionMode.allCases, id: \.self) { mode in
                                    Text(mode.rawValue).tag(mode)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxs)

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("State")
                                .font(.headline)

                            Toggle("Enabled", isOn: Binding(
                                get: { self.isEnabled },
                                set: { self.isEnabled = $0; self.updateCard() }
                            ))

                            Toggle("Has Error", isOn: Binding(
                                get: { self.hasError },
                                set: { self.hasError = $0; self.updateCard() }
                            ))

                            Toggle("Show Skeleton", isOn: Binding(
                                get: { self.showSkeleton },
                                set: { self.showSkeleton = $0; self.updateCard() }
                            ))
                        }
                    }
                    .padding(.horizontal, Ocean.size.spacingStackMd)
                    .padding(.vertical, Ocean.size.spacingStackXs)
                }
            }
        )
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

    // MARK: - Update

    private func updateCard() {
        previewCard.parameters.leadingIcon = hasLeadingIcon ? Ocean.icon.archiveOutline : nil
        previewCard.parameters.trailingIcon = hasTrailingIcon ? Ocean.icon.chevronRightSolid : nil
        previewCard.parameters.subtitle = hasSubtitle ? "Subtitle" : ""
        previewCard.parameters.caption = hasCaption ? "Caption" : ""
        previewCard.parameters.tagLabel = hasTag ? "Tag" : ""
        previewCard.parameters.tagPosition = tagPosition
        previewCard.parameters.tagStatus = tagStatus
        previewCard.parameters.highlightCaption = hasHighlight ? "This is a highlight message for this card item." : ""
        previewCard.parameters.hasCheckbox = selectionMode == .checkbox
        previewCard.parameters.hasRadioButton = selectionMode == .radioButton
        previewCard.parameters.isEnabled = isEnabled
        previewCard.parameters.hasError = hasError
        previewCard.parameters.showSkeleton = showSkeleton
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
