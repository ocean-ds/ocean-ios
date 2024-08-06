//
//  View+border.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 26/12/23.
//

import SwiftUI

extension View {
    public func border(cornerRadius: CGFloat = 0, width: CGFloat = 0, color: UIColor = .black) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .inset(by: width)
                .stroke(Color(color), lineWidth: width)
        )
        .cornerRadius(cornerRadius)
    }
}
