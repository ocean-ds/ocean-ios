//
//  ProgressIndicatorViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 13/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class ProgressIndicatorViewController : UIViewController {
    let sp1 = Ocean.CircularProgressIndicator()
    let sp2 = Ocean.CircularProgressIndicator()
    let sp3 = Ocean.CircularProgressIndicator()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorBrandPrimaryPure
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXs
        
        sp1.size = .small
        sp2.size = .medium
        sp3.size = .large
        
        stack.addArrangedSubview(sp1)
        stack.addArrangedSubview(sp2)
        stack.addArrangedSubview(sp3)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingInsetMd))
        
        stack.addArrangedSubview(Ocean.Button.secondaryMD { button in
            button.text = "Default"
            button.onTouch = {
                self.sp1.style = .normal
                self.sp2.style = .normal
                self.sp3.style = .normal
                self.view.backgroundColor = Ocean.color.colorBrandPrimaryPure
            }
        })
        stack.addArrangedSubview(Ocean.Button.secondaryMD { button in
            button.text = "Primary"
            button.onTouch = {
                self.sp1.style = .primary
                self.sp2.style = .primary
                self.sp3.style = .primary
                self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            }
        })
        
        self.add(view: stack)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        sp1.startAnimating()
        sp2.startAnimating()
        sp3.startAnimating()
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
