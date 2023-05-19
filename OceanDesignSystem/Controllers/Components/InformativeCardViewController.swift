//
//  InformativeCardViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 17/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanComponents
import OceanTokens

class InformativeCardViewController: UIViewController {
    
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
        
        addSection(stackView: contentStack, text: "Default state", includeSpacer: false)
        addExample(stackView: contentStack, state: .defaultState)
        addExample(stackView: contentStack,
                   state: .defaultState,
                   descriptionText: nil,
                   additionalInformationText: nil,
                   tooltipMessage: nil,
                   subItems: [["Label 1", "R$ 1,00", "Tooltip 2"]])
        addExample(stackView: contentStack,
                   state: .defaultState,
                   descriptionText: nil,
                   additionalInformationText: nil,
                   tooltipMessage: nil,
                   subItems: nil,
                   actionText: nil)

        addSection(stackView: contentStack, text: "Empty state")
        addExample(stackView: contentStack, state: .emptyState)
        addExample(stackView: contentStack, state: .emptyState, actionText: nil)

        addSection(stackView: contentStack, text: "Sell state")
        addExample(stackView: contentStack, state: .sellState)
        addExample(stackView: contentStack, state: .sellState, actionText: nil)
    }
    
    private func addExample(stackView: Ocean.StackView,
                            state: Ocean.InformativeCardViewState = .defaultState,
                            iconImage: UIImage = Ocean.icon.placeholderOutline!,
                            titleText: String = "Title",
                            valueText: String = "R$ 0,00",
                            descriptionText: String? = "Description",
                            additionalInformationText: String? = "Additional information",
                            tooltipMessage: String? = "Tooltip 1",
                            subItems: [[String]]? = [["Label 1", "R$ 1,00", "Tooltip 2"], ["Label 2", "R$ 2,00"]],
                            actionText: String? = "Call To Action",
                            actionMessage: String = "CTA touched!") {
        

        let subItemsModels: [Ocean.InformativeCardSubItemModel] = subItems?.compactMap {
            if $0.count == 3 {
                return Ocean.InformativeCardSubItemModel(labelText: $0[0], valueText: $0[1], tooltipMessage: $0[2])
            } else if $0.count == 2 {
                return Ocean.InformativeCardSubItemModel(labelText: $0[0], valueText: $0[1])
            } else {
                return Ocean.InformativeCardSubItemModel(labelText: "Label", valueText: "Value")
            }
        } ?? []
        
        let model = Ocean.InformativeCardModel(state: state,
                                               iconImage: iconImage,
                                               tooltipMessage: tooltipMessage,
                                               titleText: titleText,
                                               valueText: valueText,
                                               descriptionText: descriptionText,
                                               subItems: subItemsModels,
                                               additionalInformationText: additionalInformationText,
                                               actionText: actionText) { [weak self] _ in
            guard let self = self else { return }
            
            let snackbar = Ocean.View.snackbarInfo(builder: { snackbar in
                snackbar.line = .one
                snackbar.snackbarText = actionMessage
            })
            
            snackbar.show(in: self.view)
        }
        
        let informativeCard = Ocean.InformativeCardView(frame: .zero, model: model)
        
        stackView.addArrangedSubview(informativeCard)
    }
    
    private func addSection(stackView: Ocean.StackView, text: String, includeSpacer: Bool = true) {
        let label = Ocean.Typography.description { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.numberOfLines = 0
        }
        
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
