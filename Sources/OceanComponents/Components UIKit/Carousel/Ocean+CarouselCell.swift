//
//  Ocean+CarouselCell.swift
//  OceanComponents
//
//  Created by Vini on 20/08/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class CarouselCell: UICollectionViewCell {
        struct Constants {
            static let minWidth: CGFloat = 328
        }

        static let cellId = "CarouselCell"

        public var image: UIImage? {
            didSet {
                imageView.image = image
            }
        }

        public var imageUrl: String = "" {
            didSet {
                imageView.downloadImage(url: imageUrl)
            }
        }

        private lazy var imageView: UIImageView = {
            UIImageView { imageView in
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = UIScreen.main.bounds.width < Constants.minWidth ? .scaleAspectFit : .scaleAspectFill
            }
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupUI() {
            self.backgroundColor = .clear
            self.clipsToBounds = true
            self.ocean.radius.applyMd()

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)
            contentView.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
