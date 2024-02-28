//
//  StepSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 28/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class StepSwiftUIViewController: UIViewController {
    lazy var step1: OceanSwiftUI.Step = {
        OceanSwiftUI.Step { step in
            step.parameters.steps = 5
            step.parameters.currentStep = 1
        }
    }()

    lazy var step2: OceanSwiftUI.Step = {
        OceanSwiftUI.Step { step in
            step.parameters.steps = 5
            step.parameters.currentStep = 2
        }
    }()

    lazy var step3: OceanSwiftUI.Step = {
        OceanSwiftUI.Step { step in
            step.parameters.steps = 5
            step.parameters.currentStep = 3
        }
    }()

    lazy var step4: OceanSwiftUI.Step = {
        OceanSwiftUI.Step { step in
            step.parameters.steps = 5
            step.parameters.currentStep = 4
        }
    }()

    lazy var step5: OceanSwiftUI.Step = {
        OceanSwiftUI.Step { step in
            step.parameters.steps = 5
            step.parameters.currentStep = 5
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            step1
            step2
            step3
            step4
            step5
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
struct StepSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            StepSwiftUIViewController()
        }
    }
}
