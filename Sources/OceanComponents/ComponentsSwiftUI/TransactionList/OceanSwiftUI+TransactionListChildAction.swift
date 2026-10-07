//
//  OceanSwiftUI+TransactionListChildAction.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Child row that leads to a detail, linked to its siblings by the timeline
    /// (Figma `_Child Transaction List Action`). Content and amount default to `.sm`.
    public final class TransactionListChildActionParameters: TransactionListParameters {
        @Published public var position: TransactionListChildPosition
        public var onTouch: () -> Void

        public init(state: TransactionListState = .default,
                    position: TransactionListChildPosition = .standalone,
                    icon: UIImage? = nil,
                    contentList: ContentListParameters = ContentListParameters(size: .sm),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(size: .sm),
                    onTouch: @escaping () -> Void = { }) {
            self.position = position
            self.onTouch = onTouch
            super.init(state: state,
                       icon: icon,
                       iconColor: Ocean.color.colorInterfaceLightDown,
                       contentList: contentList,
                       amountDetails: amountDetails,
                       showDivider: false)
        }
    }

    public struct TransactionListChildAction: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionListChildAction) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionListChildActionParameters

        // MARK: Constructors

        public init(parameters: TransactionListChildActionParameters = TransactionListChildActionParameters()) {
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
                TransactionListChildRow(parameters: parameters, position: parameters.position) {
                    if parameters.state != .loading {
                        TransactionListActionIcon(image: Ocean.icon.chevronRightSolid,
                                                  isDisabled: parameters.state == .disabled)
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(TransactionListPressableStyle())
            .disabled(!parameters.isEnabled)
        }
    }
}
