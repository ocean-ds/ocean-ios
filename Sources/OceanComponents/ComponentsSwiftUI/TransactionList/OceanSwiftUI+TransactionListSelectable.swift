//
//  OceanSwiftUI+TransactionListSelectable.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Transaction row selected by its amount, with a checkbox or a radio
    /// (Figma `Transaction List Selectable`). The whole row is the touch target.
    public final class TransactionListSelectableParameters: TransactionListParameters {
        @Published public var controlType: ControlType
        @Published public var controlPosition: ControlPosition
        @Published public var isSelected: Bool
        /// Checkbox only: partially selected group. A touch selects it.
        @Published public var isIndeterminate: Bool
        @Published public var hasError: Bool
        /// Called with the new selection after a touch.
        public var onSelection: (Bool) -> Void

        public init(state: TransactionListState = .default,
                    controlType: ControlType = .checkbox,
                    controlPosition: ControlPosition = .trailing,
                    isSelected: Bool = false,
                    isIndeterminate: Bool = false,
                    hasError: Bool = false,
                    contentList: ContentListParameters = ContentListParameters(),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(),
                    showDivider: Bool = true,
                    onSelection: @escaping (Bool) -> Void = { _ in }) {
            self.controlType = controlType
            self.controlPosition = controlPosition
            self.isSelected = isSelected
            self.isIndeterminate = isIndeterminate
            self.hasError = hasError
            self.onSelection = onSelection
            super.init(state: state,
                       contentList: contentList,
                       amountDetails: amountDetails,
                       showDivider: showDivider)
        }

        public enum ControlType {
            case checkbox
            case radio
        }

        /// `trailing` is the Figma `Platform=App` version; `leading` is `Platform=Web`.
        public enum ControlPosition {
            case trailing
            case leading
        }

        /// Checkbox toggles (indeterminate becomes selected); radio only selects.
        func toggleSelection() {
            switch controlType {
            case .checkbox:
                isSelected = isIndeterminate ? true : !isSelected
            case .radio:
                isSelected = true
            }
            isIndeterminate = false
            hasError = false
            onSelection(isSelected)
        }
    }

    public struct TransactionListSelectable: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionListSelectable) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionListSelectableParameters

        // MARK: Constructors

        public init(parameters: TransactionListSelectableParameters = TransactionListSelectableParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            SwiftUI.Button {
                parameters.toggleSelection()
            } label: {
                TransactionListRow(parameters: parameters, spacing: Ocean.size.spacingStackXs) {
                    if parameters.controlPosition == .leading {
                        control
                    }
                } trailing: {
                    if parameters.controlPosition == .trailing {
                        control
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(TransactionListPressableStyle())
            .disabled(!parameters.isEnabled)
        }

        @ViewBuilder
        private var control: some View {
            if parameters.state == .loading {
                TransactionListSkeletonBar(squareSide: 20)
            } else {
                TransactionListSelectionControl(controlType: parameters.controlType,
                                                isSelected: parameters.isSelected,
                                                isIndeterminate: parameters.isIndeterminate,
                                                hasError: parameters.hasError,
                                                isEnabled: parameters.isEnabled)
            }
        }
    }
}
