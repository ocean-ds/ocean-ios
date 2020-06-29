////
////  OceanExtensionShadow.swift
////  OceanDesignSystem
////
////  Created by Alexandro Gomes on 28/06/20.
////  Copyright © 2020 Blu Pagamentos. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension Ocean {
//    public struct shadow {
//        public static let shadowLevel1 : CALayer = OceanShadow.init().boxShadow(0, height: 4, radius: 8, color: UIColor(red: 12, green: 13, blue: 20, alpha: 0.08))!
//        public static let shadowLevel2 : CALayer = OceanShadow.init().boxShadow(0, height: 8, radius: 16, color: UIColor(red: 12, green: 13, blue: 20, alpha: 0.08))!
//        public static let shadowLevel3 : CALayer = OceanShadow.init().boxShadow(0, height: 16, radius: 32, color: UIColor(red: 12, green: 13, blue: 20, alpha: 0.08))!
//        public static let shadowLevel4 : CALayer = OceanShadow.init().boxShadow(0, height: 16, radius: 48, color: UIColor(red: 12, green: 13, blue: 20, alpha: 0.08))!
//        
//    }
//}
//
//class OceanShadow  {
//    
//    private var customShadow : CALayer?;
//    
//    public func boxShadow(_ width: CGFloat, height: CGFloat, radius: CGFloat, color: UIColor) -> CALayer? {
//        customShadow?.shadowOffset = CGSize(width: width, height: height)
//        customShadow?.shadowRadius = radius
//        customShadow?.shadowColor = color.cgColor
//        
//        return customShadow;
//    }
//    
//}
