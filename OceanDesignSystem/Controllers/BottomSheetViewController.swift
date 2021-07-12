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
        case withActons
        case listWithImages
        case simpleList
    }
    
    @IBOutlet weak var mainSegmentControl: UISegmentedControl!
    @IBOutlet weak var subSegmentControl: UISegmentedControl!
    
    private var showCase: ShowCases = .withActons
    
    private lazy var contentStack: UIStackView = {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 30
        contentStack.distribution = .fillProportionally
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(showSheetButton)
        
        return contentStack
    }()
    
    private lazy var showSheetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.widthAnchor.constraint(equalToConstant: 130).isActive = true
        button.setTitle("Show Sheet", for: .normal)
        button.addTarget(self, action: #selector(showBottomSheetActionButton), for: .touchUpInside)
        return button
    }()

    private lazy var sheetComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheet(self)
            .withImage(Ocean.icon.calculatorSolid)
            .withTitle("Titulo")
            .withDescription("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Galley of type and scrambled it to make a type specimen book.")
            .withAction(textNegative: "Cancelar", actionNegative: nil,
                        textPositive: "Ativar", actionPositive: nil)
            .withCode("123")
            .build()
    }()
    
    private lazy var sheetListComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheetList(self)
            .withTitle("Teste").withValues([
                Ocean.CellModel(title: "Teste 1"),
                Ocean.CellModel(title: "Teste 2"),
            ])
            .build()
    }()
    
    private lazy var sheetListWithImageComponent: Ocean.BottomSheetViewController = {
        Ocean.BottomSheetList(self)
            .withTitle("Teste").withValues([
                Ocean.CellModel(title: "Via PIX", subTitle: "Transferência grátis e imediata", imageIcon: Ocean.icon.adjustmentsSolid),
                Ocean.CellModel(title: "Via TED", subTitle: "Recebimento em até um dia útil", imageIcon: Ocean.icon.annotationSolid),
                Ocean.CellModel(title: "Via TED", subTitle: "Recebimento em até um dia útil", imageIcon: Ocean.icon.annotationSolid),
                Ocean.CellModel(title: "Via TED", subTitle: "Recebimento em até um dia útil", imageIcon: Ocean.icon.annotationSolid)
                
            ])
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
    
    @objc private func showBottomSheetActionButton() {
        switch showCase {
        case .withActons:
            sheetComponent.show()
        case .simpleList:
            sheetListComponent.show()
        case .listWithImages:
            sheetListWithImageComponent.show()
        }
    }
    
    @IBAction func onMainSegmentedChanged(_ sender: Any) {
        switch mainSegmentControl.selectedSegmentIndex {
        case 0:
            subSegmentControl.isHidden = true
            showCase = .withActons
        case 1:
            subSegmentControl.isHidden = false
            showCase = .simpleList
        default:
            break
        }
    }
    
    @IBAction func onSubSegmentedChanged(_ sender: Any) {
        switch subSegmentControl.selectedSegmentIndex {
        case 0:
            showCase = .simpleList
        case 1:
            subSegmentControl.isHidden = false
            showCase = .listWithImages
        default:
            break
        }
    }
}
