//
//  TransactionListSelectableSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import OceanComponents
import OceanTokens
import SwiftUI

/// CT-3: checkbox and radio, app (control on the right) and web (control on the left) versions.
final class TransactionListSelectableSwiftUIViewController: TransactionListDemoViewController<TransactionListSelectableDemo> {
    init() {
        super.init { TransactionListSelectableDemo() }
    }
}

struct TransactionListSelectableDemo: View {
    private typealias Parameters = OceanSwiftUI.TransactionListSelectableParameters

    private let variants: [(String, Parameters.ControlType, Parameters.ControlPosition)] = [
        ("Checkbox · App", .checkbox, .trailing),
        ("Radio · App", .radio, .trailing),
        ("Checkbox · Web", .checkbox, .leading),
        ("Radio · Web", .radio, .leading)
    ]

    var body: some View {
        ForEach(variants, id: \.0) { title, controlType, controlPosition in
            TransactionListDemoSection(title: title) {
                row(controlType, controlPosition)
                row(controlType, controlPosition, isSelected: true)
                if controlType == .checkbox {
                    row(controlType, controlPosition, isIndeterminate: true)
                }
                row(controlType, controlPosition, state: .disabled)
                row(controlType, controlPosition, state: .disabled, isSelected: true)
                row(controlType, controlPosition, hasError: true)
                row(controlType, controlPosition, state: .loading)
            }
        }
    }

    private func row(_ controlType: Parameters.ControlType,
                     _ controlPosition: Parameters.ControlPosition,
                     state: OceanSwiftUI.TransactionListState = .default,
                     isSelected: Bool = false,
                     isIndeterminate: Bool = false,
                     hasError: Bool = false) -> some View {
        OceanSwiftUI.TransactionListSelectable(parameters: .init(state: state,
                                                                 controlType: controlType,
                                                                 controlPosition: controlPosition,
                                                                 isSelected: isSelected,
                                                                 isIndeterminate: isIndeterminate,
                                                                 hasError: hasError,
                                                                 contentList: TransactionListDemo.content(),
                                                                 amountDetails: TransactionListDemo.amount()))
    }
}
