//
//  String+Extensions.swift
//  OceanComponents
//
//  Created by Leticia Fernandes on 09/03/22.
//

import Foundation
import OceanTokens

public extension String {

    func htmlToAttributedText(font: UIFont = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXs)!,
                              size: CGFloat,
                              color: UIColor,
                              textAlign: NSTextAlignment = .left) -> NSAttributedString? {
        let htmlTemplate = """
            <!doctype html>
            <html>
              <head>
                <style>
                  body {
                    color: \(color.toHexString!);
                    font-family: '\(font.familyName)',-apple-system;
                    font-size: \(size)px;
                    text-align: \(getAlignValue(textAlign: textAlign));
                  }
                </style>
              </head>
              <body>
                \(self)
              </body>
            </html>
            """

        guard let data = htmlTemplate.data(using: String.Encoding.utf8) else {
            return nil
        }
        guard let attributedString = try? NSAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes: nil) else { return nil }
        return attributedString
    }

    private func getAlignValue(textAlign: NSTextAlignment) -> String {
        switch textAlign {
        case .center:
            return "center"
        case .right:
            return "right"
        case .justified:
            return "justify"
        default:
            return "left"
        }
    }

    func extractSupposedBoldWords(completion: @escaping ([String]) -> Void) {
        let query = self
        let regex = try! NSRegularExpression(pattern:"<b>(.*?)</b>", options: [])
        var results = [String]()

        regex.enumerateMatches(in: query, options: [], range: NSMakeRange(0, query.utf16.count)) { result, flags, stop in
            if let r = result?.range(at: 1), let range = Range(r, in: query) {
                results.append(String(query[range]))
            }
            completion(results)
        }

        //Fonte: https://stackoverflow.com/questions/35995942/regex-to-get-string-between-two-characters?rq=1
    }

    /**
        Uni duas strings que representa uma moeda e um valor financeiro com intuito de não quebrar linha.
     Exemplo:
        R$ 5.000
     Evita acontecer isto:
        R$
        5.0000
     */

    func replaceSpaceWithUnicode() -> String {
        let pat = "\\bR(\\$) \\b"
        let unicode = "R$\u{00A0}"
        let regex = try? NSRegularExpression(pattern: pat)

        return regex?.stringByReplacingMatches(in: self, options: [], range: NSRange(0..<self.count), withTemplate: unicode) ?? self
    }

    func replaceBrTag() -> String {
        return self.replacingOccurrences(of: "</br>", with: "\n").replacingOccurrences(of: "<br>", with: "\n")
    }
}
