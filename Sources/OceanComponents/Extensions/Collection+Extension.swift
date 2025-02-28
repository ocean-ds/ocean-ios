//
//  Collection+extension.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 29/08/23.
//

import Foundation

extension Collection {
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
