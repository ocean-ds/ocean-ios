//
//  Color+mix.swift
//  Ocean
//
//  Created by Vinicius  Consulmagnos Romeiro on 28/01/26.
//

import SwiftUI
import UIKit

extension Color {
    func mix(with color: Color, by percentage: Double) -> Color {
        if #available(iOS 14.0, *) {
            let uiColor1 = UIColor(self)
            let uiColor2 = UIColor(color)
            
            var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
            var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
            
            uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
            uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
            
            return Color(
                red: r1 + (r2 - r1) * percentage,
                green: g1 + (g2 - g1) * percentage,
                blue: b1 + (b2 - b1) * percentage,
                opacity: a1 + (a2 - a1) * percentage
            )
        } else {
            return self
        }
    }
}
