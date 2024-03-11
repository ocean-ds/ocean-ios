//
//  CardOptionSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 11/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class CardOptionSwiftUIViewController: UIViewController {
    lazy var cardOption1: OceanSwiftUI.CardOption = {
        OceanSwiftUI.CardOption { option in
            option.parameters.title = "Title"
            option.parameters.subtitle = "Subtitle"
            option.parameters.isDisabled = true
            option.parameters.onTouch = {
                self.cardOption2.parameters.isSelected = false
                self.cardOption3.parameters.isSelected = false
                self.cardOption4.parameters.isSelected = false
                self.cardOption5.parameters.isSelected = false
            }
        }
    }()

    lazy var cardOption2: OceanSwiftUI.CardOption = {
        OceanSwiftUI.CardOption { option in
            option.parameters.title = "Title"
            option.parameters.subtitle = "Subtitle"
            option.parameters.recommend = true
            option.parameters.onTouch = {
                self.cardOption1.parameters.isSelected = false
                self.cardOption3.parameters.isSelected = false
                self.cardOption4.parameters.isSelected = false
                self.cardOption5.parameters.isSelected = false
            }
        }
    }()

    lazy var cardOption3: OceanSwiftUI.CardOption = {
        OceanSwiftUI.CardOption { option in
            option.parameters.title = "Title"
            option.parameters.subtitle = "Subtitle"
            option.parameters.isError = true
            option.parameters.onTouch = {
                self.cardOption1.parameters.isSelected = false
                self.cardOption2.parameters.isSelected = false
                self.cardOption4.parameters.isSelected = false
                self.cardOption5.parameters.isSelected = false
            }
        }
    }()

    lazy var cardOption4: OceanSwiftUI.CardOption = {
        OceanSwiftUI.CardOption { option in
            option.parameters.title = "Title"
            option.parameters.isDisabled = true
            option.parameters.onTouch = {
                self.cardOption1.parameters.isSelected = false
                self.cardOption2.parameters.isSelected = false
                self.cardOption3.parameters.isSelected = false
                self.cardOption5.parameters.isSelected = false
            }
        }
    }()

    lazy var cardOption5: OceanSwiftUI.CardOption = {
        OceanSwiftUI.CardOption { option in
            option.parameters.title = "Title"
            option.parameters.onTouch = {
                self.cardOption1.parameters.isSelected = false
                self.cardOption2.parameters.isSelected = false
                self.cardOption3.parameters.isSelected = false
                self.cardOption4.parameters.isSelected = false
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            cardOption1
            cardOption2
            cardOption3
            cardOption4
            cardOption5
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
struct CardOptionSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardOptionSwiftUIViewController()
        }
    }
}
