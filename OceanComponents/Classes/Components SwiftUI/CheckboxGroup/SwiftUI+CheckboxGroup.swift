//
//  SwiftUI+CheckboxGroup.swift
//  Charts
//
//  Created by Acassio Mendonça on 06/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class CheckboxGroupParameters: ObservableObject {
        @Published public var items: [CheckboxModel]
        @Published public var hasError: Bool
        @Published public var errorMessage: String {
            didSet {
                hasError = !errorMessage.isEmpty
            }
        }
        public var onTouch: (([CheckboxModel]) -> Void)

        public init(items: [CheckboxModel] = [],
                    hasError: Bool = false,
                    errorMessage: String = "",
                    onTouch: @escaping (([CheckboxModel]) -> Void) = { _ in }) {
            self.items = items
            self.hasError = hasError
            self.errorMessage = errorMessage
            self.onTouch = onTouch
        }

        fileprivate func selectItem(index: Int) {
            errorMessage = ""
            items[index].isSelected.toggle()
            onTouch(items)
        }

        public struct CheckboxModel {
            public var id: String
            public var title: String
            public var isSelected: Bool

            public init(id: String = "",
                        title: String = "",
                        isSelected: Bool = false) {
                self.id = id
                self.title = title
                self.isSelected = isSelected
            }
        }
    }

    public struct CheckboxGroup: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CheckboxGroup) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CheckboxGroupParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: CheckboxGroupParameters = CheckboxGroupParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                ForEach(0..<self.parameters.items.count, id: \.self) { index in
                    getItem(self.parameters.items[index], index: index)
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
        private func getItem(_ item: CheckboxGroupParameters.CheckboxModel, index: Int) -> some View {
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(item.isSelected
                                  ? Color(Ocean.color.colorComplementaryPure)
                                  : Color(Ocean.color.colorInterfaceLightPure))
                            .frame(width: 20, height: 20)
                            .overlay(
                                getItemOverlay(item)
                            )
                            .padding(.all, 6)
                        if item.isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                    }

                    if !item.title.isEmpty {
                        OceanSwiftUI.Typography.description { view in
                            view.parameters.text = item.title
                            view.parameters.lineLimit = 20
                        }

                        Spacer()
                    }
                }
            }
            .animation(.default, value: item.isSelected)
            .onTapGesture {
                parameters.selectItem(index: index)
            }
        }

        private func getItemOverlay(_ item: CheckboxGroupParameters.CheckboxModel) -> some View {
            return Group {
                if parameters.hasError {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(Ocean.color.colorStatusNegativePure), lineWidth: 1)
                } else if item.isSelected {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(Ocean.color.colorComplementaryPure),
                                lineWidth: 1)
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(Ocean.color.colorInterfaceDarkUp),
                                lineWidth: 1)
                }
            }
        }
    }
}

