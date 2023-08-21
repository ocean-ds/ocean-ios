//
//  View+Extensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 21/08/23.
//

import SwiftUI

public extension View {
    func getUIView() -> UIView {
        let hostingController = UIHostingController(rootView: self)

        return hostingController.view ?? UIView()
    }
}
