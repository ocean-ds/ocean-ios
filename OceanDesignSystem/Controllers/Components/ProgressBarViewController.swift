//
//  ProgressBarViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 22/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanComponents
import OceanTokens

class ProgressBarViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
            .make()
        
        let contentStack = Ocean.StackView { stackView in
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = Ocean.size.spacingStackXxs
            stackView.setMargins(allMargins: Ocean.size.spacingStackXs)
        }
        scrollView.addSubview(contentStack)
        contentStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: self.view)
            .make()
        
        let progressBar = Ocean.ProgressBar()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(progressBar)
        
        var progress: Float = 0
        Timer.scheduledTimer(withTimeInterval: 0.250, repeats: true) { timer in
            progress += 0.01
            
            progressBar.setProgress(progress)
            
            if progress >= 1 {
                progress = 0
            }
        }
    }
}
