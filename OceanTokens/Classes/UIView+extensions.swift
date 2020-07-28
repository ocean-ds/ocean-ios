//
//  UIView+superviewConstraints.swift
//  Blu
//
//  Created by Victor C Tavernari on 29/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    public func applyRadius(radius: CGFloat){
      
          self.layer.borderWidth = Ocean.size.borderWidthThin
          if (radius.isInteger == false) {
              self.layer.cornerRadius = self.bounds.height * radius
          } else {
              if (radius >= Ocean.size.borderRadiusPill) {
                  self.layer.cornerRadius = Ocean.size.borderRadiusCircular * self.bounds.height
              } else {
                  self.layer.cornerRadius = radius
              }
          }
    }
}
