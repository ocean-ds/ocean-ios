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

    lazy var fluidButton1: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Primary Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton2: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryMD { button in
            button.parameters.text = "Secondary Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton3: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.tertiaryMD { button in
            button.parameters.text = "Tertiary Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton4: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryCriticalMD { button in
            button.parameters.text = "Primary Critical Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton5: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryCriticalMD { button in
            button.parameters.text = "Secondary Critical Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton6: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.tertiaryCriticalMD { button in
            button.parameters.text = "Tertiary Critical Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton7: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryWarningMD { button in
            button.parameters.text = "Primary Warning Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton8: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryWarningMD { button in
            button.parameters.text = "Secondary Warning Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var fluidButton9: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.tertiaryWarningMD { button in
            button.parameters.text = "Tertiary Warning Fluid"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var hugPrimaryButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Primary Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var hugPrimaryCriticalButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryCriticalMD { button in
            button.parameters.text = "Primary Critical Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var hugPrimaryWarningButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryWarningMD { button in
            button.parameters.text = "Primary Warning Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var hugSecondaryButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryMD { button in
            button.parameters.text = "Secondary Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var hugSecondaryCriticalButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryCriticalMD { button in
            button.parameters.text = "Secondary Critical Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var hugSecondaryWarningButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryWarningMD { button in
            button.parameters.text = "Secondary Warning Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var hugTertiaryButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.tertiaryMD { button in
            button.parameters.text = "Tertiary Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var hugTertiaryCriticalButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.tertiaryCriticalMD { button in
            button.parameters.text = "Tertiary Critical Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var hugTertiaryWarningButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.tertiaryWarningMD { button in
            button.parameters.text = "Tertiary Warning Hug"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.widthMode = .hug
            button.parameters.onTouch = {
                print("Tap")
            }
        }
    }()

    lazy var disabledButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Disabled"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.isDisabled = true
        }
    }()

    lazy var skeletonButton: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Skeleton"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.showSkeleton = true
        }
    }()

    // MARK: - View Setup

    public lazy var hostingController: UIHostingController<AnyView> = {
        let content = AnyView(
            ScrollView {
                VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {

                    Text("FLUID MODE")
                        .font(.headline)
                        .padding(.top, Ocean.size.spacingStackMd)

                    Text("Background escurece ao pressionar o botão")
                        .font(.caption)
                        .foregroundColor(.gray)

                    VStack(spacing: Ocean.size.spacingStackXs) {
                        fluidButton1
                        fluidButton2
                        fluidButton3
                        fluidButton4
                        fluidButton5
                        fluidButton6
                        fluidButton7
                        fluidButton8
                        fluidButton9
                    }

                    Divider()
                        .padding(.vertical, Ocean.size.spacingStackMd)

                    Text("HUG MODE - PRIMARY")
                        .font(.headline)

                    Text("Com padding | Cor do texto muda ao pressionar")
                        .font(.caption)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                        hugPrimaryButton
                        hugPrimaryCriticalButton
                        hugPrimaryWarningButton
                    }

                    Divider()
                        .padding(.vertical, Ocean.size.spacingStackMd)

                    Text("HUG MODE - SECONDARY")
                        .font(.headline)

                    Text("Com padding | Cor do texto muda ao pressionar")
                        .font(.caption)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                        hugSecondaryButton
                        hugSecondaryCriticalButton
                        hugSecondaryWarningButton
                    }

                    Divider()
                        .padding(.vertical, Ocean.size.spacingStackMd)

                    Text("HUG MODE - TERTIARY")
                        .font(.headline)

                    Text("SEM padding | SEM loading | Cor do texto muda ao pressionar")
                        .font(.caption)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                        hugTertiaryButton
                        hugTertiaryCriticalButton
                        hugTertiaryWarningButton
                    }

                    Divider()
                        .padding(.vertical, Ocean.size.spacingStackMd)

                    Text("Disabled + Skeleton")
                        .font(.headline)

                    VStack(spacing: Ocean.size.spacingStackXs) {
                        disabledButton
                        skeletonButton
                    }
                }
                .padding(.horizontal, Ocean.size.spacingStackXs)
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
}

@available(iOS 13.0, *)
struct ButtonSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ButtonSwiftUIViewController()
        }
    }
}
