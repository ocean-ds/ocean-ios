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

    let subtitleText = "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur."

    lazy var shortcut1: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.direction = .vertical
        view.size = .tiny
        view.orientation = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var shortcut2: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.direction = .vertical
        view.size = .tiny
        view.orientation = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shortcut3: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.direction = .vertical
        view.size = .small
        view.orientation = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shortcut5: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.direction = .vertical
        view.size = .medium
        view.orientation = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shortcut6: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.direction = .vertical
        view.size = .medium
        view.orientation = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
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
            .width(to: self.view)
            .make()

        addSection(stackView: contentStack, text: "Tiny - Vertical")
        contentStack.addArrangedSubview(shortcut1)
        addSection(stackView: contentStack, text: "Tiny - Horizontal")
        contentStack.addArrangedSubview(shortcut2)
        addSection(stackView: contentStack, text: "Small - Vertical")
        contentStack.addArrangedSubview(shortcut3)
        addSection(stackView: contentStack, text: "Medium - Vertical")
        contentStack.addArrangedSubview(shortcut5)
        addSection(stackView: contentStack, text: "Medium - Horizontal")
        contentStack.addArrangedSubview(shortcut6)
        
        shortcut1.onTouch = { index in
            print(index)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Tiny - Vertical
        shortcut1.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label")
        ], quantityPage: 2)

        // Tiny - Horizontal
        shortcut2.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label")
        ], quantityPage: 2)

        // Small - Vertical
        shortcut3.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label", subtitle: subtitleText)
        ], quantityPage: 2)

        // Medium - Vertical
        shortcut5.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label", subtitle: subtitleText)
        ], quantityPage: 2)

        // Medium - Horizontal
        shortcut6.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: subtitleText),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label", subtitle: subtitleText)
        ], quantityPage: 2)
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
