//
//  String+Extensions.swift
//  OceanComponents
//
//  Created by Leticia Fernandes on 09/03/22.
//

import Foundation

extension String {
    public func extractSupposedBoldWords(completion: @escaping ([String]) -> Void) {
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

    public func replaceSpaceWithUnicode() -> String {
        let pat = "\\bR(\\$) \\b"
        let unicode = "R$\u{00A0}"
        let regex = try? NSRegularExpression(pattern: pat)

        return regex?.stringByReplacingMatches(in: self, options: [], range: NSRange(0..<self.count), withTemplate: unicode) ?? self
    }

    public func replaceBrTag() -> String {
        return self.replacingOccurrences(of: "</br>", with: "\n").replacingOccurrences(of: "<br>", with: "\n")
    }
}
