//
//  CarouselSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 09/05/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class CarouselSwiftUIViewController: UIViewController {
    lazy var carousel1: OceanSwiftUI.CarouselWithImages = {
        OceanSwiftUI.Carousel.withImages { view in
            view.parameters.items = [.init(image: UIImage(named: "banner1")!),
                                     .init(image: UIImage(named: "banner2")!)]
            view.parameters.onTouch = { item, index in
                print(index)
            }
        }
    }()
    
    lazy var carousel2: OceanSwiftUI.CarouselWithImages = {
        OceanSwiftUI.Carousel.withImages { view in
            view.parameters.items = [.init(image: UIImage(named: "banner1")!)]
            view.parameters.onTouch = { item, index in
                print(index)
            }
        }
    }()
    
    lazy var carousel3: OceanSwiftUI.CarouselWithComponents = {
        OceanSwiftUI.Carousel.withComponents { view in
            view.parameters.items = [
                OceanSwiftUI.CardGroup(parameters: .init(title: "Title",
                                                         subtitle: "Subtitle",
                                                         caption: "Caption",
                                                         ctaText: "Selecionar",
                                                         onTouch: { print("tapped") })),
                OceanSwiftUI.CardGroup(parameters: .init(title: "Title",
                                                         subtitle: "Subtitle",
                                                         caption: "Caption",
                                                         ctaText: "Selecionar",
                                                         onTouch: { print("tapped") }))
            ]
        }
    }()
    
    lazy var carousel4: OceanSwiftUI.CarouselWithComponents = {
        OceanSwiftUI.Carousel.withComponents { view in
            view.parameters.items = [
                OceanSwiftUI.CardGroup(parameters: .init(title: "Title",
                                                         subtitle: "Subtitle",
                                                         caption: "Caption",
                                                         ctaText: "Selecionar",
                                                         onTouch: { print("tapped") }))
            ]
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            carousel1
            
            carousel2
            
            carousel3
            
            carousel4
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .topToTop(to: self.view, constant: Ocean.size.spacingStackXs)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .bottomToBottom(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct CarouselSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CarouselSwiftUIViewController()
        }
    }
}
