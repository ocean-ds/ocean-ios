//
//  UIViewControllerPreview.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 16/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI

struct UIViewControllerPreview<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T

    init(_ builder: @escaping () -> T) {
        viewController = builder()
    }

    func makeUIViewController(context: Context) -> T {
        viewController
    }

    func updateUIViewController(_ uiViewController: T, context: UIViewControllerRepresentableContext<UIViewControllerPreview<T>>) {
        return
    }
}
