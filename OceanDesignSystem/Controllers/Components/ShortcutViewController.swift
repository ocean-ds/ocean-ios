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

    let subtitleTextTiny = "Lorem ipsum"
    let subtitleTextSmall = "Lorem ipsum dolor sit amet, consectetur."
    let subtitleTextMedium = "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur."

//    private lazy var shortcut1: Ocean.NewShortcut = {
//        let view = Ocean.NewShortcut()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.size = .tiny
//        view.orientation = .vertical
//
//        return view
//    }()
//
//    private lazy var shortcut2: Ocean.NewShortcut = {
//        let view = Ocean.NewShortcut()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.size = .tiny
//        view.orientation = .horizontal
//
//        return view
//    }()
//
//    private lazy var shortcut3: Ocean.NewShortcut = {
//        let view = Ocean.NewShortcut()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.size = .small
//        view.orientation = .vertical
//
//        return view
//    }()
//
//    private lazy var shortcut4: Ocean.NewShortcut = {
//        let view = Ocean.NewShortcut()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.size = .small
//        view.orientation = .horizontal
//
//        return view
//    }()
//
//    private lazy var shortcut5: Ocean.NewShortcut = {
//        let view = Ocean.NewShortcut()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.size = .medium
//        view.orientation = .vertical
//
//        return view
//    }()
//
//    private lazy var shortcut6: Ocean.NewShortcut = {
//        let view = Ocean.NewShortcut()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.size = .medium
//        view.orientation = .horizontal
//
//        return view
//    }()
    
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

//        addSection(stackView: contentStack, text: "Tiny - Vertical")
//        contentStack.addArrangedSubview(shortcut1)
//        addSection(stackView: contentStack, text: "Tiny - Horizontal")
//        contentStack.addArrangedSubview(shortcut2)
//        addSection(stackView: contentStack, text: "Small - Vertical")
//        contentStack.addArrangedSubview(shortcut3)
//        addSection(stackView: contentStack, text: "Small - Horizontal")
//        contentStack.addArrangedSubview(shortcut4)
//        addSection(stackView: contentStack, text: "Medium - Vertical")
//        contentStack.addArrangedSubview(shortcut5)
//        addSection(stackView: contentStack, text: "Medium - Horizontal")
//        contentStack.addArrangedSubview(shortcut6)

//        addExample(badgeNumber: 1,
//                   title: subtitleTextTiny,
//                   subtitle: subtitleTextTiny,
//                   blocked: false)
//
//        addExample(badgeNumber: 1,
//                   title: subtitleTextTiny,
//                   subtitle: subtitleTextTiny,
//                   blocked: false)
//
//        addExample(badgeNumber: 1,
//                   title: subtitleTextSmall,
//                   subtitle: subtitleTextSmall,
//                   blocked: false)
//
//        addExample(badgeNumber: 1,
//                   title: subtitleTextMedium,
//                   subtitle: subtitleTextMedium,
//                   blocked: false)
//
//        addExample(badgeNumber: 1,
//                   title: subtitleTextMedium,
//                   subtitle: subtitleTextMedium,
//                   blocked: false)

//        shortcut1.setData(with: examples, cols: 2)
//        shortcut2.setData(with: examples, cols: 2)
//        shortcut3.setData(with: examples, cols: 2)
//        shortcut4.setData(with: examples, cols: 2)
//        shortcut5.setData(with: examples, cols: 2)
//        shortcut6.setData(with: examples, cols: 2)

//        addSection(stackView: contentStack, text: "Tiny - Vertical")
//        contentStack.addArrangedSubview(shortcut1)
//        addSection(stackView: contentStack, text: "Tiny - Horizontal")
//        contentStack.addArrangedSubview(shortcut2)
//        addSection(stackView: contentStack, text: "Small - Vertical")
//        contentStack.addArrangedSubview(shortcut3)
//        addSection(stackView: contentStack, text: "Medium - Vertical")
//        contentStack.addArrangedSubview(shortcut5)
//        addSection(stackView: contentStack, text: "Medium - Horizontal")
//        contentStack.addArrangedSubview(shortcut6)
//        addSection(stackView: contentStack, text: "Carousel")
//        contentStack.addArrangedSubview(shortcut7)
//
//        shortcut1.onTouch = { index in
//            print(index)
//        }

        addSection(stackView: contentStack, text: "Tiny - Vertical")
        addExample(stack: contentStack,
                   orientation: .vertical,
                   size: .tiny)
        addSection(stackView: contentStack, text: "Tiny - Horizontal")
        addExample(stack: contentStack,
                   orientation: .horizontal,
                   size: .tiny)
        addSection(stackView: contentStack, text: "Small - Vertical")
        addExample(stack: contentStack,
                   orientation: .vertical,
                   size: .small)
        addSection(stackView: contentStack, text: "Medium - Vertical")
        addExample(stack: contentStack,
                   orientation: .vertical,
                   size: .medium)
        addSection(stackView: contentStack, text: "Medium - Horizontal")
        addExample(stack: contentStack,
                   orientation: .horizontal,
                   size: .medium)
    }

    private var examples: [Ocean.ShortcutModel] = [
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: nil,
                            badgeStatus: .neutral,
                            title: "Label",
                            subtitle: "",
                            blocked: false),
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: 0,
                            badgeStatus: .neutral,
                            title: "Label",
                            subtitle: "",
                            blocked: false),
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: 1,
                            badgeStatus: .highlight,
                            title: "Label",
                            subtitle: "",
                            blocked: false),
        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
                            badgeNumber: nil,
                            badgeStatus: .highlight,
                            title: "Label",
                            subtitle: "",
                            blocked: true),

        Ocean.ShortcutModel(image: Ocean.icon.documentOutline,
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
                           orientation: Ocean.NewShortcut.Orientation,
                           size: Ocean.NewShortcut.Size) {
//        let model: Ocean.ShortcutModel = .init(image: Ocean.icon.documentOutline,
//                                               badgeNumber: badgeNumber,
//                                               badgeStatus: (badgeNumber ?? 0) > 0 ? .highlight : .neutral,
//                                               title: title,
//                                               subtitle: subtitle,
//                                               blocked: blocked)
//
//        examples.append(model)

        let view = Ocean.NewShortcut()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.orientation = orientation
        view.size = size
        view.set(data: examples, cols: 2)
        view.onTouch = { index in
            print(index)
        }

        stack.addArrangedSubview(view)
    }
    
//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        // Tiny - Vertical
//        shortcut1.addData(with: [
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label")
//        ], quantityPage: 2)
//
//        // Tiny - Horizontal
//        shortcut2.addData(with: [
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label")
//        ], quantityPage: 2)
//
//        // Small - Vertical
//        shortcut3.addData(with: [
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label", subtitle: subtitleText)
//        ], quantityPage: 2)
//
//        // Medium - Vertical
//        shortcut5.addData(with: [
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label", subtitle: subtitleText)
//        ], quantityPage: 2)
//
//        // Medium - Horizontal
//        shortcut6.addData(with: [
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: subtitleText),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label", subtitle: subtitleText)
//        ], quantityPage: 2)
//
//        // Carousel
//        shortcut7.addData(with: [
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
//            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 100, badgeStatus: .highlight, title: "Label")
//        ], quantityPage: 2)
//    }
//
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
