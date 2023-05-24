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
            stackView.isSkeletonable = true
        }
        scrollView.addSubview(contentStack)
        contentStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: self.view)
            .make()
        
        addSection(stackView: contentStack, text: "Detailed Card", includeSpacer: true)
        addDetailedCardExample(stackView: contentStack, progress: 0.5, isLoading: false)
        addDetailedCardExample(stackView: contentStack, progress: nil, isLoading: false)
        addDetailedCardExample(stackView: contentStack, progress: nil, isLoading: true)
        
        addSection(stackView: contentStack, text: "Value List Item", includeSpacer: false)
        addValueListItemViewExample(stackView: contentStack, progress: 0.5)
        addValueListItemViewExample(stackView: contentStack, progress: nil)
        addValueListItemViewExample(stackView: contentStack, progress: nil, isLoading: true)
    }
    
    private func addValueListItemViewExample(stackView: Ocean.StackView,
                                             progress: Float?,
                                             isLoading: Bool = false) {
        let itemView = Ocean.DetailedCardValueListItemView(frame: .zero)
        stackView.addArrangedSubview(itemView.addMargins(horizontal: Ocean.size.spacingInsetSm))
        
        if isLoading {
            itemView.showAnimatedSkeleton()
        } else {
            itemView.update(Ocean.DetailedCardItemModel(iconImage: Ocean.icon.placeholderSolid,
                                                        titleText: "Title",
                                                        tooltipMessage: "Tooltip",
                                                        valueText: "R$ 0,00",
                                                        progress: progress,
                                                        descriptionText: "Description"))
        }
    }
    
    private func addDetailedCardExample(stackView: Ocean.StackView,
                                        progress: Float?,
                                        isLoading: Bool = false) {
        let detailedCard = Ocean.DetailedCardView(frame: .zero, items: [])
        stackView.addArrangedSubview(detailedCard)
        
        if isLoading {
            detailedCard.showAnimatedSkeleton()
        } else {
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
                      tooltipMessage: "Tooltip 2",
                      valueText: "R$ 1.000.000.000,00",
                      progress: nil,
                      descriptionText: "Description 2"),
            ])
        }
    }
    
    private func addSection(stackView: Ocean.StackView, text: String, includeSpacer: Bool = true) {
        let label = Ocean.Typography.description { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.numberOfLines = 0
        }.addMargins(horizontal: Ocean.size.spacingInsetSm)
        
        if includeSpacer {
            stackView.add([
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                label
            ])
        } else {
            stackView.add([
                label
            ])
        }
    }
}
