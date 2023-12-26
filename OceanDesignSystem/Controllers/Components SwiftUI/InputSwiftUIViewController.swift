//
//  InputSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
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
            }
            input.parameters.onValueChanged = { text in
                print(text)
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
            input.parameters.onValueChanged = { text in
                print(text)
            }
        }
    }()

    lazy var inputTextField3: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.errorMessage = "Error message"
            input.parameters.onValueChanged = { text in
                print(text)
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView:
        ScrollView {
            VStack {
                inputTextField1
                inputTextField2
                inputTextField3
            }
        }
    )

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}
