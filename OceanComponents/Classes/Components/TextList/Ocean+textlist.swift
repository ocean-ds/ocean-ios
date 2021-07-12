//
//  Ocean+textlist.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public typealias TextListCellBuilder = (TextListCell) -> Void
    
    public struct TextList {
        public static func cell(builder: TextListCellBuilder) -> TextListCell {
            return TextListCell(builder: builder)
        }
        
        public static func cellInverse(builder: TextListCellBuilder) -> TextListCell {
            let textList = TextListCell(builder: builder)
            textList.titleLabel.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            textList.titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            textList.subtitleLabel.font = .baseRegular(size: Ocean.font.fontSizeXs)
            textList.subtitleLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            textList.subtitleLabel.numberOfLines = 2
            return textList
        }
        
        public static func cellInverseHighlight(builder: TextListCellBuilder) -> TextListCell {
            let textList = TextListCell(builder: builder)
            textList.titleLabel.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            textList.titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            textList.subtitleLabel.font = .baseSemiBold(size: Ocean.font.fontSizeSm)
            textList.subtitleLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            textList.subtitleLabel.numberOfLines = 2
            return textList
        }
    }
}
