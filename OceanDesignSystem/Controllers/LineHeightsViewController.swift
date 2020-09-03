//
//  LineHeightsViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 07/08/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

public class LineHeightsViewController : UIViewController {
    
    @IBOutlet weak var lineHeights: UISegmentedControl!
    @IBOutlet weak var TextValue: UILabel!
    
    public override func viewDidLoad() {
        TextValue.text = "Soluções de negócios inovadoras e que beneficiam toda a cadeia, do varejo à indústria."
        TextValue.setLineHeight(lineHeight: Ocean.font.lineHeightTight)
    }
    @IBAction func onValueChanged(_ sender: Any) {
        switch lineHeights.selectedSegmentIndex
        {
        case 0:
            TextValue.setLineHeight(lineHeight: Ocean.font.lineHeightTight)
        case 1:
            TextValue.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
        case 2:
            TextValue.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
        default:
            break
        }
    }
}
