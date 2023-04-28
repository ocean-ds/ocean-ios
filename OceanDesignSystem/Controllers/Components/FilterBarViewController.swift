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
    
    lazy var filterBar = Ocean.FilterBar(
    )
    
    lazy var optionsCellModel: [Ocean.CellModel] = [
        Ocean.CellModel(title: "Pago"),
        Ocean.CellModel(title: "Pendente"),
        Ocean.CellModel(title: "Recusado")
    ]
    
    lazy var filterOptionsModel: Ocean.FilterOptionsModel = {
        Ocean.FilterOptionsModel(
            modalTitle: "Opções de Filtro",
            multipleChoiceOptions: optionsCellModel,
            primaryButtonTitle: "Filtrar",
            secondaryButtonTitle: "Cancelar")
    }()
    
    lazy var filterChip: Ocean.FilterChipWithModal = {
        let chip = Ocean.FilterChipWithModal()
        chip.text = "Filtro"
        chip.filterOptionsModel = filterOptionsModel
        chip.rootViewController = self
        chip.onValuesChange = { _, items in
            let itensSelected = items.filter { $0.isSelected }
            let selectedTitles = itensSelected.map { $0.title }
            let message = "Items: \(selectedTitles.joined(separator: ", "))"
            self.showSnackbar(text: message)
        }
        
        return chip
    }()
    
    lazy var filterChip2: Ocean.FilterChipWithModal = {
        let chip = Ocean.FilterChipWithModal()
        chip.text = "Filtro"
        chip.filterOptionsModel = filterOptionsModel
        chip.rootViewController = self
        chip.onValuesChange = { _, items in
            let itensSelected = items.filter { $0.isSelected }
            let selectedTitles = itensSelected.map { $0.title }
            let message = "Items: \(selectedTitles.joined(separator: ", "))"
            self.showSnackbar(text: message)
        }
        
        return chip
    }()
    
    lazy var basicChip1: Ocean.FilterBarBasicChip = {
        let chip = Ocean.FilterBarBasicChip()
        chip.number = 999
        chip.icon = Ocean.icon.calendarOutline?.withRenderingMode(.alwaysTemplate)
        chip.text = "Todos os Filtros"
        chip.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item) - Selected: \(selected)")
        }
        
        return chip
    }()
    
    lazy var basicChip2: Ocean.FilterBarBasicChip = {
        let chip = Ocean.FilterBarBasicChip()
        chip.number = 9
        chip.text = "Filtros"
        chip.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item) - Selected: \(selected)")
        }
        
        return chip
    }()
    
    lazy var basicChip3: Ocean.FilterBarBasicChip = {
        let chip = Ocean.FilterBarBasicChip()
        chip.text = "Filtrados"
        chip.onValueChange = { selected, item in
            self.showSnackbar(text: "Item: \(item) - Selected: \(selected)")
        }
        
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
            filterBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            filterBar.heightAnchor.constraint(equalToConstant: 100.0)
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



