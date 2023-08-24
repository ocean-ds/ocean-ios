//
//  UIHostingController+Extensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 24/08/23.
//

import SwiftUI

public extension UIHostingController {
    func getUIView() -> UIView {
        let view = self.view ?? UIView()
        view.backgroundColor = .clear
        return view
    }
}
