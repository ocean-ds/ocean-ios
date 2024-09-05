//
//  ContentListSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/09/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import SwiftUI

class ContentListSwiftUIViewController: UIViewController {
    lazy var view0: OceanSwiftUI.ContentList = {
        return OceanSwiftUI.ContentList { view in
            view.parameters.title = "Title"
            view.parameters.description = "R$ 100,00"
            view.parameters.newDescription = "Zero"
            view.parameters.descriptionColor = Ocean.color.colorStatusPositiveDown
            view.parameters.type = .default
        }
    }()

    lazy var view1: OceanSwiftUI.ContentList = {
        return OceanSwiftUI.ContentList { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.type = .default
        }
    }()


    lazy var view2: OceanSwiftUI.ContentList = {
        return OceanSwiftUI.ContentList { view in
            view.parameters.title = "Title Inverted"
            view.parameters.description = "Description"
            view.parameters.type = .inverted
        }
    }()


    lazy var view3: OceanSwiftUI.ContentList = {
        return OceanSwiftUI.ContentList { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.type = .default
        }
    }()

    lazy var view4: OceanSwiftUI.ContentList = {
        return OceanSwiftUI.ContentList { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.errorMessage = "Error message"
            view.parameters.type = .default
        }
    }()

    lazy var view5: OceanSwiftUI.ContentList = {
        return OceanSwiftUI.ContentList { view in
            view.parameters.title = "Title"
            view.parameters.description = "Description"
            view.parameters.caption = "Caption"
            view.parameters.errorMessage = "Error message"
            view.parameters.type = .default
            view.parameters.showSkeleton = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: 0) {
            view0
            view1
            view2
            view3
            view4
            view5
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
struct ContentListSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ContentListSwiftUIViewController()
        }
    }
}

