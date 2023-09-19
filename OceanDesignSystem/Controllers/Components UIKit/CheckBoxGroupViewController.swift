//
//  CheckBoxGroupViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 18/09/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

public class CheckBoxGroupViewController: UIViewController {
    
    private lazy var checkboxesModel: [Ocean.CheckBoxGroup.CheckboxModel] = [
        .init(title: "checkbox1", subtitle: "00.000.000/0001-01", isSelected: false),
        .init(title: "checkbox2", subtitle: "00.000.000/0001-02", isSelected: false),
        .init(title: "checkbox3", subtitle: "00.000.000/0001-03", isSelected: false),
        .init(title: "checkbox4", subtitle: "00.000.000/0001-04", isSelected: false)
    ]
    
    private lazy var model: Ocean.CheckBoxGroup.CheckboxesModel = .init(selectAllText: "Selecionar todas", 
                                                                        checkboxes: checkboxesModel,
                                                                        onChange: onChange
    )
    
    private lazy var checkBoxGroup = Ocean.CheckBoxGroup(model: model)

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(checkBoxGroup)
        setupConstraints()
    }
    
    private func setupConstraints() {
        checkBoxGroup.oceanConstraints
            .centerY(to: view)
            .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs)
            .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs)
            .make()
    }
    
    private func onChange(checkboxes: [Ocean.CheckBoxGroup.CheckboxModel]) {
        checkboxes.forEach { item in
            print("Title: \(item.title) - Status: \(item.isSelected)")
        }
    }
}
