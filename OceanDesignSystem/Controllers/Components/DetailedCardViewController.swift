//
//  DetailedCardViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 22/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanComponents
import OceanTokens

class DetailedCardViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isSkeletonable = true
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
            .make()
        
        let contentStack = Ocean.StackView { stackView in
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = Ocean.size.spacingStackXxs
//            stackView.setMargins(allMargins: Ocean.size.spacingStackXs)
            stackView.isSkeletonable = true
        }
        scrollView.addSubview(contentStack)
        contentStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: self.view)
            .make()
        
        let icon = Ocean.icon.placeholderSolid!
        let model = Ocean.DetailedCardItemModel(iconImage: icon,
                                          titleText: "Title",
                                          tooltipMessage: "Tooltip",
                                          valueText: "R$ 0,00",
                                          progress: 0.3,
                                          descriptionText: "Description")
        
        let itemView = Ocean.DetailedCardValueListItemView(frame: .zero, model: model).addMargins(allMargins: 16)
        contentStack.addArrangedSubview(itemView)
        
        contentStack.add([
            Ocean.Spacer(space: Ocean.size.spacingStackXxs)
        ])
        
        var progress: Float = 0.1
        let detailedCard = Ocean.DetailedCardView(frame: .zero, items: [
            .init(iconImage: Ocean.icon.placeholderSolid,
                  titleText: "Title 1",
                  tooltipMessage: "Tooltip 1",
                  valueText: "R$ 1,00",
                  progress: progress,
                  descriptionText: "Description 1"),
            .init(iconImage: Ocean.icon.placeholderSolid,
                  titleText: "Title 2",
                  tooltipMessage: nil,
                  valueText: "R$ 1.000.000.000,00",
                  progress: nil,
                  descriptionText: "Description 2"),
            .init(iconImage: Ocean.icon.placeholderSolid,
                  titleText: "Title 3",
                  tooltipMessage: nil,
                  valueText: "R$ 1.000.000.000,00",
                  progress: progress,
                  descriptionText: "Description 2"),
        ])
        contentStack.addArrangedSubview(detailedCard)
        
//        contentStack.showAnimatedSkeleton()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            DispatchQueue.main.async {
                if progress < 1 {
                    progress += 0.1
                } else {
                    timer.invalidate()
                }
                
                detailedCard.update([
                    .init(iconImage: Ocean.icon.placeholderSolid,
                          titleText: "Title 1",
                          tooltipMessage: "Tooltip 1",
                          valueText: "R$ 1,00",
                          progress: progress,
                          descriptionText: "Description 1"),
                    .init(iconImage: Ocean.icon.placeholderSolid,
                          titleText: "Title 2",
                          tooltipMessage: nil,
                          valueText: "R$ 1.000.000.000,00",
                          progress: nil,
                          descriptionText: "Description 2"),
                    .init(iconImage: Ocean.icon.placeholderSolid,
                          titleText: "Title 3",
                          tooltipMessage: nil,
                          valueText: "R$ 1.000.000.000,00",
                          progress: 0.1,
                          descriptionText: "Description 2"),
                ])
            }
//            contentStack.hideSkeleton()
        }
    }
}
