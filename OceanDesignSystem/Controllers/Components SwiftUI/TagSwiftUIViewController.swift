//
//  TagSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 24/11/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TagSwiftUIViewController: UIViewController {
    lazy var tag1: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.positiveMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag2: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.warningMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag3: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.negativeMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag4: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.complementaryMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag5: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.neutralInterfaceMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag6: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.neutralPrimaryMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag7: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.highlightImportantMD { tag in
            tag.parameters.label = "Label"
        }
    }()

    lazy var tag8: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.highlightNeutralMD { tag in
            tag.parameters.label = "Label"
        }
    }()

    lazy var tag9: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.positiveSM { tag in
            tag.parameters.label = "Label"
        }
    }()

    lazy var tag10: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.negativeSM { tag in
            tag.parameters.label = "Label"
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            tag1
            tag2
            tag3
            tag4
            tag5
            tag6
            tag7
            tag8
            tag9
            tag10
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
struct TagSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TagSwiftUIViewController()
        }
    }
}
