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
}
