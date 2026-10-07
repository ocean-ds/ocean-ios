//
//  OceanSwiftUI+TransactionListReadOnly.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Transaction row without interaction (Figma `Transaction List Read Only`).
    public final class TransactionListReadOnlyParameters: TransactionListParameters {}

    public struct TransactionListReadOnly: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionListReadOnly) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionListReadOnlyParameters

        // MARK: Constructors

        public init(parameters: TransactionListReadOnlyParameters = TransactionListReadOnlyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            TransactionListRow(parameters: parameters) {
                TransactionListLeadingIcon(parameters: parameters)
            } trailing: {
                EmptyView()
            }
            .background(Color(Ocean.color.colorInterfaceLightPure))
        }
    }
}
