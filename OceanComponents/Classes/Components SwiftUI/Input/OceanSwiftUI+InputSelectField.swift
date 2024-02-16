//
//  OceanSwiftUI+InputSelectField.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 16/02/24.
//

import SwiftUI
import OceanTokens
import Combine

extension OceanSwiftUI {

    // MARK: Parameters

    public class InputSelectFieldParameters: ObservableObject {
        @Published public var title: String
        @Published public var placeholder: String
        @Published public var text: String
        @Published public var errorMessage: String
        @Published public var helperMessage: String
        @Published public var iconHelper: UIImage?
        @Published public var titleModal: String
        @Published public var values: [String]
        @Published public var maxValues: Int?
        @Published public var placeholderFilter: String?
        @Published public var isDisabled: Bool
        @Published public var showSkeleton: Bool
        @Published public var onValueChanged: (String) -> Void
        public var onTouchIconHelper: () -> Void

        weak public var rootViewController: UIViewController?

        public init(title: String = "",
                    placeholder: String = "",
                    text: String = "",
                    errorMessage: String = "",
                    helperMessage: String = "",
                    iconHelper: UIImage? = nil,
                    titleModal: String = "",
                    values: [String] = [],
                    maxValues: Int? = nil,
                    placeholderFilter: String? = nil,
                    isDisabled: Bool = false,
                    showSkeleton: Bool = false,
                    onValueChanged: @escaping (String) -> Void = { _ in },
                    onTouchIconHelper: @escaping () -> Void = { }) {
            self.title = title
            self.placeholder = placeholder
            self.text = text
            self.errorMessage = errorMessage
            self.helperMessage = helperMessage
            self.iconHelper = iconHelper
            self.titleModal = titleModal
            self.values = values
            self.maxValues = maxValues
            self.placeholderFilter = placeholderFilter
            self.isDisabled = isDisabled
            self.showSkeleton = showSkeleton
            self.onValueChanged = onValueChanged
            self.onTouchIconHelper = onTouchIconHelper
        }
    }

    public struct InputSelectField: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (InputSelectField) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: InputSelectFieldParameters

        // MARK: Properties private

        @State private var focused: Bool = false

        // MARK: Constructors

        public init(parameters: InputSelectFieldParameters = InputSelectFieldParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        private var textFieldView: some View {
            TextField(self.parameters.placeholder, text: self.$parameters.text, onEditingChanged: { edit in
                self.focused = edit

                if edit {
                    self.openModal()
                }
            })
            .disabled(self.parameters.isDisabled)
        }

        public var body: some View {
            VStack(alignment: .leading) {
                if !self.parameters.title.isEmpty {
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.title
                        label.parameters.textColor = self.parameters.isDisabled ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDown
                        label.parameters.showSkeleton = self.parameters.showSkeleton
                    }
                    Spacer().frame(height: Ocean.size.spacingStackXxs)
                }

                ZStack(alignment: .trailing) {
                    textFieldView
                        .frame(height: 48)
                        .padding([.leading, .trailing], Ocean.size.spacingStackXs)
                        .padding([.top, .bottom], 2)
                        .background(
                            RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                                        .strokeBorder(Color(getBorderColor()),
                                                      lineWidth: 1))
                                .foregroundColor(Color(self.parameters.isDisabled ? Ocean.color.colorInterfaceLightUp : Ocean.color.colorInterfaceLightPure))
                        )
                        .font(Font(UIFont.baseRegular(size: Ocean.font.fontSizeXs)!))
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
                        .skeleton(with: self.parameters.showSkeleton)


                    Image(uiImage: Ocean.icon.chevronDownSolid!)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, Ocean.size.spacingStackXs)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkDown))
                        .skeleton(with: self.parameters.showSkeleton)
                }

                HStack {
                    if !self.parameters.errorMessage.isEmpty {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.errorMessage
                            label.parameters.textColor = Ocean.color.colorStatusNegativePure
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }
                    } else if !self.parameters.helperMessage.isEmpty {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.helperMessage
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                            label.parameters.showSkeleton = self.parameters.showSkeleton
                        }

                        Spacer().frame(width: Ocean.size.spacingStackXxxs)

                        if let icon = self.parameters.iconHelper {
                            Image(uiImage: icon)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 16, height: 16, alignment: .center)
                                .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                                .onTapGesture {
                                    self.parameters.onTouchIconHelper()
                                }
                                .skeleton(with: self.parameters.showSkeleton)
                        }
                    }
                }
                .frame(height: 16)
                .opacity(self.parameters.errorMessage.isEmpty && self.parameters.helperMessage.isEmpty ? 0 : 1)
            }
        }

        // MARK: Methods private

        private func getBorderColor() -> UIColor {
            if self.parameters.isDisabled {
                return Ocean.color.colorInterfaceLightUp
            } else if !self.parameters.errorMessage.isEmpty {
                return Ocean.color.colorStatusNegativePure
            } else if self.focused {
                return Ocean.color.colorBrandPrimaryDown
            } else if !self.parameters.text.isEmpty {
                return Ocean.color.colorBrandPrimaryUp
            } else {
                return Ocean.color.colorInterfaceLightDeep
            }
        }

        private func openModal() {
            if let rootViewController = self.parameters.rootViewController {
                rootViewController.view.endEditing(true)

                var model: [Ocean.CellModel]

                if let maxValues = self.parameters.maxValues {
                    model = self.parameters.values.prefix(maxValues).compactMap { value in
                        Ocean.CellModel(title: value, isSelected: self.parameters.text == value)
                    }
                    model.append(Ocean.CellModel(title: "Ver todos", isSelected: false))
                } else {
                    model = self.parameters.values.compactMap { value in
                        Ocean.CellModel(title: value, isSelected: self.parameters.text == value)
                    }
                }

                let modalList = Ocean.ModalList(rootViewController)
                    .withTitle(self.parameters.titleModal)
                    .withValues(model)
                    .build()

                modalList.onValueSelected = { _, value in
                    if value.title == "Ver todos" {
                        let values = self.parameters.values.compactMap { value in
                            Ocean.CellModel(title: value, isSelected: self.parameters.text == value)
                        }
                        let filterViewController = Ocean.FilterViewController(title: self.parameters.titleModal,
                                                                              placeholder: self.parameters.placeholderFilter,
                                                                              values: values)
                        filterViewController.onValueSelected = { filterValue in
                            self.parameters.text = filterValue.title
                            self.parameters.onValueChanged(self.parameters.text)
                        }
                        let navigationController = UINavigationController(rootViewController: filterViewController)
                        navigationController.modalTransitionStyle = .coverVertical
                        navigationController.modalPresentationStyle = .overFullScreen
                        rootViewController.present(navigationController, animated: true, completion: nil)
                    } else {
                        self.parameters.text = value.title
                        self.parameters.onValueChanged(self.parameters.text)
                    }
                }

                modalList.show()
            }
        }
    }
}
