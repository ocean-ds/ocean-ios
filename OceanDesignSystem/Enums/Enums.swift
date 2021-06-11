//
//  Enums.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation

enum CategoryType: Int {
    case Color
    case Shadow
    case Size
    case Typography
}

public enum SubCategoryTypograpyType: Int {
    case FontFamilyWithWeight
    case FontSize
    case FontLineHeight
}

public enum SubCategorySizeType: Int {
    case Border
    case Opacity
    case SpacingInline
}

public enum DesignSystemComponentsType: Int {
    case Typography
    case Button
    case TextArea
    case Snackbar
    case Switch
    case BottomSheet
}

public enum DesignSystemTypographyType: Int {
    case Headings
    case Subtitle
    case Paragraph
    case Description
    case Caption
}

public enum DesignSystemButtonType: Int {
    case ButtonPrimary
    case ButtonSecondary
    case ButtonText
    case ButtonInverse
    //case ButtonBlocked
}
