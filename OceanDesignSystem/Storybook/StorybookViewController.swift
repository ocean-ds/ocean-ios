//
//  StorybookViewController.swift
//  OceanDesignSystem
//
//  Ponte UIKit para o Storybook SwiftUI, permitindo apresentá-lo a partir da
//  lista de componentes SwiftUI do app de exemplo.
//

import UIKit
import SwiftUI

class StorybookViewController: UIViewController {
    private lazy var hostingController = UIHostingController(rootView: StorybookView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
