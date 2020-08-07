//
//  Components.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanComponents
import OceanTokens

struct DSComponents {
    static let list = [
        "Typography",
        "Button"
    ]
}

struct DSTypographies {
    static let list = [
        "Headings",
        "Subtitles",
        "Paragraph",
        "Description",
        "Caption"
    ]
}

struct DSButtons {
    static let list = [
        "Primary",
        "Secondary",
        "Text",
        "PrimaryInverse"
    ]
}

public class Headings {
    
    static let heading1 = Ocean.Typography.heading1 { label in
        label.text = "Heading1 Heading1 Heading1 Heading1"
    }
    static let heading2 = Ocean.Typography.heading2 { label in
        label.text = "Heading2 Heading2 Heading2 Heading2"
    }
    
    static let heading3 = Ocean.Typography.heading3 { label in
        label.text = "Heading3 Heading3 Heading3 Heading3"
    }
    
    static let heading4 = Ocean.Typography.heading4 { label in
        label.text = "Heading4 Heading4 Heading4 Heading4 Heading4 Heading4 Heading4 Heading4"
    }
    
    static let heading1Inverse = Ocean.Typography.heading1Inverse { label in
        label.text = "Heading1Inverse Heading1Inverse"
        label.backgroundColor = UIColor.blue
    }
    static let heading2Inverse = Ocean.Typography.heading2Inverse { label in
        label.text = "Heading2Inverse Heading2Inverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let heading3Inverse = Ocean.Typography.heading3Inverse { label in
        label.text = "Heading3Inverse Heading3Inverse Heading3Inverse Heading3Inverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let heading4Inverse = Ocean.Typography.heading4Inverse { label in
        label.text = "Heading4Inverse Heading4Inverse Heading4Inverse Heading4Inverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let list = [
        heading1,
        heading2,
        heading3,
        heading4,
        heading1Inverse,
        heading2Inverse,
        heading3Inverse,
        heading4Inverse
    ]
}

struct Subtitles {
    
    static let subtitle1 = Ocean.Typography.subTitle1 { label in
        label.text = "Subtitle1 Subtitle1 Subtitle1 Subtitle1"
    }
    static let subtitle2 = Ocean.Typography.subTitle2 { label in
        label.text = "Subtitle2 Subtitle2 Subtitle2 Subtitle2 Subtitle2"
    }
    
    static let subtitle1Inverse = Ocean.Typography.subTitle1Inverse() { label in
        label.text = "Subtitle1Inverse Subtitle1Inverse Subtitle1Inverse"
        label.backgroundColor = UIColor.blue
    }
    static let subtitle2Inverse = Ocean.Typography.subTitle2Inverse() { label in
        label.text = "Subtitle2Inverse Subtitle2Inverse Subtitle2Inverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let list = [
        subtitle1,
        subtitle2,
        subtitle1Inverse,
        subtitle2Inverse
    ]
}

struct Paragraph {
    
    static let paragraph = Ocean.Typography.paragraph { label in
        label.text = "Paragraph Paragraph Paragraph Paragraph Paragraph Paragraph"
    }
    static let paragraphInverse = Ocean.Typography.paragraphInverse { label in
        label.text = "ParagraphInverse ParagraphInverse ParagraphInverse ParagraphInverse"
        label.backgroundColor = UIColor.blue
    }
    static let highlightedParagraph = Ocean.Typography.highlightedParagraph { label in
        label.text = "HighlightedParagraph HighlightedParagraph"
    }
    static let list = [
        paragraph,
        paragraphInverse,
        highlightedParagraph
    ]
}

struct Description {
    
    static let description = Ocean.Typography.description { label in
        label.text = "Description Description Description Description Description Description"
    }
    static let descriptionInverse = Ocean.Typography.descriptionInverse { label in
        label.text = "DescriptionInverse DescriptionInverse DescriptionInverse DescriptionInverse"
        label.backgroundColor = UIColor.blue
    }
    
    
    static let list = [
        description,
        descriptionInverse
    ]
}

struct Caption {
    
    static let caption = Ocean.Typography.caption { label in
        label.text = "Caption Caption Caption Caption Caption Caption Caption Caption"
    }
    static let captionInverse = Ocean.Typography.captionInverse { label in
        label.text = "CaptionInverse CaptionInverse CaptionInverse CaptionInverse CaptionInverse CaptionInverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let list = [
        caption,
        captionInverse
    ]
}

struct PrimaryButtons {
    
    static let primarySM = Ocean.Button.primarySM { button in
        button.text = "Small"
    }
    
    static let primaryMD = Ocean.Button.primaryMD { button in
        button.text = "Medium"
    }
    
    static let primaryLG = Ocean.Button.primaryLG { button in
        button.text = "Large"
    }
    
    static let primaryLGDisable = Ocean.Button.primaryLG { button in
        button.text = "Disabled"
    }
    
    static let primaryLGLoading = Ocean.Button.primaryLG { button in
        button.text = "Loading"
    }
    
    static let primaryLGIcon = Ocean.Button.primaryLG { button in
        button.text = "Icon"
        button.icon = Ocean.icon.addLg
    }
    
    static let primaryBlockedLG = Ocean.Button.primaryBlockedLG { button in
        button.text = "Large"
    }
    
    static let list = [
        primarySM,
        primaryMD,
        primaryLG,
        primaryLGDisable,
        primaryLGLoading,
        primaryLGIcon,
        primaryBlockedLG
    ]
}

struct SecondaryButtons {
    
    static let secondarySM = Ocean.Button.secondarySM { button in
        button.text = "Small"
    }
    
    static let secondaryMD = Ocean.Button.secondaryMD { button in
        button.text = "Medium"
    }
    
    static let secondaryLG = Ocean.Button.secondaryLG { button in
        button.text = "Large"
    }
    
    static let secondaryLGDisable = Ocean.Button.secondaryLG { button in
        button.text = "Disabled"
    }
    
    static let secondaryLGIcon = Ocean.Button.secondaryLG { button in
        button.text = "Icon"
        button.icon = Ocean.icon.addLg
    }
    
    static let secondaryBlockedLG = Ocean.Button.secondaryBlockedLG { button in
        button.text = "Large"
    }
    
    static let list = [
        secondarySM,
        secondaryMD,
        secondaryLG,
        secondaryLGDisable,
        secondaryLGIcon,
        secondaryBlockedLG
    ]
}

struct TextButtons {
    
    static let textSM = Ocean.Button.textSM { button in
        button.text = "Small"
    }
    
    static let textMD = Ocean.Button.textMD { button in
        button.text = "Medium"
    }
    
    static let textLG = Ocean.Button.textLG { button in
        button.text = "Large"
    }
    
    static let textLGDisable = Ocean.Button.textLG { button in
        button.text = "Disabled"
    }
    
    static let textLGIcon = Ocean.Button.textLG { button in
        button.text = "Icon"
        button.icon = Ocean.icon.addLg
    }
    static let textBlockedLG = Ocean.Button.textBlockedLG { button in
        button.text = "Large"
    }
    
    static let list = [
        textSM,
        textMD,
        textLG,
        textLGDisable,
        textLGIcon,
        textBlockedLG
    ]
}

struct PrimaryInverseButtons {
    
    static let primaryInverseSM = Ocean.Button.primaryInverseSM { button in
        button.text = "Small"
    }
    
    static let primaryInverseMD = Ocean.Button.primaryInverseMD { button in
        button.text = "Medium"
    }
    
    static let primaryInverseLG = Ocean.Button.primaryInverseLG { button in
        button.text = "Large"
    }
    
    static let primaryInverseLGDisabled = Ocean.Button.primaryInverseLG { button in
        button.text = "Disabled"
    }
    
    static let primaryInverseLGLoading = Ocean.Button.primaryInverseLG { button in
        button.text = "Loading"
    }
    
    static let primaryInverseLGIcon = Ocean.Button.primaryInverseLG { button in
        button.text = "Icon"
        button.icon = Ocean.icon.addLg
    }
    
    static let primaryInverseBlockedLGIcon = Ocean.Button.primaryInverseBlockedLG { button in
        button.text = "Large"
    }
    
    static let list = [
        primaryInverseSM,
        primaryInverseMD,
        primaryInverseLG,
        primaryInverseLGDisabled,
        primaryInverseLGLoading,
        primaryInverseLGIcon,
        primaryInverseBlockedLGIcon
    ]
}


//struct PrimaryBlockedButtons {
//    
//    
//    static let primaryBlockedMD = Ocean.Button.primaryBlockedMD { button in
//        button.text = "Medium"
//    }
//    
//    static let primaryBlockedMDDisabled = Ocean.Button.primaryBlockedMD { button in
//        button.text = "Disabled"
//    }
//    
//    static let primaryBlockedMDLoading = Ocean.Button.primaryBlockedMD { button in
//        button.text = "Loading"
//    }
//    
//    static let list = [
//        primaryBlockedMD,
//        primaryBlockedMDDisabled,
//        primaryBlockedMDLoading
//    ]
//}
