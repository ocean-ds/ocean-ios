//
//  BottomSheetViewController.swift
//  OceanDesignSystem
//
//  Created by Pedro Azevedo on 09/07/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class BottomSheetViewController: UIViewController {
    enum ShowCases {
        case withActonsNormal
        case withActonsCritical
        case listWithImages
        case simpleList
        case customView
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
            button.text = "Show Sheet"
            button.onTouch = self.showBottomSheetActionButton
        }
    }()

    private lazy var sheetComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheet(self)
            .withImage(Ocean.icon.calculatorSolid)
            .withTitle("Titulo")
            .withCode("123")
            .withDescription("Lorem Ipsum is <b>simply dummy text</b> of the printing and typesetting industry. Galley of type and scrambled it to make a type specimen book.")
            .withAction(textNegative: "Cancelar", actionNegative: nil,
                        textPositive: "Ativar", actionPositive: nil)
            .withCode("123")
            .build()
    }()
    
    private lazy var sheetCriticalComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheetCritical(self)
            .withTitle("Titulo")
            .withDescription("<b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Galley of type and scrambled it to make a type specimen book?")
            .withAction(textNegative: "Cancelar", actionNegative: nil,
                        textPositive: "Recusar", actionPositive: nil)
            .build()
    }()
    
    private lazy var sheetListComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheetList(self)
            .withTitle("Teste")
            .withValues([
                Ocean.CellModel(title: "Teste 1"),
                Ocean.CellModel(title: "Teste 2"),
            ])
            .build()
    }()
    
    private lazy var sheetListWithImageComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheetList(self)
            .withTitle("Teste").withValues([
                Ocean.CellModel(title: "Via PIX", subTitle: "Transferência", imageIcon: Ocean.icon.annotationSolid, hideChevron: false),
                Ocean.CellModel(title: "Via TED", subTitle: "Recebimento", imageIcon: Ocean.icon.archiveSolid, hideChevron: false)
            ])
            .build()
    }()
    
    private lazy var customBottomSheet: Ocean.BottomSheetViewController = {
        Ocean.BottomSheet(self)
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
        case .customView:
            customBottomSheet.show()
        }
    }
    
    @IBAction func onMainSegmentedChanged(_ sender: Any) {
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
        default:
            break
        }
    }
}
