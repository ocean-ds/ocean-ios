//
//  CardGroupSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 09/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class CardGroupSwiftUIViewController: UIViewController {
    lazy var cardGroup1: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
            view.parameters.subtitle = "Subtitle"
            view.parameters.icon = Ocean.icon.cloudOutline
            view.parameters.badgeCount = 5
            view.parameters.ctaText = "Call to action"
            view.parameters.view = HStack(alignment: .center) { Text("Content View").padding() }
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()

    lazy var cardGroup2: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
            view.parameters.subtitle = "Subtitle"
            view.parameters.icon = Ocean.icon.cloudOutline
            view.parameters.badgeCount = 5
            view.parameters.badgeStatus = .highlight
            view.parameters.recommend = true
            view.parameters.ctaText = "Call to action"
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()

    lazy var cardGroup3: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
            view.parameters.badgeCount = 5
            view.parameters.badgeStatus = .disabled
            view.parameters.ctaText = "Call to action"
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()

    lazy var cardGroup4: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
            view.parameters.ctaText = "Call to action"
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()

    lazy var cardGroup5: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
        }
    }()

    lazy var cardGroup6: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
            view.parameters.subtitle = "Subtitle"
            view.parameters.progress = 0.5
            view.parameters.ctaText = "Call to action"
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()
    
    lazy var cardGroup7: OceanSwiftUI.CardGroup = {
        OceanSwiftUI.CardGroup { view in
            view.parameters.title = "Title"
            view.parameters.subtitle = "Subtitle"
            view.parameters.progress = 0.5
            view.parameters.ctaText = "Call to action"
            view.parameters.showSkeleton = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            cardGroup1
            cardGroup2
            cardGroup3
            cardGroup4
            cardGroup5
            cardGroup6
            cardGroup7
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
struct CardGroupSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardGroupSwiftUIViewController()
        }
    }
}
