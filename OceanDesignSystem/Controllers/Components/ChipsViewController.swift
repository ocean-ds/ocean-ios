//
//  ChipsViewController.swift
//  OceanDesignSystem
//
//  Created by Thomás Marques Brandão Reis on 06/12/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class ChipsViewController: UIViewController {
    
    private let chipsModel1 = [
        Ocean.ChipModel(title: "Label 1"),
        Ocean.ChipModel(title: "Label 2"),
        Ocean.ChipModel(title: "Label 3"),
        Ocean.ChipModel(title: "Label 4"),
        Ocean.ChipModel(title: "Label 5", status: .selected),
        Ocean.ChipModel(title: "Label 6", status: .disabled),
        Ocean.ChipModel(title: "Label 7", status: .error),
    ]
    
    private let chipsModel2 = [
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 1", type: .choiceWithIcon, status: .normal),
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 2", type: .choiceWithIcon, status: .selected),
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 3", type: .choiceWithIcon, status: .disabled),
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 4", type: .choiceWithIcon, status: .error)
    ]
    
    private let chipsModel3 = [
        Ocean.ChipModel(number: 8, title: "Label 1", type: .choiceWithBadge, status: .normal),
        Ocean.ChipModel(number: 10, title: "Label 2", type: .choiceWithBadge, status: .selected),
        Ocean.ChipModel(number: 6, title: "Label 3", type: .choiceWithBadge, status: .disabled),
        Ocean.ChipModel(number: 9, title: "Label 4", type: .choiceWithBadge, status: .error),
    ]
    
    private let chipsModel4 = [
        Ocean.ChipModel(title: "Label 1", type: .filter),
        Ocean.ChipModel(title: "Label 2", type: .filter),
        Ocean.ChipModel(title: "Label 3", type: .filter),
        Ocean.ChipModel(title: "Label 4", type: .filter),
    ]
    
    private lazy var chips1: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .choice
        chips.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item.title) - Selected: \(selected)")
        }
        chips.addData(with: chipsModel1)
        return chips
    }()
    
    private lazy var chips2: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .choiceWithIcon
        chips.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item.title) - Selected: \(selected)")
        }
        chips.addData(with: chipsModel2)
        return chips
    }()
    
    private lazy var chips3: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .choiceWithBadge
        chips.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item.title) - Selected: \(selected)")
        }
        chips.addData(with: chipsModel3)
        return chips
    }()
    
    private lazy var chips4: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .filter
        chips.onRemoved = { item in
            self.showSnackbar(text: "Item: \(item.title) removed")
        }
        chips.addData(with: chipsModel4)
        return chips
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
    
        stack.addArrangedSubview(chips1)
        stack.addArrangedSubview(chips2)
        stack.addArrangedSubview(chips3)
        stack.addArrangedSubview(chips4)
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            chips1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            chips2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            chips3.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            chips4.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
    
    private func showSnackbar(text: String) {
        let snackbar = Ocean.View.snackbarInfo { view in
            view.line = .one
            view.snackbarText = text
        }
        snackbar.show(in: self.view)
    }
}
