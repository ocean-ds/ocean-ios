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
import SkeletonView

final public class ChipsViewController: UIViewController {
    
    private let chipsChoiceModel = [
        Ocean.ChipModel(title: "Label 1"),
        Ocean.ChipModel(title: "Label 2"),
        Ocean.ChipModel(title: "Label 3"),
        Ocean.ChipModel(title: "Label 4"),
        Ocean.ChipModel(title: "Label 5", status: .selected),
        Ocean.ChipModel(title: "Label 6", status: .disabled),
        Ocean.ChipModel(title: "Label 7", status: .error),
    ]
    
    private let chipsChoiceWithIconModel = [
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 1", status: .normal),
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 2", status: .selected),
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 3", status: .disabled),
        Ocean.ChipModel(icon: Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate), title: "Label 4", status: .error)
    ]
    
    private let chipsChoiceWithBadgeModel = [
        Ocean.ChipModel(number: 8, title: "Label 1", status: .normal),
        Ocean.ChipModel(number: 10, title: "Label 2", status: .selected),
        Ocean.ChipModel(number: 6, title: "Label 3", status: .disabled),
        Ocean.ChipModel(number: 9, title: "Label 4", status: .error),
        Ocean.ChipModel(number: 0, title: "Label 5", status: .normal)
    ]
    
    private let chipsFilterModel = [
        Ocean.ChipModel(title: "Label 1"),
        Ocean.ChipModel(title: "Label 2"),
        Ocean.ChipModel(title: "Label 3"),
        Ocean.ChipModel(title: "Label 4")
    ]
    
    private lazy var chips1: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .choice
        chips.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item.title) - Selected: \(selected)")
        }
        chips.addData(with: chipsChoiceModel)
        return chips
    }()
    
    private lazy var chips2: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .choiceWithIcon
        chips.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item.title) - Selected: \(selected)")
        }
        chips.addData(with: chipsChoiceWithIconModel)
        return chips
    }()
    
    private lazy var chips3: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .choiceWithBadge
        chips.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item.title) - Selected: \(selected)")
        }
        chips.addData(with: chipsChoiceWithBadgeModel)
        chips.isSkeletonable = true
        return chips
    }()
    
    private lazy var chips4: Ocean.Chips =  {
        let chips = Ocean.Chips()
        chips.chipType = .filter
        chips.onRemoved = { item in
            self.showSnackbar(text: "Item: \(item.title) removed")
        }
        chips.addData(with: chipsFilterModel)
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
