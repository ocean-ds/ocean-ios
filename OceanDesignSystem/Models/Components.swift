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
        "Secondary"
//        "Text",
//        "PrimaryInverse",
//        "PrimaryBlocked"
    ]
}

public class Headings {
    
    static let heading1 = Ocean.Typography.heading1 { label in
        label.text = "Heading1"
    }
    static let heading2 = Ocean.Typography.heading2 { label in
        label.text = "Heading2"
    }
    
    static let heading3 = Ocean.Typography.heading3 { label in
        label.text = "Heading3"
    }
    
    static let heading4 = Ocean.Typography.heading4 { label in
        label.text = "Heading4"
    }
    
    static let heading1Inverse = Ocean.Typography.heading1Inverse { label in
        label.text = "Heading1Inverse"
        label.backgroundColor = UIColor.blue
    }
    static let heading2Inverse = Ocean.Typography.heading2Inverse { label in
        label.text = "Heading2Inverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let heading3Inverse = Ocean.Typography.heading3Inverse { label in
        label.text = "Heading3Inverse"
        label.backgroundColor = UIColor.blue
    }
    
    static let heading4Inverse = Ocean.Typography.heading4Inverse { label in
        label.text = "Heading4Inverse"
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
        label.text = "Subtitle1"
    }
    static let subtitle2 = Ocean.Typography.subTitle2 { label in
        label.text = "Subtitle2"
    }
    
    static let subtitle1Inverse = Ocean.Typography.subTitle1Inverse() { label in
        label.text = "Subtitle1Inverse"
        label.backgroundColor = UIColor.blue
    }
    static let subtitle2Inverse = Ocean.Typography.subTitle2Inverse() { label in
        label.text = "Subtitle2Inverse"
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
        label.text = "Paragraph"
    }
    static let paragraphInverse = Ocean.Typography.paragraphInverse { label in
        label.text = "ParagraphInverse"
        label.backgroundColor = UIColor.blue
    }
    static let highlightedParagraph = Ocean.Typography.highlightedParagraph { label in
        label.text = "HighlightedParagraph"
    }
    static let list = [
        paragraph,
        paragraphInverse,
        highlightedParagraph
    ]
}

struct Description {
    
    static let description = Ocean.Typography.description { label in
        label.text = "Description"
    }
    static let descriptionInverse = Ocean.Typography.descriptionInverse { label in
        label.text = "DescriptionInverse"
        label.backgroundColor = UIColor.blue
    }
    
    
    static let list = [
        description,
        descriptionInverse
    ]
}

struct Caption {
    
    static let caption = Ocean.Typography.caption { label in
        label.text = "Caption"
    }
    static let captionInverse = Ocean.Typography.captionInverse { label in
        label.text = "CaptionInverse"
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
    
    static let list = [
        primarySM,
        primaryMD,
        primaryLG,
        primaryLGDisable,
        primaryLGLoading,
        primaryLGIcon
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
    
    static let list = [
        secondarySM,
        secondaryMD,
        secondaryLG,
        secondaryLGDisable,
        secondaryLGIcon
    ]
}
