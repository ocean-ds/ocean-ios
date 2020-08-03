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
    @IBOutlet weak var constraintViewHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintViewWidth: NSLayoutConstraint!
}

class SpacesCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewLeftTop: UIView!
    @IBOutlet weak var viewRightTop: UIView!
    @IBOutlet weak var viewLeftBottom: UIView!
    @IBOutlet weak var viewRightBottom: UIView!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var spaceSize: NSLayoutConstraint!
    @IBOutlet var spacesInset: [NSLayoutConstraint]!
    @IBOutlet var spacesInline: [NSLayoutConstraint]!
    @IBOutlet var spacesStack: [NSLayoutConstraint]!
}

class StackSpacesCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewStackRender: UIView!
    @IBOutlet weak var stackSize: NSLayoutConstraint!
    
}

class InsetSpacesCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewStackRender: UIView!
    @IBOutlet var insetSizes: [NSLayoutConstraint]!
    
}

class InlineSpacesCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewStackRender: UIView!
    @IBOutlet weak var inlineSize: NSLayoutConstraint!
    
}

class StandardCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

class RenderComponentCell: UITableViewCell {
    //@IBOutlet weak var title: UILabel!
    var title: UILabel!
    var container: UIView!
}

class ButtonComponentCell: UITableViewCell {
    //@IBOutlet weak var title: UILabel!
    @IBOutlet weak var container: UIView!
}
