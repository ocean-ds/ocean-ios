//
//  String+HtmlToMarkdown.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 01/12/23.
//

import Foundation
import SwiftUI

extension String {
    public func htmlToMarkdown() -> LocalizedStringKey {
        var markdownString = self
        
        let htmlToMarkdownRules: [String: String] = [
            "<b>": "**",
            "</b>": "**",
            "<i>": "*",
            "</i>": "*",
            "<br>": "\n",
            "<br/>": "\n",
            "<p>": "",
            "</p>": "\n\n",
            "<del>": "~~",
            "</del>": "~~"
        ]

        htmlToMarkdownRules.forEach { html, markdown in
            markdownString = markdownString.replacingOccurrences(of: html, with: markdown)
        }

        return LocalizedStringKey(markdownString)
    }
}
