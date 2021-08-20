//
//  CarouselViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 20/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class CarouselViewController : UIViewController {
    let carousel = Ocean.Carousel()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 0
        
        stack.addArrangedSubview(carousel)
        
        carousel.onTouch = { index in
            print(index)
        }
        
        self.add(view: stack)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        carousel.addImages(with: [UIImage(named: "banner1")!,
                                  UIImage(named: "banner2")!])
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            carousel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
