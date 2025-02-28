//
//  Ocean+RoundedIcon.swift
//  FSCalendar
//
//  Created by Vinicius Romeiro on 22/03/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class RoundedIcon: UIView {
        public typealias RoundedIconBuilder = ((RoundedIcon) -> Void)?

        struct Constants {
            static let roundedViewHeightWidth: CGFloat = 40
        }

        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var imageTintColor: UIColor = Ocean.color.colorBrandPrimaryDown {
            didSet {
                updateUI()
            }
        }

        public var imageContentMode: UIView.ContentMode = .center {
            didSet {
                updateUI()
            }
        }

        public var roundedBackgroundColor: UIColor? = nil {
            didSet {
                updateUI()
            }
        }

        private lazy var roundedIconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidth / 2
            view.backgroundColor = Ocean.color.colorInterfaceLightUp
            view.isSkeletonable = true
            view.addSubview(iconView)

            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth),
                view.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth),
                iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

            return view
        }()

        private lazy var iconView: UIImageView = {
            let view = UIImageView()
            return view
        }()

        public convenience init(builder: RoundedIconBuilder = nil) {
            self.init()
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            self.add(view: roundedIconView)

            iconView.oceanConstraints
                .width(constant: Ocean.size.spacingStackMd)
                .height(constant: Ocean.size.spacingStackMd)
                .make()

            self.isSkeletonable = true
        }

        private func updateUI() {
            iconView.image = image
            iconView.tintColor = imageTintColor
            iconView.contentMode = imageContentMode
            roundedIconView.backgroundColor = roundedBackgroundColor ?? Ocean.color.colorInterfaceLightUp
        }
    }
}
