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
        @Published private(set) var itemSelectedIndex: Int = 0
        public var onTouch: ((Int, String) -> Void)

        public init(items: [String] = [],
                    itemSelectedIndex: Int = 0,
                    onTouch: @escaping ((Int, String) -> Void) = { _, _ in }) {
            self.items = items
            self.itemSelectedIndex = itemSelectedIndex
            self.onTouch = onTouch
        }

        public func setSelectedIndex(_ index: Int) {
            guard items.indices.contains(index) else { return }
            itemSelectedIndex = index
        }

        fileprivate func selectItem(item: String, index: Int) {
            itemSelectedIndex = index
            onTouch(itemSelectedIndex, item)
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
            VStack {
                VStack(spacing: Ocean.size.spacingStackXs) {
                    ForEach(0..<self.parameters.items.count, id: \.self) { index in
                        getItem(self.parameters.items[index], index: index)
                    }
                }

            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getItem(_ item: String, index: Int) -> some View {
            VStack {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    let icon = self.parameters.itemSelectedIndex == index ? Ocean.icon.radioButtonSelected : Ocean.icon.radioButton
                    Image(uiImage: icon!)

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
    }
}
