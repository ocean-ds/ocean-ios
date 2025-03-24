//
//  ModalCellProtocol.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 21/04/23.
//

import Foundation
import OceanTokens
import UIKit

public protocol ModalCellProtocol: UITableViewCell {
    var model: Ocean.CellModel? { get set }
}
