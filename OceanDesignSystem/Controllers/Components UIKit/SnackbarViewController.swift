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
import UIKit

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
        self.snackbar.show(in: self.view)
        
    }

    @IBAction func onValueChangedTextArea(_ sender: Any) {
        switch states.selectedSegmentIndex
        {
        case 0: //Info
            self.snackbar = Ocean.View.snackbarInfo(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            self.snackbar.show(in: self.view)
            break
        case 1: //Error
            self.snackbar = Ocean.View.snackbarError(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            self.snackbar.show(in: self.view)
            break
        case 2: //Success
            self.snackbar = Ocean.View.snackbarSuccess(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            self.snackbar.show(in: self.view)
            break
        case 3: //Warning
            self.snackbar = Ocean.View.snackbarAlert(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
            })
            self.snackbar.show(in: self.view)
            break
        case 4: //+ icon
            self.snackbar = Ocean.View.snackbarSuccess(builder: { snackbar in
                snackbar.line =  self.lines.selectedSegmentIndex == 0 ? .one : .two
                snackbar.snackbarText = self.texts[self.lines.selectedSegmentIndex]
                snackbar.snackbarActionText = "Desfazer"
                snackbar.snackbarActionTouch = {
                    let alert = UIAlertController(title: "Alert", message: "Action", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        print("You've pressed ok")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            self.snackbar.show(in: self.view, duration: 4, completion: {
                let alert = UIAlertController(title: "Alert", message: "Snackbar is not visible anymore", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    print("You've pressed ok")
                }))
                self.present(alert, animated: true, completion: nil)
            })
            break
        default:
            break
        }
    }
}
