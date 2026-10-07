//
//  OceanSwiftUI+TransactionListAction.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Transaction row with an action on the right, pressed highlight and one `onTouch` per touch
    /// (Figma `Transaction List Action`, types Chevron and Menu).
    ///
    /// Menu: the component only shows the kebab and its Active state and calls `onTouch`. In the app the
    /// screen presents the options in the Ocean bottom sheet (`Ocean.ModalList`), sets `isMenuActive = true`
    /// while it is open and back to `false` when it is dismissed (`withDismiss(_:completion:)`).
    public final class TransactionListActionParameters: TransactionListParameters {
        @Published public var actionType: ActionType
        /// Menu only: the options bottom sheet is open (Figma `State=Active`).
        @Published public var isMenuActive: Bool
        public var onTouch: () -> Void

        public init(state: TransactionListState = .default,
                    actionType: ActionType = .chevron,
                    isMenuActive: Bool = false,
                    icon: UIImage? = nil,
                    contentList: ContentListParameters = ContentListParameters(),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(),
                    showDivider: Bool = true,
                    onTouch: @escaping () -> Void = { }) {
            self.actionType = actionType
            self.isMenuActive = isMenuActive
            self.onTouch = onTouch
            super.init(state: state,
                       icon: icon,
                       contentList: contentList,
                       amountDetails: amountDetails,
                       showDivider: showDivider)
        }

        public enum ActionType {
            /// Leads to a detail.
            case chevron
            /// Kebab: the screen presents the options in the Ocean bottom sheet (`Ocean.ModalList`) on
            /// `onTouch` — same contract as `StatusListItem.contextMenu`.
            case menu
        }
    }

    public struct TransactionListAction: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionListAction) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionListActionParameters

        // MARK: Constructors

        public init(parameters: TransactionListActionParameters = TransactionListActionParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            SwiftUI.Button {
                parameters.onTouch()
            } label: {
                TransactionListRow(parameters: parameters, trailingPadding: trailingPadding) {
                    TransactionListLeadingIcon(parameters: parameters)
                } trailing: {
                    if parameters.state != .loading {
                        actionIcon
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(TransactionListPressableStyle())
            .disabled(!parameters.isEnabled)
        }

        private var trailingPadding: CGFloat {
            parameters.actionType == .menu && parameters.state != .loading
                ? Ocean.size.spacingStackXxs
                : Ocean.size.spacingStackXs
        }

        @ViewBuilder
        private var actionIcon: some View {
            switch parameters.actionType {
            case .chevron:
                TransactionListActionIcon(image: Ocean.icon.chevronRightSolid,
                                          isDisabled: parameters.state == .disabled)
            case .menu:
                TransactionListMenuIcon(isActive: parameters.isMenuActive && parameters.isEnabled,
                                        isDisabled: parameters.state == .disabled)
            }
        }
    }
}
