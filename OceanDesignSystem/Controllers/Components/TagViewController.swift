//
//  TagViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 03/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class TagViewController : UIViewController {
    let neutral = Ocean.Tag { view in
        view.title = "neutral"
        view.status = .neutral
    }
    
    let positive = Ocean.Tag { view in
        view.title = "positive"
        view.status = .positive
    }
    
    let warning = Ocean.Tag { view in
        view.title = "warning"
        view.status = .warning
    }
    
    let complementary = Ocean.Tag { view in
        view.title = "complementary"
        view.status = .complementary
    }
    
    let negative = Ocean.Tag { view in
        view.title = "negative"
        view.status = .negative
    }
    
    private lazy var tagSimpleStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXxs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.add([neutral,
                   positive,
                   warning,
                   complementary,
                   negative])
        
        return stack
    }()
    
    let neutralIcon = Ocean.Tag { view in
        view.title = "neutral"
        view.image = Ocean.icon.mapSolid
        view.status = .neutral
    }
    
    let positiveIcon = Ocean.Tag { view in
        view.title = "positive"
        view.image = Ocean.icon.checkCircleSolid
        view.status = .positive
    }
    
    let warningIcon = Ocean.Tag { view in
        view.title = "warning"
        view.image = Ocean.icon.exclamationCircleSolid
        view.status = .warning
    }
    
    let negativeIcon = Ocean.Tag { view in
        view.title = "negative"
        view.image = Ocean.icon.xCircleSolid
        view.status = .negative
    }
    
    let complementaryIcon = Ocean.Tag { view in
        view.title = "complementary"
        view.image = Ocean.icon.placeholderSolid
        view.status = .complementary
    }
    
    private lazy var tagWithIconStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXxs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.add([neutralIcon,
                   positiveIcon,
                   warningIcon,
                   negativeIcon,
                   complementaryIcon])
        
        return stack
    }()
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.add([tagSimpleStack,
                   Ocean.Divider(),
                   tagWithIconStack])
        
        return stack
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupUI()
        setContraintsDSL()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(mainStack)
    }
    
    private func setContraintsDSL() {
        
//        NSLayoutConstraint.activate([
//            stack1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Ocean.size.spacingStackMd),
//            stack1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            stack2.topAnchor.constraint(equalTo: stack1.bottomAnchor, constant: Ocean.size.spacingStackXs),
//            stack2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])
    }
    
//    private func applyScrollViewDefaultContraints() {
//           scrollView.oceanConstraints
//               .fill(to: view)
//               .make()
//
//           scrollableContentView.oceanConstraints
//               .fill(to: scrollView)
//               .width(to: view)
//               .make()
//       }
}
