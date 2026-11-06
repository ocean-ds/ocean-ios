//
//  SceneDelegate.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        #if DEBUG
        // Testes de interface: `-demoSegmentedControl` abre direto a tela de exemplos do Segmented Control.
        if ProcessInfo.processInfo.arguments.contains("-demoSegmentedControl") {
            window?.rootViewController = SegmentedControlSwiftUIViewController()
        }
        #endif
    }
}
