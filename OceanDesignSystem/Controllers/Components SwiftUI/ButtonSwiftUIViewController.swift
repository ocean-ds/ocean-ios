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
    lazy var button1: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button2: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button3: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.textMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button4: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryCriticalMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button5: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryCriticalMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button6: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.textCriticalMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button7: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryInverseMD { button in
            button.parameters.text = "Avançar"
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

    lazy var button8: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.isDisabled = true
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button9: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.showSkeleton = true
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            button1
            button2
            button3
            button4
            button5
            button6
            button7
            button8
            button9
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

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
