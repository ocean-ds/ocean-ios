//
//  ModalCellProtocol.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 21/04/23.
//

import Foundation
import OceanTokens

public protocol ModalCellProtocol: UITableViewCell {
    var model: Ocean.CellModel? { get set }
}
