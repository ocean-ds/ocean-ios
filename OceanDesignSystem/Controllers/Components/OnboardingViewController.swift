//
//  OnboardingViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

class OnboardingViewController: UIViewController, OceanNavigationBar {
    
    lazy var onboarding: Ocean.Onboarding = {
        let view = Ocean.Onboarding()
        view.model = .init(
            pages: [
                .init(image: Ocean.icon.placeholderSolid!,
                      title: "Title 1",
                      subtitle: "Lorem ipsum dolor sit amet consectetur. Pellentesque risus venenatis vestibulum sit."),
                .init(image: Ocean.icon.placeholderSolid!,
                      title: "Title 2",
                      subtitle: "Lorem ipsum dolor sit amet consectetur. Pellentesque risus venenatis vestibulum sit."),
                .init(image: Ocean.icon.placeholderSolid!,
                      title: "Title 3",
                      subtitle: "Lorem ipsum dolor sit amet consectetur. Pellentesque risus venenatis vestibulum sit."),
                .init(image: Ocean.icon.placeholderSolid!,
                      title: "Title 3",
                      subtitle: "Lorem ipsum dolor sit amet consectetur. Pellentesque risus venenatis vestibulum sit."),
                .init(image: Ocean.icon.placeholderSolid!,
                      title: "Title 3",
                      subtitle: "Lorem ipsum dolor sit amet consectetur. Pellentesque risus venenatis vestibulum sit."),
                .init(image: Ocean.icon.placeholderSolid!,
                      title: "Title 3",
                      subtitle: "Lorem ipsum dolor sit amet consectetur. Pellentesque risus venenatis vestibulum sit."),
            ],
            titleButton: "Avançar",
            titleButtonLastPage: "Começar a usar",
            actionLastPage: goToNewViewController
        )
        return view
    }()
    
    lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        
        stack.add([
            onboarding
        ])
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        addCloseButton(action: #selector(close))
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mainStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainStack.oceanConstraints
            .fill(to: view)
            .make()
    }
    
    @objc
    private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func goToNewViewController() {
        print("onTouch")
    }
}
