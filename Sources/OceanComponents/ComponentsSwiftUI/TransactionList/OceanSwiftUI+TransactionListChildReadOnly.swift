//
//  OceanSwiftUI+TransactionListChildReadOnly.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Child row without interaction, linked to its siblings by the timeline
    /// (Figma `_Child Transaction List Read Only`). Content and amount default to `.sm`; the icon defaults to `Interface/Light/Down` unless `iconColor` is set.
    public final class TransactionListChildReadOnlyParameters: TransactionListParameters {
        @Published public var position: TransactionListChildPosition

        public init(state: TransactionListState = .default,
                    position: TransactionListChildPosition = .standalone,
                    icon: UIImage? = nil,
                    iconColor: TransactionListIconColor? = nil,
                    contentList: ContentListParameters = ContentListParameters(size: .sm),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(size: .sm)) {
            self.position = position
            super.init(state: state,
                       icon: icon,
                       iconColor: iconColor,
                       contentList: contentList,
                       amountDetails: amountDetails,
                       showDivider: false)
        }

        /// Without an explicit `iconColor`, the timeline icon is `Interface/Light/Down` (Figma child rows).
        override var defaultIconColor: UIColor { Ocean.color.colorInterfaceLightDown }
    }

    public struct TransactionListChildReadOnly: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionListChildReadOnly) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionListChildReadOnlyParameters

        // MARK: Constructors

        public init(parameters: TransactionListChildReadOnlyParameters = TransactionListChildReadOnlyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            TransactionListChildRow(parameters: parameters, position: parameters.position) {
                EmptyView()
            }
        }
    }
}
