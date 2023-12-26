//
//  BadgeSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 13/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class BadgeSwiftUIViewController: UIViewController {
    lazy var badge1: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.primaryMd { badge in
            badge.parameters.count = 9
        }
    }()

    lazy var badge2: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.primaryInvertedMd { badge in
            badge.parameters.count = 9
        }
    }()

    lazy var badge3: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.warningMd { badge in
            badge.parameters.count = 9
        }
    }()

    lazy var badge4: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.highlightMd { badge in
            badge.parameters.count = 9
        }
    }()

    lazy var badge5: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.disabledMd { badge in
            badge.parameters.count = 9
        }
    }()

    lazy var badge6: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.dot { badge in
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([

        ])

        stack.setMargins(allMargins: Ocean.size.spacingStackXs)

        return stack
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            self.badge1
            self.badge2
            self.badge3
            self.badge4
            self.badge5
            self.badge6
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
