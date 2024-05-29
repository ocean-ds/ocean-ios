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
        @Published public var primaryButton: ButtonParameters?
        @Published public var secondaryButton: ButtonParameters?
        @Published public var buttonOrientation: ButtonOrientation
        @Published public var showSkeleton: Bool
        @Published public var numberOfItemsToShowSkeleton: Int
        @Published public var padding: EdgeInsets

        public init(items: [ItemModel] = [],
                    primaryButton: ButtonParameters? = nil,
                    secondaryButton: ButtonParameters? = nil,
                    buttonOrientation: ButtonOrientation = .horizontal,
                    showSkeleton: Bool = false,
                    numberOfItemsToShowSkeleton: Int = 3,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXs,
                                                trailing: Ocean.size.spacingStackXs)) {
            self.items = items
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
            self.buttonOrientation = buttonOrientation
            self.showSkeleton = showSkeleton
            self.numberOfItemsToShowSkeleton = numberOfItemsToShowSkeleton
            self.padding = padding
        }

        public enum ButtonOrientation {
            case horizontal
            case vertical
        }

        public class ItemModel: ObservableObject, Identifiable {
            @Published public var text: String
            @Published public var value: String
            @Published public var valueColor: UIColor
            @Published public var valueIsBold: Bool
            @Published public var newValue: String
            @Published public var newValueColor: UIColor
            @Published public var imageIcon: UIImage?
            @Published public var imageColor: UIColor

            public init(text: String = "",
                        value: String = "",
                        valueColor: UIColor = Ocean.color.colorInterfaceDarkDeep,
                        valueIsBold: Bool = false,
                        newValue: String = "",
                        newValueColor: UIColor = Ocean.color.colorStatusPositiveDeep,
                        imageIcon: UIImage? = nil,
                        imageColor: UIColor = Ocean.color.colorStatusPositiveDeep) {
                self.text = text
                self.value = value
                self.valueColor = valueColor
                self.valueIsBold = valueIsBold
                self.newValue = newValue
                self.newValueColor = newValueColor
                self.imageIcon = imageIcon
                self.imageColor = imageColor
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
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {

                if parameters.showSkeleton {
                    getSkeletonView(itemsCount: parameters.numberOfItemsToShowSkeleton)
                } else {
                    ForEach(parameters.items.indices, id: \.self) { index in
                        getItemView(item: parameters.items[index])
                    }

                    if parameters.buttonOrientation == .horizontal {
                        HStack {
                            getButtonsView()
                        }
                    } else {
                        VStack {
                            getButtonsView()
                        }
                    }
                }
            }
            .padding(parameters.padding)
        }

        // MARK: Methods private

        @ViewBuilder
        private func getItemView(item: TransactionFooterParameters.ItemModel) -> some View {
            HStack {
                Typography.paragraph { label in
                    label.parameters.text = item.text
                }

                Spacer()

                if let icon = item.imageIcon {
                    Image(uiImage: icon.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(item.imageColor))
                }

                if !item.newValue.isEmpty, !item.value.isEmpty {
                    Typography.paragraph { label in
                        label.parameters.text = item.value
                        label.parameters.textColor = item.valueColor
                        label.parameters.strikethrough = true
                    }
                    Typography.paragraph { label in
                        label.parameters.text = item.newValue
                        label.parameters.textColor = item.newValueColor
                    }
                } else {
                    Typography.paragraph { label in
                        label.parameters.text = item.value
                        label.parameters.textColor = item.valueColor
                        label.parameters.font = item.valueIsBold
                            ? .baseBold(size: Ocean.font.fontSizeXs)
                            : .baseRegular(size: Ocean.font.fontSizeXs)
                    }
                }
            }
        }

        @ViewBuilder
        private func getButtonsView() -> some View {
            Group {
                if let button = parameters.primaryButton {
                    Button.init(parameters: button)
                }

                if let button = parameters.secondaryButton {
                    Button.init(parameters: button)
                }
            }
            .padding(.vertical, Ocean.size.spacingStackXxs)
        }

        private func getSkeletonView(itemsCount: Int) -> some View {
            ForEach(0..<itemsCount, id: \.self) { index in
                HStack {
                    Typography.paragraph { label in
                        label.parameters.text = "                                        "
                        label.parameters.showSkeleton = true
                    }

                    Spacer()

                    Typography.paragraph { label in
                        label.parameters.text = "                     "
                        label.parameters.showSkeleton = true
                    }
                }
            }
        }
    }
}
