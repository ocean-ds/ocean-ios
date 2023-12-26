//
//  TypographySwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 23/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TypographySwiftUIViewController: UIViewController {
    lazy var typography1: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading1 { view in
            view.parameters.text = "heading1"
        }
    }()

    lazy var typography2: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading2 { view in
            view.parameters.text = "heading2"
        }
    }()

    lazy var typography3: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading3 { view in
            view.parameters.text = "heading3"
        }
    }()

    lazy var typography4: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading4 { view in
            view.parameters.text = "heading4"
        }
    }()

    lazy var typography5: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading5 { view in
            view.parameters.text = "heading5"
        }
    }()

    lazy var typography6: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.subTitle1 { view in
            view.parameters.text = "subTitle1"
        }
    }()

    lazy var typography7: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.subTitle2 { view in
            view.parameters.text = "subTitle2"
        }
    }()

    lazy var typography8: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.paragraph { view in
            view.parameters.text = "paragraph"
        }
    }()

    lazy var typography9: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.lead { view in
            view.parameters.text = "lead"
        }
    }()

    lazy var typography10: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.description { view in
            view.parameters.text = "description"
        }
    }()

    lazy var typography11: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.text = "caption"
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            self.typography1
            self.typography2
            self.typography3
            self.typography4
            self.typography5
            self.typography6
            self.typography7
            self.typography8
            self.typography9
            self.typography10
            self.typography11
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
