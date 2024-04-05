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
        @Published public var icon: UIImage?
        @Published public var items: [CheckboxModel]
        @Published public var hasError: Bool
        @Published public var errorMessage: String {
            didSet {
                hasError = !errorMessage.isEmpty
            }
        }
        @Published public var orientation: Orientation
        public var onTouch: (([CheckboxModel]) -> Void)

        public init(icon: UIImage? = nil,
                    items: [CheckboxModel] = [],
                    hasError: Bool = false,
                    errorMessage: String = "",
                    orientation: Orientation = .vertical,
                    onTouch: @escaping (([CheckboxModel]) -> Void) = { _ in }) {
            self.icon = icon
            self.items = items
            self.hasError = hasError
            self.errorMessage = errorMessage
            self.orientation = orientation
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
            public var isEnabled: Bool

            public init(id: String = "",
                        title: String = "",
                        isSelected: Bool = false,
                        isEnabled: Bool = true) {
                self.id = id
                self.title = title
                self.isSelected = isSelected
                self.isEnabled = isEnabled
            }
        }

        public enum Orientation {
            case horizontal
            case vertical
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
                switch parameters.orientation {
                case .horizontal:
                    let column1Count = (parameters.items.count + 1) / 2
                    HStack(alignment: .top) {
                        VStack {
                            ForEach(0..<column1Count, id: \.self) { index in
                                getItem(parameters.items[index], index: index)
                            }
                        }
                        VStack {
                            ForEach(column1Count..<parameters.items.count, id: \.self) { index in
                                getItem(parameters.items[index], index: index)
                            }
                        }
                    }
                case .vertical:
                    ForEach(parameters.items.indices, id: \.self) { index in
                        getItem(parameters.items[index], index: index)
                    }
                }

                if !parameters.errorMessage.isEmpty {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = parameters.errorMessage
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
                            .fill(fillColorForItem(item))
                            .frame(width: 20, height: 20)
                            .overlay(
                                getItemOverlay(item)
                            )
                            .padding(.all, 6)
                        if item.isSelected {
                            if let icon = parameters.icon {
                                Image(uiImage: icon)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 13, height: 13)
                            } else {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 13, height: 13)
                            }
                        }
                    }

                    if !item.title.isEmpty {
                        OceanSwiftUI.Typography.description { view in
                            view.parameters.text = item.title
                            view.parameters.lineLimit = 20
                            view.parameters.tintColor = Ocean.color.colorBrandPrimaryPure
                            view.parameters.textColor = item.isEnabled
                            ? Ocean.color.colorInterfaceDarkDown
                            : Ocean.color.colorInterfaceLightDeep
                        }

                        Spacer()
                    }
                }
            }
            .animation(.default, value: item.isSelected)
            .transform(condition: item.isEnabled, transform: { view in
                view.onTapGesture {
                    parameters.selectItem(index: index)
                }
            })
        }

        private func getItemOverlay(_ item: CheckboxGroupParameters.CheckboxModel) -> some View {
            return Group {
                if !item.isEnabled {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(Ocean.color.colorInterfaceLightDown),
                                lineWidth: 1)
                } else if parameters.hasError {
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

        private func fillColorForItem(_ item: CheckboxGroupParameters.CheckboxModel) -> Color {
            if item.isSelected {
                return item.isEnabled ? Color(Ocean.color.colorComplementaryPure) : Color(Ocean.color.colorInterfaceLightDown)
            }
            return Color(Ocean.color.colorInterfaceLightPure)
        }
    }
}
