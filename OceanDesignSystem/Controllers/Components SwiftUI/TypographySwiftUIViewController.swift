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
            view.parameters.text = "heading4 <b>heading4</b>"
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

    lazy var typography12: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.text = "strikethrough"
            view.parameters.strikethrough = true
        }
    }()

    lazy var typography13: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.skeletonSize = .small
            view.parameters.showSkeleton = true
        }
    }()

    lazy var typography14: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.skeletonSize = .medium
            view.parameters.showSkeleton = true
        }
    }()

    lazy var typography15: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.skeletonSize = .large
            view.parameters.showSkeleton = true
        }
    }()

    lazy var typography16: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.skeletonSize = .large2x
            view.parameters.showSkeleton = true
        }
    }()

    lazy var typography17: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.skeletonSize = .large3x
            view.parameters.showSkeleton = true
        }
    }()

    lazy var typography18: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading1 { view in
            view.parameters.showSkeleton = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            typography1
            typography2
            typography3
            typography4
            typography5
            typography6
            typography7
            typography8
            typography9
            typography10
            typography11
            typography12
            typography13
            typography14
            typography15
            typography16
            typography17
            typography18
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
struct TypographySwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TypographySwiftUIViewController()
        }
    }
}
