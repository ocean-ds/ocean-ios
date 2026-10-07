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

    /// Transaction row that leads to a detail: chevron on the right, pressed highlight and one
    /// `onTouch` per touch (Figma `Transaction List Action`, type Chevron).
    public final class TransactionListActionParameters: TransactionListParameters {
        public var onTouch: () -> Void

        public init(state: TransactionListState = .default,
                    icon: UIImage? = nil,
                    contentList: ContentListParameters = ContentListParameters(),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(),
                    showDivider: Bool = true,
                    onTouch: @escaping () -> Void = { }) {
            self.onTouch = onTouch
            super.init(state: state,
                       icon: icon,
                       contentList: contentList,
                       amountDetails: amountDetails,
                       showDivider: showDivider)
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
                TransactionListRow(parameters: parameters) {
                    TransactionListLeadingIcon(parameters: parameters)
                } trailing: {
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
