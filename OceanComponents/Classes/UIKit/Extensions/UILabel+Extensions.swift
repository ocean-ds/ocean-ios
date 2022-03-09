//
//  UILabel+Extensions.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

extension UILabel {
    
    public func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }

    private func createMutableAttributedString(string: String? = nil) -> NSMutableAttributedString? {
        let text = string ?? self.text

        guard let labelText = text else {
            return nil
        }

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText, labelattributedText.string == labelText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        return attributedString
    }

    /**
     Mudar a color de uma parte do texto.
     */
    public func changeColorOfPartOfText(_ fullText: String, coloredText: String, color: UIColor, fonte: UIFont? = nil) {
        let texto: NSString = fullText as NSString
        let range = (texto).range(of: coloredText)

        guard let attributedText = createMutableAttributedString(string: fullText) else {
            return
        }

        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        if let fonte = fonte {
            attributedText.addAttribute(.font, value: fonte, range: range)
        }
        self.attributedText = attributedText
    }

    /**
     Alterar a fonte de parte do texto.
     */
    public func setPartOfTextInBold(_ fullText: String, boldText: String, boldFont: UIFont? = nil, boldColor: UIColor? = nil) {
        let font = boldFont ?? UIFont.baseBold(size: self.font.pointSize)
        changeColorOfPartOfText(fullText, coloredText: boldText, color: boldColor ?? self.textColor, fonte: font)
    }


    /**
    Sublinha o texto.
    */
    public func underlineText(fullText: String? = nil, underlinedText: String, underlinedTextColor: UIColor, lineColor: UIColor? = nil, lineStyle: Int = NSUnderlineStyle.single.rawValue) {

        let text: NSString = (fullText ?? self.text ?? "") as NSString
        let range = (text).range(of: underlinedText)

        guard let attributedText = createMutableAttributedString(string: fullText) else {
            return
        }

        let attributes: [NSAttributedString.Key : Any] = [
            .underlineColor: lineColor ?? underlinedTextColor,
            .foregroundColor: underlinedTextColor,
            .underlineStyle: lineStyle
        ]
        attributedText.addAttributes(attributes, range: range)

        self.attributedText = attributedText
    }

    /**
     Altera a fonte dos textos que estão entre a tag <b></b>
     */
    public func setTextWithBoldTag(_ fullText: String, boldFont: UIFont? = nil, boldColor: UIColor? = nil) {
        self.text = fullText
        guard fullText.contains("<b>") else {
            return
        }

        fullText.extractSupposedBoldWords { (boldWords) in
            let textoPuro = fullText.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")

            for word in boldWords {
                self.setPartOfTextInBold(textoPuro, boldText: word, boldFont: boldFont, boldColor: boldColor)
            }
        }
    }
}
