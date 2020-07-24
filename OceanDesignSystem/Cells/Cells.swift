//
//  Cells.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit

class ColorCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var colorRender: UIView!
}

class TypographyCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
}

class BorderCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewWithBorder: UIView!
}

class SpacesCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var spaceSize: NSLayoutConstraint!
}

class StandardCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

class RenderComponentCell: UITableViewCell {
    //@IBOutlet weak var title: UILabel!
    var title: UILabel!
    var container: UIView!
}
