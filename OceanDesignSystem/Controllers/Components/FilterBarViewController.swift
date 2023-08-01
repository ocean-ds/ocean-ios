//
//  FilterBarViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 19/04/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens
import OceanComponents

class FilterBarViewController: UIViewController {
    lazy var filterBar = Ocean.FilterBar()
 
    lazy var optionsChipModel: [Ocean.ChipModel] = [
        Ocean.ChipModel(id: "pad", title: "Pago"),
        Ocean.ChipModel(id: "pending", title: "Pendente"),
        Ocean.ChipModel(id: "refused", title: "Recusado")
    ]

    lazy var filterOptionsModel: Ocean.FilterBarOptionsModel = {
        Ocean.FilterBarOptionsModel(
            modalTitle: "Opções de Filtro",
            options: optionsChipModel)
    }()

    lazy var filterOptionsModel2: Ocean.FilterBarOptionsModel = {
        Ocean.FilterBarOptionsModel(
            modalTitle: "Opções de Filtro",
            options: optionsChipModel
        )
    }()

    lazy var filterChip: Ocean.FilterBarChipWithModal = {
        let chip = Ocean.FilterBarChipWithModal()
        chip.text = "Filtro"
        chip.modalType = .multipleChoice
        chip.optionsModel = filterOptionsModel
        chip.rootViewController = self
        chip.onCancel = { [weak self] in
            guard let self = self else { return }
            self.showSnackbar(text: "Cancel")
        }

        return chip
    }()

    lazy var filterChip2: Ocean.FilterBarChipWithModal = {
        let chip = Ocean.FilterBarChipWithModal()
        chip.text = "Filtro"
        chip.modalType = .singleChoice
        chip.optionsModel = filterOptionsModel2
        chip.rootViewController = self

        return chip
    }()
    
    lazy var basicChip1: Ocean.FilterBarBasicChip = {
        let chip = Ocean.FilterBarBasicChip()
        chip.chipModel = Ocean.ChipModel(icon: Ocean.icon.calendarOutline,
                                         number: 999,
                                         title: "Todos os Filtros")
        
        return chip
    }()
    
    lazy var basicChip2: Ocean.FilterBarBasicChip = {
        let chip = Ocean.FilterBarBasicChip()
        chip.chipModel = Ocean.ChipModel(icon: Ocean.icon.calendarOutline,
                                         number: 9,
                                         title: "Filtros")

        return chip
    }()
    
    lazy var basicChip3: Ocean.FilterBarBasicChip = {
        let chip = Ocean.FilterBarBasicChip()
        chip.chipModel = Ocean.ChipModel(icon: Ocean.icon.calendarOutline,
                                         title: "Filtrados")

        return chip
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(filterBar)
        
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filterBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        filterBar.addFilterChips([
            filterChip,
            filterChip2
        ])
        
        filterBar.addBasicChips([
            basicChip1,
            basicChip2,
            basicChip3
        ])
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                view.addGestureRecognizer(panGesture)

        filterBar.onValueChange = { [weak self] items in
            guard let self = self else { return }

            if items.count > 0 {
                self.showSnackbar(text: "Selected: \(items.map { $0.title }.joined(separator: ", "))")
            } else {
                self.showSnackbar(text: "No items selected")
            }
        }
    }
    
    private func showSnackbar(text: String) {
        let snackbar = Ocean.View.snackbarInfo { view in
            view.line = .one
            view.snackbarText = text
        }
        snackbar.show(in: self.view)
    }

    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        
        switch gestureRecognizer.state {
        case .changed:
            if translation.y > 0 {
                view.frame.origin.y = translation.y
            }
        case .ended:
            if translation.y > view.frame.height / 2 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = 0
                }
            }
        default:
            break
        }
    }
}
