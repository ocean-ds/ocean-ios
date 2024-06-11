//
//  StatusListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 24/11/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class StatusListItemSwiftUIViewController: UIViewController {
    lazy var statusListItem1: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .normal
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .below
        }
    }()

    lazy var statusListItem2: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.captionColor = Ocean.color.colorStatusNegativePure
            statusListItem.parameters.style = .normal
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem3: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .contextMenu
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .below
        }
    }()

    lazy var statusListItem4: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .contextMenu
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem5: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .readOnly
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .below
        }
    }()

    lazy var statusListItem6: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .readOnly
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem7: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.style = .normal
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem8: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .normal
            statusListItem.parameters.badgeCount = 9
            statusListItem.parameters.badgeStatus = .warning
            statusListItem.parameters.badgePosition = .right
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            statusListItem1
            statusListItem2
            statusListItem3
            statusListItem4
            statusListItem5
            statusListItem6
            statusListItem7
            statusListItem8
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
struct TStatusListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            StatusListItemSwiftUIViewController()
        }
    }
}
