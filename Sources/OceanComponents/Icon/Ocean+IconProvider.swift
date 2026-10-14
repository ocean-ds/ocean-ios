//
//  Ocean+IconProvider.swift
//  OceanComponents
//

import UIKit

public extension Ocean {
    /// Ícones que não são do Ocean (ex.: Product Icons do app). Consultado só quando o token não é do Ocean.
    static var iconProvider: ((String) -> UIImage?)?
}
