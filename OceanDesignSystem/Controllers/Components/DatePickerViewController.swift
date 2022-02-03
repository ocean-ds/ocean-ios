//
//  DatePickerViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 21/06/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class DatePickerViewController : UIViewController {
    private var datePicker: Ocean.DatePicker!
    private var button: Ocean.ButtonPrimary!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        datePicker = Ocean.DatePicker { datePicker in
            datePicker.currentDate = Date()
            datePicker.minimumDate = Date()
            datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 20, to: Date())
            datePicker.datesToHide = []
            datePicker.onReleaseCalendar = { date in
                self.button.text = date.description
            }
        }
        button = Ocean.Button.primaryMD { button in
            button.text = "Abrir Date Picker"
            button.onTouch = {
                self.datePicker.show(rootViewController: self)
            }
        }
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(button)
        
        self.add(view: stack)
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
