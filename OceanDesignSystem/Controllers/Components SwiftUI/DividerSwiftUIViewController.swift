//
//  DividerSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

final public class DividerSwiftUIViewController : UIViewController {
    lazy var dividerHorizontal = OceanSwiftUI.Divider()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            self.dividerHorizontal
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
