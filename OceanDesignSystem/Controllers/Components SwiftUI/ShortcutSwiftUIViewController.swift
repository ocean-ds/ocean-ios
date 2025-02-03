//
//  ShortcutSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 10/05/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class ShortcutSwiftUIViewController: UIViewController {
    private var examples: [OceanSwiftUI.ShortcutModel] = [
        OceanSwiftUI.ShortcutModel(icon: Ocean.icon.documentOutline,
                                   badgeNumber: nil,
                                   badgeStatus: .disabled,
                                   title: "Label Label Label",
                                   subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                                   blocked: false),
        OceanSwiftUI.ShortcutModel(icon: Ocean.icon.documentOutline,
                                   badgeNumber: 0,
                                   badgeStatus: .disabled,
                                   title: "Label",
                                   subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                                   blocked: false),
        OceanSwiftUI.ShortcutModel(icon: Ocean.icon.documentOutline,
                                   badgeNumber: 1,
                                   badgeStatus: .warning,
                                   title: "Label",
                                   subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                                   blocked: false),
        OceanSwiftUI.ShortcutModel(icon: Ocean.icon.documentOutline,
                                   badgeNumber: 1,
                                   badgeStatus: .warning,
                                   tagLabel: "Novo",
                                   title: "Label",
                                   subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                                   blocked: false),
        OceanSwiftUI.ShortcutModel(icon: Ocean.icon.documentOutline,
                                   badgeNumber: nil,
                                   badgeStatus: .warning,
                                   title: "Label",
                                   subtitle: "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur.",
                                   blocked: true)
    ]

    lazy var shortcut1: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.size = .tiny
            view.parameters.orientation = .vertical
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut2: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.size = .tiny
            view.parameters.orientation = .horizontal
            view.parameters.cols = 3
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut3: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.size = .small
            view.parameters.orientation = .vertical
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut4: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.size = .medium
            view.parameters.orientation = .vertical
            view.parameters.cols = 3
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut5: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.size = .medium
            view.parameters.orientation = .horizontal
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut6: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.showSkeleton = true
        }
    }()

    lazy var shortcut7: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.displayMode = .inline
            view.parameters.size = .medium
            view.parameters.orientation = .horizontal
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut8: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.displayMode = .inline
            view.parameters.size = .small
            view.parameters.orientation = .horizontal
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut9: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.displayMode = .inline
            view.parameters.size = .tiny
            view.parameters.orientation = .horizontal
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut10: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.displayMode = .inline
            view.parameters.size = .medium
            view.parameters.orientation = .vertical
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()


    lazy var shortcut11: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.displayMode = .inline
            view.parameters.size = .small
            view.parameters.orientation = .vertical
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut12: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.items = examples
            view.parameters.displayMode = .inline
            view.parameters.size = .tiny
            view.parameters.orientation = .vertical
            view.parameters.onTouch = { index, item in
                print("\(index): \(item.title)")
            }
        }
    }()

    lazy var shortcut13: OceanSwiftUI.Shortcut = {
        OceanSwiftUI.Shortcut { view in
            view.parameters.displayMode = .inline
            view.parameters.showSkeleton = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackSm) {
            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Tiny - Vertical"
                }

                shortcut1
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Tiny - Horizontal"
                }

                shortcut2
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Small - Vertical"
                }

                shortcut3
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Medium - Vertical"
                }

                shortcut4
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Medium - Horizontal"
                }

                shortcut5
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Skeleton"
                }

                shortcut6
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Medium - Horizontal - Display Inline"
                }

                shortcut7
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Small - Horizontal - Display Inline"
                }

                shortcut8
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Tiny - Horizontal - Display Inline"
                }

                shortcut9
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Medium - Vertical - Display Inline"
                }

                shortcut10
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Small - Vertical - Display Inline"
                }

                shortcut11
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Tiny - Vertical - Display Inline"
                }

                shortcut12
            }

            VStack(spacing: Ocean.size.spacingStackXs) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = "Skeleton - Display Inline"
                }

                shortcut13
            }
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
struct ShortcutSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ShortcutSwiftUIViewController()
        }
    }
}
