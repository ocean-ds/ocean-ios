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

public enum DesignSystemComponentsType: String {
    case Typography
    case Button
    case Input
    case Snackbar
    case Switch
    case Modal
    case RadioButton
    case DatePicker
    case AlertBox
    case Divider
    case Tooltip
    case TextList
    case NavigationBar
    case CardOption
    case CheckBox
    case ProgressIndicator
    case BottomNavigationBar
    case Carousel
    case Shortcut
    case Balance
    case BalanceSimple
    case Tag
    case Badge
    case TransactionFooter
    case TransactionList
    case FloatVerticalMenuList
    case Tab
    case CardGroup
    case Subheader
    case Step
    case Chips
    case ParentChildTextList
    case CardCrossSell
    case GroupCTA
    case CardListItem
    case OrderedListItem
    case SettingsListItem
    case FilterBar
    case ChartCard
    case InformativeCard
    case ProgressBar
    case DetailedCard
    case Accordion
    case Link
    case Onboarding
    case CheckBoxGroup
    case StatusListItem
}

public enum DesignSystemComponentsSwiftUIType: String {
    case Accordion
    case Alert
    case Badge
    case Balance
    case Button
    case CardCrossSell
    case CardCTA
    case CardGroup
    case CardListItem
    case CardOption
    case Carousel
    case ChartBar
    case ChartCard
    case CheckboxGroup
    case ContentList
    case Divider
    case Input
    case InvertedTextListItem
    case InlineTextListItem
    case ExpandableTextListItem
    case FileUploader
    case FilterBar
    case Link
    case Onboarding
    case OrderedListItem
    case ParentChild
    case ProgressBar
    case ProgressIndicator
    case RadioButtonGroup
    case ScoreChart
    case ScrollableTab
    case SettingsListItem
    case Shortcut
    case SimpleBalance
    case StatusListItem
    case Subheader
    case Step
    case Switch
    case Tab
    case Tag
    case TextListItem
    case Tooltip
    case TransactionFooter
    case TransactionListItem
    case Typography

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
}
