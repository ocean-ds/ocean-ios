//
//  UIView+Extensions.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens


extension UIView {
  public func applyShadow2(parameters: Ocean.shadow.ShadowParameters){
      self.layer.shadowOffset = CGSize(width: parameters["x"] as! Int, height: parameters["y"] as! Int)
      self.layer.shadowRadius = CGFloat(parameters["radius"] as! Int)
      let color = UIColor(red: CGFloat(parameters["red"] as! Int) / 255,
                        green: CGFloat(parameters["green"] as! Int)  / 255,
                        blue: CGFloat(parameters["blue"] as! Int) / 255,
                        alpha: CGFloat(parameters["alpha"] as! Double))
      self.layer.shadowColor = color.cgColor
      self.layer.shadowOpacity = 1
  }
}
