//
//  OceanSwiftUI+RadioButtonGroup.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 01/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class RadioButtonGroupParameters: ObservableObject {
        @Published public var items: [String]
        @Published private(set) var itemSelectedIndex: Int?
        @Published public var errorMessage: String
        public var onTouch: ((Int, String) -> Void)

        public init(items: [String] = [],
                    itemSelectedIndex: Int? = nil,
                    errorMessage: String = "",
                    onTouch: @escaping ((Int, String) -> Void) = { _, _ in }) {
            self.items = items
            self.itemSelectedIndex = itemSelectedIndex
            self.errorMessage = errorMessage
            self.onTouch = onTouch
        }

        public func setSelectedIndex(_ index: Int) {
            guard items.indices.contains(index) else { return }
            itemSelectedIndex = index
        }

        fileprivate func selectItem(item: String, index: Int) {
            errorMessage = ""
            itemSelectedIndex = index
            onTouch(index, item)
        }
    }

    public struct RadioButtonGroup: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (RadioButtonGroup) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: RadioButtonGroupParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: RadioButtonGroupParameters = RadioButtonGroupParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .leading) {
                VStack(spacing: Ocean.size.spacingStackXxs) {
                    ForEach(0..<self.parameters.items.count, id: \.self) { index in
                        getItem(self.parameters.items[index], index: index)
                    }
                }

                if !self.parameters.errorMessage.isEmpty {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = self.parameters.errorMessage
                        label.parameters.textColor = Ocean.color.colorStatusNegativePure
                    }
                }
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getItem(_ item: String, index: Int) -> some View {
            VStack {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    Circle()
                        .fill(Color(Ocean.color.colorInterfaceLightPure))
                        .frame(width: 20, height: 20)
                        .overlay(
                            getItemOverlay(index: index)
                        )
                        .padding(.all, 6)

                    OceanSwiftUI.Typography.description { view in
                        view.parameters.text = item
                        view.parameters.lineLimit = 20
                    }

                    Spacer()
                }
            }
            .animation(.default, value: parameters.itemSelectedIndex)
            .onTapGesture { parameters.selectItem(item: item, index: index) }
        }

        private func getItemOverlay(index: Int) -> some View {
            let size: CGFloat = !self.parameters.errorMessage.isEmpty ? 20 : self.parameters.itemSelectedIndex == index ? 14 :20
            return Group {
                if !self.parameters.errorMessage.isEmpty {
                    Circle()
                        .stroke(Color(Ocean.color.colorStatusNegativePure), lineWidth: 1)
                } else if self.parameters.itemSelectedIndex == index {
                    Circle()
                        .stroke(Color(Ocean.color.colorComplementaryPure), lineWidth: 6)
                } else {
                    Circle()
                        .stroke(Color(Ocean.color.colorInterfaceDarkUp), lineWidth: 1)
                }
            }
            .frame(width: size,
                   height: size)
        }
    }
}
