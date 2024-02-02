//
//  InputSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

final public class InputSwiftUIViewController : UIViewController {
    lazy var inputTextField1: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.icon = Ocean.icon.eyeOutline
            input.parameters.onTouchIcon = {
                print("icon tapped")
                input.parameters.style = input.parameters.style == .input ? .secureText : .input
                if input.parameters.style == .input {
                    input.parameters.icon = Ocean.icon.eyeOutline
                } else {
                    input.parameters.icon = Ocean.icon.eyeOffOutline
                }
            }
        }
    }()

    lazy var inputTextField2: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.iconHelper = Ocean.icon.infoSolid
            input.parameters.onTouchIconHelper = {
                print("icon tapped")
            }
        }
    }()

    lazy var inputTextField3: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.errorMessage = "Error message"
            input.parameters.onValueChanged = { _ in
                input.parameters.errorMessage = "New error message"
            }
        }
    }()

    lazy var inputTextField4: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.isDisabled = true
        }
    }()

    lazy var inputTextField5: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.style = .textArea
            input.parameters.maxLenght = 140
            input.parameters.showMaxLenght = true
            input.parameters.onValueChanged = { value in
                print(value)
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            inputTextField1
            inputTextField2
            inputTextField3
            inputTextField4
            inputTextField5
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
struct InputSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            InputSwiftUIViewController()
        }
    }
}
