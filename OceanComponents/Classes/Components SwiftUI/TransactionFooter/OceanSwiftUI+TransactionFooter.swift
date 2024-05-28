//
//  OceanSwiftUI+TransactionFooter.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 28/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class TransactionFooterParameters: ObservableObject {
        @Published public var items: [ItemModel]
        @Published public var primaryButton: ButtonModel?
        @Published public var secondaryButton: ButtonModel?
        @Published public var buttonOrientation: ButtonOrientation

        public init(items: [ItemModel] = [],
                    primaryButton: ButtonModel? = nil,
                    secondaryButton: ButtonModel? = nil,
                    buttonOrientation: ButtonOrientation = .horizontal) {
            self.items = items
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
            self.buttonOrientation = buttonOrientation
        }

        public enum ButtonOrientation {
            case horizontal
            case vertical
        }

        public class ButtonModel: ObservableObject {
            @Published public var title: String
            @Published public var style: ButtonParameters.Style
            @Published public var size: ButtonParameters.Size
            public var action: () -> Void

            public init(title: String = "",
                        style: ButtonParameters.Style = .primary,
                        size: ButtonParameters.Size = .medium,
                        action: @escaping () -> Void = { }) {
                self.title = title
                self.style = style
                self.size = size
                self.action = action
            }
        }

        public class ItemModel: ObservableObject {
            @Published public var text: String
            @Published public var value: ValueModel?

            public init(text: String = "",
                        value: ValueModel? = nil) {
                self.text = text
                self.value = value
            }
        }

        public class ValueModel: ObservableObject {
            @Published public var value: String
            @Published public var valueColor: UIColor
            @Published public var newValue: String
            @Published public var newValueColor: UIColor
            @Published public var imageIcon: UIImage?
            @Published public var valueIsBold: Bool

            public init(value: String = "",
                        valueColor: UIColor = Ocean.color.colorInterfaceDarkDeep,
                        newValue: String = "",
                        newValueColor: UIColor = Ocean.color.colorStatusPositiveDeep,
                        imageIcon: UIImage? = nil,
                        valueIsBold: Bool = false) {
                self.value = value
                self.valueColor = valueColor
                self.newValue = newValue
                self.newValueColor = newValueColor
                self.imageIcon = imageIcon
                self.valueIsBold = valueIsBold
            }
        }
    }

    public struct TransactionFooter: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TransactionFooter) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TransactionFooterParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: TransactionFooterParameters = TransactionFooterParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                ForEach(parameters.items.indices, id: \.self) { index in
                    HStack {
                        if !parameters.items[index].text.isEmpty {
                            Typography.paragraph { label in
                                label.parameters.text = parameters.items[index].text
                            }

                            Spacer()
                        }

                        if let value = parameters.items[index].value {
                            Typography.paragraph { label in
                                label.parameters.text = value.value
                            }
                        }
                    }
                }
            }
        }

        // MARK: Methods private

        private func getValue(value: TransactionFooterParameters.ValueModel) {
            var text = ""

            if !value.newValue.isEmpty, !value.value.isEmpty {

            }

            if !value.value.isEmpty {

            }
        }
    }
}
