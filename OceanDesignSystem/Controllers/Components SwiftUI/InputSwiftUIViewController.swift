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
    lazy var inputSearchField: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.searchField { input in
            input.parameters.placeholder = "Placeholder"
        }
    }()

    lazy var inputTextField1: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textField { input in
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
        OceanSwiftUI.Input.textField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.iconHelper = Ocean.icon.infoSolid
            input.parameters.onTouchIconHelper = {
                print("icon tapped")
            }
        }
    }()

    lazy var inputTextFieldWithSkeleton: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.iconHelper = Ocean.icon.infoSolid
            input.parameters.showSkeleton = true
            input.parameters.onTouchIconHelper = {
                print("icon tapped")
            }
        }
    }()

    lazy var inputTextField3: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textField { input in
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
        OceanSwiftUI.Input.textField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.text = "Text"
            input.parameters.isDisabled = true
        }
    }()

    lazy var inputTextField5: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textArea { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.maxLength = 140
            input.parameters.showMaxLength = true
            input.parameters.onValueChanged = { value in
                print(value)
            }
        }
    }()

    lazy var inputTextField6: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.errorMessage = "Error message colorStatusNegativeUp"
            input.parameters.errorMessageColor = Ocean.color.colorStatusNegativeUp
            input.parameters.onValueChanged = { _ in
                input.parameters.errorMessage = "New error message"
            }
        }
    }()
    
    lazy var inputTextField7: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.errorMessage = "Error message colorStatusNegativeUp"
            input.parameters.errorMessageColor = Ocean.color.colorBrandPrimaryDown
            input.parameters.onValueChanged = { _ in
                input.parameters.errorMessage = "New error message"
            }
        }
    }()
    
    lazy var inputSelectField: OceanSwiftUI.InputSelectField = {
        OceanSwiftUI.Input.selectField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.rootViewController = self
            input.parameters.titleModal = "Title"
            input.parameters.placeholderFilter = "Digite o texto para filtrar"
            input.parameters.maxValues = 5
            input.parameters.values = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7", "Label 8", "Label 9", "Label 10", "Label 11", "Label 12", "Label 13", "Label 14", "Label 15", "Label 16", "Label 17", "Label 18", "Label 19", "Label 20", "Label 21", "Label 22", "Label 23", "Label 24", "Label 25"]
            input.parameters.onValueChanged = { value in
                print(value)
            }
        }
    }()

    lazy var inputSelectFieldWithSkeleton: OceanSwiftUI.InputSelectField = {
        OceanSwiftUI.Input.selectField { input in
            input.parameters.title = ""
            input.parameters.placeholder = "Placeholder"
            input.parameters.rootViewController = self
            input.parameters.values = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7", "Label 8", "Label 9", "Label 10", "Label 11", "Label 12", "Label 13", "Label 14", "Label 15", "Label 16", "Label 17", "Label 18", "Label 19", "Label 20", "Label 21", "Label 22", "Label 23", "Label 24", "Label 25"]
            input.parameters.showSkeleton = true
            input.parameters.onValueChanged = { value in
                print(value)
            }
        }
    }()

    lazy var inputTokenField: OceanSwiftUI.InputTokenField = {
        OceanSwiftUI.Input.tokenField { input in
            input.parameters.title = "Title"
            input.parameters.onValueChanged = { value in
                print(value)
            }
        }
    }()

    lazy var inputTextFieldWithMaxLength: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.Input.textField { input in
            input.parameters.title = "Title"
            input.parameters.text = "Text"
            input.parameters.maxLength = 10
            input.parameters.showMaxLength = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            inputSearchField
            inputTextField1
            inputTextField2
            inputTextFieldWithSkeleton
            inputTextField3
            inputTextField4
            inputTextField5
            inputSelectField
            inputSelectFieldWithSkeleton
            inputTokenField
            inputTextFieldWithMaxLength
            inputTextField6
            inputTextField7
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
