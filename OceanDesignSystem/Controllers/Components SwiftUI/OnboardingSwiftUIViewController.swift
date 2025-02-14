//
//  OnboardingSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 01/04/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class OnboardingSwiftUIViewController: UIViewController {
    lazy var page1: OceanSwiftUI.OnboardingParameters.PageModel = {
        OceanSwiftUI.OnboardingParameters.PageModel(
            image: Ocean.icon.placeholderOutline,
            title: "Titile 1 Lorem Ipsum is simply dummy text of the",
            subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            caption: "Cada convidado terá um acesso exclusivo apenas para vender pela sua loja."
        )
    }()

    lazy var page2: OceanSwiftUI.OnboardingParameters.PageModel = {
        OceanSwiftUI.OnboardingParameters.PageModel(
            image: Ocean.icon.placeholderOutline,
            title: "Titile 2 Lorem Ipsum is simply dummy text of the",
            subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            caption: "Cada convidado terá um acesso exclusivo apenas para vender pela sua loja."
        )
    }()

    lazy var page3: OceanSwiftUI.OnboardingParameters.PageModel = {
        OceanSwiftUI.OnboardingParameters.PageModel(
            image: Ocean.icon.placeholderOutline,
            title: "Titile 3 Lorem Ipsum is simply dummy text of the",
            subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            caption: "Cada convidado terá um acesso exclusivo apenas para vender pela sua loja."
        )
    }()

    lazy var onboarding: OceanSwiftUI.Onboarding = {
        OceanSwiftUI.Onboarding { onboarding in
            onboarding.parameters.pages = [page1, page2, page3]
            onboarding.parameters.actionLastPage = close
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: VStack(spacing: Ocean.size.spacingStackXs) {
            onboarding
        })


    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }

    @objc
    private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)
struct OnboardingSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            OnboardingSwiftUIViewController()
        }
    }
}
