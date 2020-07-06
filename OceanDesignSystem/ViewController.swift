//
//  ViewController.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class ViewController: UIViewController {

    @IBOutlet weak var labelTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // The interesting stuff
        let labelShadow = UILabel(frame: CGRect(x: 50, y: 200, width: 120, height: 20))
        //viewShadow.center = container.center
        labelShadow.backgroundColor = UIColor.clear
        labelTest.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: Ocean.font.fontSizeXs)
        
        labelShadow.textColor = UIColor.black
        labelShadow.applyShadow(parameters: Ocean.shadow.shadowLevel4)
        self.view.addSubview(labelShadow)
        //self.view.backgroundColor = color.articleBody
        //self.view.backgroundColor = Ocean.articleBody.color
        //self.view.backgroundColor = OceanColors.articleBody
        
        //OceanColor.articleBody
        //Ocean.
        //Ocean.color.articleBody
        //self.view.backgroundColor = Ocean.color.colorBrandPrimaryPure
        
    }


}

