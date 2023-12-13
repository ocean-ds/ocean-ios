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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

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
            badge1.uiView,
            badge2.uiView,
            badge3.uiView,
            badge4.uiView,
            badge5.uiView,
            badge6.uiView
        ])

        stack.setMargins(allMargins: Ocean.size.spacingStackXs)

        return stack
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        setupConstraints()
    }

    private func setupConstraints() {
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
            .make()

        mainStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: view)
            .make()
    }
}
