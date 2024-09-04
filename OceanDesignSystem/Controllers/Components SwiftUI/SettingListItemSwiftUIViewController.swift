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
    lazy var view0: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title"
            view.parameters.description = "R$ 100,00"
            view.parameters.newDescription = "Zero"
            view.parameters.descriptionColor = Ocean.color.colorStatusPositiveDown
            view.parameters.buttonTitle = "Label"
            view.parameters.type = .button
            view.parameters.buttonAction = { print("touched") }
        }
    }()    

    lazy var view1: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title Inverted"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.isInverted = true
            view.parameters.type = .button
            view.parameters.buttonStyle = .warning
            view.parameters.buttonAction = { print("touched") }
        }
    }()

    lazy var view2: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.buttonTitle = "Label"
            view.parameters.buttonStyle = .tertiaryCritical
            view.parameters.type = .button
            view.parameters.buttonAction = { print("touched") }
        }
    }()
    
    lazy var view3: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.errorMessage = "Error message"
            view.parameters.buttonTitle = "Label"
            view.parameters.type = .button
            view.parameters.buttonStyle = .tertiary
            view.parameters.buttonAction = { print("Title") }
        }
    }()

    lazy var view4: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.type = .blocked
        }
    }()

    lazy var view5: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.tagTitle = "Label"
            view.parameters.type = .tag
        }
    }()

    lazy var view6: OceanSwiftUI.SettingListItem = {
        return OceanSwiftUI.SettingListItem { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.tagTitle = "Label"
            view.parameters.tagStatus = .positive
            view.parameters.type = .tag
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            view0
            view1
            view2
            view3
            view4
            view5
            view6
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

