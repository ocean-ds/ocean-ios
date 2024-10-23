//
//  ShortcutViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 23/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class ShortcutViewController : UIViewController {
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.oceanConstraints
            .fill(to: view, constant: Ocean.size.spacingInsetSm, safeArea: true)
            .make()

        let contentStack = Ocean.StackView { stackView in
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = Ocean.size.spacingStackXxs
        }
        scrollView.addSubview(contentStack)
        contentStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: view, constant: -(Ocean.size.spacingInsetSm * 2))
            .make()

        addSection(stackView: contentStack, text: "Tiny - Vertical")
        addExample(stack: contentStack,
                   orientation: .vertical,
                   size: .tiny)
        addSection(stackView: contentStack, text: "Tiny - Horizontal")
        addExample(stack: contentStack,
                   orientation: .horizontal,
                   size: .tiny,
                   cols: 3)
        addSection(stackView: contentStack, text: "Small - Vertical")
        addExample(stack: contentStack,
                   orientation: .vertical,
                   size: .small)
        addSection(stackView: contentStack, text: "Medium - Vertical")
        addExample(stack: contentStack,
                   orientation: .vertical,
                   size: .medium,
                   cols: 3)
        addSection(stackView: contentStack, text: "Medium - Horizontal")
        addExample(stack: contentStack,
                   orientation: .horizontal,
                   size: .medium)
    }

    private var examples: [Ocean.ShortcutModel] = [
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            tagLabel: "Novo",
                            badgeNumber: nil,
                            badgeStatus: .neutral,
                            title: "Label",
                            subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                            blocked: false),
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: 0,
                            badgeStatus: .neutral,
                            title: "Label",
                            subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                            blocked: false),
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: 1,
                            badgeStatus: .highlight,
                            title: "Label",
                            subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                            blocked: false),
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: nil,
                            badgeStatus: .highlight,
                            title: "Label",
                            subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                            blocked: true)
    ]

    public func addExample(stack: UIStackView,
                           orientation: Ocean.Shortcut.Orientation,
                           size: Ocean.Shortcut.Size,
                           cols: Int = 2) {

        let view = Ocean.Shortcut()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.orientation = orientation
        view.size = size
        view.set(data: examples, cols: cols)
        view.onTouch = { index in
            print(index)
        }

        stack.addArrangedSubview(view)
    }

    private func addSection(stackView: Ocean.StackView, text: String, includeSpacer: Bool = true) {
        let label = Ocean.Typography.description { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.numberOfLines = 0
        }.addMargins(horizontal: Ocean.size.spacingStackXs)
        label.isSkeletonable = false

        if includeSpacer {
            stackView.add([
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                label
            ])
        } else {
            stackView.add([
                label
            ])
        }
    }
}
