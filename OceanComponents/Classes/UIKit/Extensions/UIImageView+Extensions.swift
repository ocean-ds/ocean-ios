//
//  UIImageView+Extensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 01/09/22.
//

import Foundation
import SDWebImage

extension UIImageView {
    public func downloadImage(url: String, placeHolder: UIImage? = nil) {
        guard !url.isEmpty else { return }
        
        if let url = URL(string: url) {
            self.sd_imageIndicator?.startAnimatingIndicator()
            self.sd_setImage(with: url, placeholderImage: placeHolder) { _, error, _, _ in
                if let error = error {
                    print("Failed to download image - error: \(error)")
                }
                self.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }
    }
}
