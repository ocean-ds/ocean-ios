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

    lazy var badge7: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.primaryMd { badge in
            badge.parameters.count = 1
            badge.parameters.showSkeleton = true
        }
    }()

    lazy var badge8: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.primarySm { badge in
            badge.parameters.count = 1
            badge.parameters.showSkeleton = true
        }
    }()

    lazy var badge9: OceanSwiftUI.Badge = {
        return OceanSwiftUI.Badge.dot { badge in
            badge.parameters.count = 1
            badge.parameters.showSkeleton = true
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
            badge1
            badge2
            badge3
            badge4
            badge5
            badge6
            badge7
            badge8
            badge9
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
struct BadgeSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            BadgeSwiftUIViewController()
        }
    }
}
