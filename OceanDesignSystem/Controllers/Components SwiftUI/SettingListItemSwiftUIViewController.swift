//
//  SettingListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 18/06/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import SwiftUI

class SettingListItemSwiftUIViewController: UIViewController {
    lazy var view1: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Unchanged Primary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Unchanged Primary touched") }
            view.parameters.type = .unchangedPrimary
        }
    }()

    lazy var view2: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Unchanged Secondary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Unchanged Secondary touched") }
            view.parameters.type = .unchangedSecondary
        }
    }()
    
    lazy var view3: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Unchanged Tertiary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Unchanged Secondary touched") }
            view.parameters.type = .unchangedTertiary
        }
    }()

    lazy var view4: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Unchanged Blocked"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.type = .unchangedBlocked
        }
    }()

    lazy var view5: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Pending"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.tagTitle = "Label"
            view.parameters.type = .pending
        }
    }()

    lazy var view6: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Changed Primary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Changed Primary touched") }
            view.parameters.type = .changedPrimary
        }
    }()

    lazy var view7: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Changed Secondary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Changed Secondary touched") }
            view.parameters.type = .changedSecondary
        }
    }()
    
    lazy var view8: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Changed Tertiary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Changed Secondary touched") }
            view.parameters.type = .changedTertiary
        }
    }()

    lazy var view9: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Changed Blocked"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.hasDivider = true
            view.parameters.type = .changedBlocked
        }
    }()

    lazy var view10: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Unchanged Primary"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonAction = { print("Unchanged Primary touched") }
            view.parameters.type = .unchangedPrimary
            view.parameters.showSkeleton = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            view1
            view2
            view3
            view4
            view5
            view6
            view7
            view8
            view9
            view10
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct SettingListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SettingListItemSwiftUIViewController()
        }
    }
}

