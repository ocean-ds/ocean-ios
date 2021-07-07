//
//  UIImage+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 07/07/21.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.set()
        self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: self.size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
