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
    
    private lazy var chipView: Ocean.ChipChoice = {
        Ocean.Chip.choice { view in
            view.text = "Label"
            view.onSelected = { chip in
                
            }
        }
    }()
    
    private lazy var chipView2: Ocean.ChipChoice = {
        Ocean.Chip.choice { view in
            view.text = "Label"
            view.status = .selected
            view.onSelected = { chip in
                
            }
        }
    }()
    
    private lazy var chipView3: Ocean.ChipChoice = {
        Ocean.Chip.choice { view in
            view.text = "Label"
            view.status = .disabled
            view.onSelected = { chip in
                
            }
        }
    }()
    
    private lazy var chipView4: Ocean.ChipChoice = {
        Ocean.Chip.choice { view in
            view.text = "Label"
            view.status = .error
            view.onSelected = { chip in
                
            }
        }
    }()
    
    private lazy var chipViewWithIcon1: Ocean.ChipChoiceWithIcon = {
        Ocean.Chip.choiceWithIcon { view in
            view.text = "Label"
            view.icon = Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate)
            view.onSelected = { 
                
            }
        }
    }()
    
    private lazy var chipViewWithIcon2: Ocean.ChipChoiceWithIcon = {
        Ocean.Chip.choiceWithIcon { view in
            view.text = "Label"
            view.icon = Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate)
            view.status = .selected
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipViewWithIcon3: Ocean.ChipChoiceWithIcon = {
        Ocean.Chip.choiceWithIcon { view in
            view.text = "Label"
            view.icon = Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate)
            view.status = .disabled
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipViewWithIcon4: Ocean.ChipChoiceWithIcon = {
        Ocean.Chip.choiceWithIcon { view in
            view.text = "Label"
            view.icon = Ocean.icon.calendarSolid?.withRenderingMode(.alwaysTemplate)
            view.status = .error
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipViewWithBadge1: Ocean.ChipChoiceWithBagde = {
        Ocean.Chip.choiceWithBadge { view in
            view.text = "Label"
            view.number = 8
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipViewWithBadge2: Ocean.ChipChoiceWithBagde = {
        Ocean.Chip.choiceWithBadge { view in
            view.text = "Label"
            view.number = 8
            view.status = .selected
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipViewWithBadge3: Ocean.ChipChoiceWithBagde = {
        Ocean.Chip.choiceWithBadge { view in
            view.text = "Label"
            view.number = 8
            view.status = .disabled
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipViewWithBadge4: Ocean.ChipChoiceWithBagde = {
        Ocean.Chip.choiceWithBadge { view in
            view.text = "Label"
            view.number = 8
            view.status = .error
            view.onSelected = {
                
            }
        }
    }()
    
    private lazy var chipFilter: Ocean.ChipFilter = {
        Ocean.Chip.filter { view in
            view.text = "Label"
            view.onClickIcon = {
                print("close")
            }
        }
    }()
    
    private lazy var chips: Ocean.Chips = {
        Ocean.chips { view in
            view.items = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 2", "Label 3"]
        }
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
//        stack.addArrangedSubview(chipView)
//        stack.addArrangedSubview(chipView2)
//        stack.addArrangedSubview(chipView3)
//        stack.addArrangedSubview(chipView4)
//        stack.addArrangedSubview(chipViewWithIcon1)
//        stack.addArrangedSubview(chipViewWithIcon2)
//        stack.addArrangedSubview(chipViewWithIcon3)
//        stack.addArrangedSubview(chipViewWithIcon4)
//        stack.addArrangedSubview(chipViewWithBadge1)
//        stack.addArrangedSubview(chipViewWithBadge2)
//        stack.addArrangedSubview(chipViewWithBadge3)
//        stack.addArrangedSubview(chipViewWithBadge4)
//        stack.addArrangedSubview(chipFilter)
        
        stack.addArrangedSubview(chips)
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    
}
