//
//  CardCTASwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 09/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class CardCTASwiftUIViewController: UIViewController {
    lazy var cardCTA: OceanSwiftUI.CardCTA = {
        OceanSwiftUI.CardCTA { view in
            view.parameters.text = "Call to action"
            view.parameters.onTouch = {
                view.parameters.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.parameters.isLoading = false
                }
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            cardCTA
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
struct CardCTASwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardCTASwiftUIViewController()
        }
    }
}
