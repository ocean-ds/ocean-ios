//
//  UIColor+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 13/07/21.
//

import UIKit

public extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: UIScreen.main.bounds.width, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }

    var toHexString: String? {
        if let components = self.cgColor.components {
            let colorRed = components[0]
            let colorGreen = components[1]
            let colorBlue = components[2]
            return String(format: "#%02x%02x%02x",
                          (Int)(colorRed * 255),
                          (Int)(colorGreen * 255),
                          (Int)(colorBlue * 255))
        }

        return nil
    }
}
