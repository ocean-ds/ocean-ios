//
//  ModalViewControllerV2.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 19/04/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class ModalViewControllerV2: UIViewController {
    
    private let segmentedControl = UISegmentedControl(items: [])
    private let subSegmentedControl = UISegmentedControl(items: [])

    private func setupMainSegmenteControl() {
        segmentedControl.insertSegment(withTitle: "With actions", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "List style", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Custom view", at: 2, animated: true)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

    }
    
    @objc func segmentedControlValueChanged(_ sender: Any) {
        
//        if subSegmentedControl.numberOfSegments > 2 {
//            subSegmentedControl.removeSegment(at: 2, animated: true)
//        }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            subSegmentedControl.insertSegment(withTitle: "With actions", at: 0, animated: true)
            subSegmentedControl.insertSegment(withTitle: "With actions", at: 1, animated: true)
            subSegmentedControl.selectedSegmentIndex = 0
            print("\(String(describing: segmentedControl.titleForSegment(at: 0)))")
        case 1:
            subSegmentedControl.insertSegment(withTitle: "With actions", at: 0, animated: true)
            subSegmentedControl.insertSegment(withTitle: "With actions", at: 1, animated: true)
            subSegmentedControl.insertSegment(withTitle: "With actions", at: 2, animated: true)
            subSegmentedControl.selectedSegmentIndex = 0
            print("\(String(describing: segmentedControl.titleForSegment(at: 1)))")
        case 2:
            print("\(String(describing: segmentedControl.titleForSegment(at: 2)))")
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupMainSegmenteControl()
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .systemBlue
        
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
