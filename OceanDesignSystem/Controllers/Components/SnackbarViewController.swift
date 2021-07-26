//
//  SnackbarViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 13/08/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanComponents
import OceanTokens

public class SnackbarViewController : UIViewController {
    
    @IBOutlet weak var lines: UISegmentedControl!
    @IBOutlet weak var states: UISegmentedControl!
    var snackbar : Ocean.Snackbar!
    
    let texts : [String] = ["Test error in snack bar","Test info in snack bar with 2 lines Test info in snack bar with 2 lines"]
    
    public override func viewDidLoad() {
        
        self.snackbar = Ocean.View.snackbarInfo(builder: { snackbar in
            snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
            snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
        })
        updateSnackBar()
        self.snackbar.show()
        
    }
    func updateSnackBar() {
        self.view.addSubview(self.snackbar)
        self.snackbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(self.generateConstraintsSnackbarTop())
    }
    @IBAction func onValueChangedTextArea(_ sender: Any) {
        switch states.selectedSegmentIndex
        {
        case 0: //Info
            self.snackbar = Ocean.View.snackbarInfo(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            updateSnackBar()
            self.snackbar.show()
            break
        case 1: //Error
            self.snackbar = Ocean.View.snackbarError(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            updateSnackBar()
            self.snackbar.show()
            break
        case 2: //Success
            self.snackbar = Ocean.View.snackbarSuccess(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            updateSnackBar()
            self.snackbar.show()
            break
        case 3: //Warning
            self.snackbar = Ocean.View.snackbarAlert(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            updateSnackBar()
            self.snackbar.show()
            break
        case 4: //+ icon
            self.snackbar = Ocean.View.snackbarInfo(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
                snackbar.snackbarActionText = "Action"
                snackbar.snackbarActionTouch = {
                    let alert = UIAlertController()
                    alert.message = "Action"
                    alert.show(self, sender: nil)
                }
            })
            updateSnackBar()
            self.snackbar.show()
            break
        default:
            break
        }
    }
    
    private func generateConstraintsSnackbarTop() -> [NSLayoutConstraint] {
        let constraintTop = NSLayoutConstraint(item: self.snackbar,
        attribute: .top,
        relatedBy: .equal,
        toItem: view.safeAreaLayoutGuide,
        attribute: .top,
        multiplier: 1.0,
            constant: 500.0)
        let constraintX = NSLayoutConstraint(item: self.snackbar,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: view,
        attribute: .centerX,
        multiplier: 1.0,
        constant: 0.0)
        let constraintWidth = NSLayoutConstraint(item: self.snackbar,
        attribute: .width,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1.0,
        constant: 328)

        return [constraintTop, constraintX, constraintWidth]
    }
}
