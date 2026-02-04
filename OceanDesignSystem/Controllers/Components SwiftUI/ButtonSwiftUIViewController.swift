//
//  ButtonSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 18/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class ButtonSwiftUIViewController: UIViewController {

    @Published private var selectedSize: OceanSwiftUI.ButtonParameters.Size = .medium
    @Published private var selectedStyle: OceanSwiftUI.ButtonParameters.Style = .primary
    @Published private var hasIcon: Bool = true
    @Published private var isFluidWidth: Bool = true
    @Published private var isDisabled: Bool = false
    @Published private var isLoading: Bool = false
    @Published private var showSkeleton: Bool = false

    lazy var configButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button { button in
            button.parameters.text = "Button Example"
            button.parameters.icon = self.hasIcon ? Ocean.icon.plusSolid : nil
            button.parameters.style = self.selectedStyle
            button.parameters.size = self.selectedSize
            button.parameters.maxWidth = self.isFluidWidth ? .infinity : nil
            button.parameters.isDisabled = self.isDisabled
            button.parameters.isLoading = self.isLoading
            button.parameters.showSkeleton = self.showSkeleton
            button.parameters.onTouch = {
                print("Tapped")
            }
        }
    }()

    // MARK: - View Setup

    public lazy var hostingController: UIHostingController<AnyView> = {
        let content = AnyView(
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                    if self.isFluidWidth {
                        configButton
                    } else {
                        HStack {
                            configButton
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, Ocean.size.spacingStackMd)
                .padding(.vertical, Ocean.size.spacingStackMd)
                .background(Color(UIColor.systemBackground))

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Size")
                                .font(.headline)

                            Picker("Button Size", selection: Binding(
                                get: { self.selectedSize },
                                set: { newSize in
                                    self.selectedSize = newSize
                                    self.updateButton()
                                }
                            )) {
                                Text("Small (32)").tag(OceanSwiftUI.ButtonParameters.Size.small)
                                Text("Medium (48)").tag(OceanSwiftUI.ButtonParameters.Size.medium)
                                Text("Large (56)").tag(OceanSwiftUI.ButtonParameters.Size.large)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxs)

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Style")
                                .font(.headline)

                            Picker("Button Style", selection: Binding(
                                get: { self.selectedStyle },
                                set: { newStyle in
                                    self.selectedStyle = newStyle
                                    self.updateButton()
                                }
                            )) {
                                Text("Primary").tag(OceanSwiftUI.ButtonParameters.Style.primary)
                                Text("Secondary").tag(OceanSwiftUI.ButtonParameters.Style.secondary)
                                Text("Tertiary").tag(OceanSwiftUI.ButtonParameters.Style.tertiary)
                                Text("Primary Critical").tag(OceanSwiftUI.ButtonParameters.Style.primaryCritical)
                                Text("Secondary Critical").tag(OceanSwiftUI.ButtonParameters.Style.secondaryCritical)
                                Text("Tertiary Critical").tag(OceanSwiftUI.ButtonParameters.Style.tertiaryCritical)
                                Text("Primary Inverse").tag(OceanSwiftUI.ButtonParameters.Style.primaryInverse)
                                Text("Primary Warning").tag(OceanSwiftUI.ButtonParameters.Style.primaryWarning)
                                Text("Secondary Warning").tag(OceanSwiftUI.ButtonParameters.Style.secondaryWarning)
                                Text("Tertiary Warning").tag(OceanSwiftUI.ButtonParameters.Style.tertiaryWarning)
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)
                            .clipped()
                        }
                        .padding(.bottom, Ocean.size.spacingStackXxs)

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Options")
                                .font(.headline)

                            Toggle("Has Icon", isOn: Binding(
                                get: { self.hasIcon },
                                set: { newValue in
                                    self.hasIcon = newValue
                                    self.updateButton()
                                }
                            ))

                            Toggle("Fluid", isOn: Binding(
                                get: { self.isFluidWidth },
                                set: { newValue in
                                    self.isFluidWidth = newValue
                                    self.updateButton()
                                }
                            ))

                            Toggle("Loading", isOn: Binding(
                                get: { self.isLoading },
                                set: { newValue in
                                    self.isLoading = newValue
                                    self.updateButton()
                                }
                            ))

                            Toggle("Disabled", isOn: Binding(
                                get: { self.isDisabled },
                                set: { newValue in
                                    self.isDisabled = newValue
                                    self.updateButton()
                                }
                            ))

                            Toggle("Show Skeleton", isOn: Binding(
                                get: { self.showSkeleton },
                                set: { newValue in
                                    self.showSkeleton = newValue
                                    self.updateButton()
                                }
                            ))
                        }
                    }
                    .padding(.horizontal, Ocean.size.spacingStackMd)
                    .padding(.vertical, Ocean.size.spacingStackXs)
                }
            }
        )
        return UIHostingController(rootView: content)
    }()

    public lazy var uiView: UIView = {
        return self.hostingController.getUIView()
    }()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(uiView)
        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }

    private func updateButton() {
        configButton.parameters.size = selectedSize
        configButton.parameters.style = selectedStyle
        configButton.parameters.icon = hasIcon ? Ocean.icon.plusSolid : nil
        configButton.parameters.maxWidth = isFluidWidth ? .infinity : nil
        configButton.parameters.isLoading = isLoading
        configButton.parameters.isDisabled = isDisabled
        configButton.parameters.showSkeleton = showSkeleton
    }
}

@available(iOS 13.0, *)
struct ButtonSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ButtonSwiftUIViewController()
        }
    }
}
