//
//  EdgeInsets+Extensions.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 15/03/24.
//

import Foundation
import SwiftUI

extension EdgeInsets {
    public static func all(_ size: CGFloat) -> Self {
        return .init(top: size, leading: size, bottom: size, trailing: size)
    }

    public static func horizontal(_ size: CGFloat) -> Self {
        return .init(top: 0, leading: size, bottom: 0, trailing: size)
    }

    public static func vertical(_ size: CGFloat) -> Self {
        return .init(top: size, leading: 0, bottom: size, trailing: 0)
    }
}
