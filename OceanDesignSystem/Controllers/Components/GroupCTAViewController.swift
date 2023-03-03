//
//  GroupCTAViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 17/08/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class GroupCTAViewController: UIViewController {
    private lazy var cta1: Ocean.GroupCTA = {
        let view = Ocean.GroupCTA()
        view.text = "Call To Action"
        view.onTouch = {
            view.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.isLoading = false
            }
        }
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubviews(cta1)
        
        cta1.oceanConstraints
            .topToTop(to: self.view)
            .leadingToLeading(to: self.view, constant: 16)
            .trailingToTrailing(to: self.view, constant: -16)
            .make()
    }
}
