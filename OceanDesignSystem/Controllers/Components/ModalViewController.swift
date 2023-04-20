//
//  ModalViewController.swift
//  OceanDesignSystem
//
//  Created by Pedro Azevedo on 09/07/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class ModalViewController: UIViewController {
    enum ShowCases {
        case withActonsNormal
        case withActonsCritical
        case listWithImages
        case listWithActions
        case simpleList
        case customView
        case multipleChoice
    }
    
    @IBOutlet weak var mainSegmentControl: UISegmentedControl!
    @IBOutlet weak var subSegmentControl: UISegmentedControl!
    
    private var showCase: ShowCases = .withActonsNormal
    
    private lazy var contentStack: Ocean.StackView = {
        let contentStack = Ocean.StackView()
        contentStack.axis = .vertical
        contentStack.spacing = 30
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(showSheetButton)
        
        return contentStack
    }()
    
    private lazy var showSheetButton: Ocean.ButtonPrimary = {
        Ocean.Button.primaryBlockedMD { button in
            button.text = "Show Modal"
            button.onTouch = self.showBottomSheetActionButton
        }
    }()

    private lazy var sheetComponent: Ocean.ModalViewController = {
        Ocean.Modal(self)
            .withImage(Ocean.icon.calculatorSolid)
            .withTitle("Titulo")
            .withCode(123)
            .withDescription("Lorem Ipsum is <b>simply dummy text</b> of the printing and typesetting industry. Galley of type and scrambled it to make a type specimen book. Galley of type and scrambled it to make a type specimen book. Galley of type and scrambled it to make a type specimen book.")
            .withAction(textNegative: "Cancelar", actionNegative: nil,
                        textPositive: "Ativar", actionPositive: nil)
            .withCode(123)
            .build()
    }()
    
    private lazy var sheetCriticalComponent: Ocean.ModalViewController = {
        Ocean.ModalCritical(self)
            .withTitle("Titulo")
            .withDescription("<b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Galley of type and scrambled it to make a type specimen book?")
            .withDismiss(false)
            .withAction(textNegative: "Cancelar", actionNegative: nil,
                        textPositive: "Recusar", actionPositive: nil)
            .build()
    }()
    
    private lazy var sheetListComponent: Ocean.ModalListViewController = {
        Ocean.ModalList(self)
            .withTitle("Teste")
            .withValues([
                Ocean.CellModel(title: "Title 1", isSelected: true),
                Ocean.CellModel(title: "Title 2")
            ])
            .build()
    }()
    
    private lazy var sheetMultipleChoiceComponent: Ocean.ModelMultipleChoiceViewController = {
        Ocean.ModalMultiChoice(self)
            .withTitle("Multiple Choice")
            .withDismiss(true)
            .withMultipleOptions([
                Ocean.CellModel(title: "Em monitoramento", isSelected: true),
                Ocean.CellModel(title: "Agendado"),
                Ocean.CellModel(title: "Aguardando saldo"),
                Ocean.CellModel(title: "Pago"),
                Ocean.CellModel(title: "Recusado"),
                Ocean.CellModel(title: "Cancelado")
            ])
            .withAction(textNegative: "Cancelar", actionNegative: nil,
                        textPositive: "Filtrar", actionPositive: nil)
            .build()
    }()
    
    private lazy var sheetListWithImageComponent: Ocean.ModalListViewController = {
        Ocean.ModalList(self)
            .withTitle("Teste").withValues([
                Ocean.CellModel(title: "Via PIX", subTitle: "Transferência", imageIcon: Ocean.icon.annotationSolid, hideChevron: false),
                Ocean.CellModel(title: "Via TED", subTitle: "Recebimento", imageIcon: Ocean.icon.archiveSolid, hideChevron: false)
            ])
            .build()
    }()
    
    private lazy var sheetListWithActionsComponent: Ocean.ModalListViewController = {
        Ocean.ModalList(self)
            .withTitle("Test")
            .withValues([
                Ocean.CellModel(title: "Title 1", isSelected: true),
                Ocean.CellModel(title: "Title 2")
            ])
            .withActionPrimary(text: "Primary action",
                               icon: Ocean.icon.plusSolid,
                               action: {
                let alertController = UIAlertController(title: "Test",
                                                        message: "Toched on primary button",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    alertController.dismiss(animated: true)
                })
                self.show(alertController, sender: self)
            })
            .withActionSecondary(text: "Secondary action",
                                 icon: Ocean.icon.minusSolid,
                                 shouldDismiss: false,
                                 action: {
                let alertController = UIAlertController(title: "Test",
                                                        message: "Toched on secondary button",
                                                        preferredStyle: .alert)
                self.sheetListWithActionsComponent.isLoading = true
                alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.sheetListWithActionsComponent.isLoading = false
                    alertController.dismiss(animated: true)
                })
                self.show(alertController, sender: self)
            })
            .build()
    }()
    
    private lazy var customBottomSheet: Ocean.ModalViewController = {
        Ocean.Modal(self)
            .withCustomView(view: UIView())
            .build()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showBottomSheetActionButton() {
        switch showCase {
        case .withActonsNormal:
            sheetComponent.show()
        case .withActonsCritical:
            sheetCriticalComponent.show()
        case .simpleList:
            sheetListComponent.show()
        case .listWithImages:
            sheetListWithImageComponent.show()
        case .listWithActions:
            sheetListWithActionsComponent.show()
        case .customView:
            customBottomSheet.show()
        case .multipleChoice:
            sheetMultipleChoiceComponent.show()
        }
    }
    
    @IBAction func onMainSegmentedChanged(_ sender: Any) {
        if subSegmentControl.numberOfSegments > 2 {
            subSegmentControl.removeSegment(at: 2, animated: true)
        }
        
        switch mainSegmentControl.selectedSegmentIndex {
        case 0:
            subSegmentControl.selectedSegmentIndex = 0
            subSegmentControl.setTitle("Normal", forSegmentAt: 0)
            subSegmentControl.setTitle("Critical", forSegmentAt: 1)
            showCase = .withActonsNormal
        case 1:
            subSegmentControl.selectedSegmentIndex = 0
            subSegmentControl.setTitle("Simple List", forSegmentAt: 0)
            subSegmentControl.setTitle("With Image", forSegmentAt: 1)
            subSegmentControl.insertSegment(withTitle: "With actions", at: 2, animated: true)
            subSegmentControl.insertSegment(withTitle: "Multiple", at: 3, animated: true)
            showCase = .simpleList
        case 2:
            showCase = .customView
        default:
            break
        }
    }
    
    @IBAction func onSubSegmentedChanged(_ sender: Any) {
        switch subSegmentControl.selectedSegmentIndex {
        case 0:
            showCase = mainSegmentControl.selectedSegmentIndex == 0 ? .withActonsNormal : .simpleList
        case 1:
            showCase = mainSegmentControl.selectedSegmentIndex == 0 ? .withActonsCritical : .listWithImages
        case 2:
            if mainSegmentControl.selectedSegmentIndex == 1 {
                showCase = .listWithActions
            }
        case 3:
            if mainSegmentControl.selectedSegmentIndex == 1 {
                showCase = .multipleChoice
            }
        default:
            break
        }
    }
}
