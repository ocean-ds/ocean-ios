//
//  Ocean+OrderedListItem.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 06/12/22.
//

import UIKit
import OceanTokens

extension Ocean {
    public class OrderedListItem: UIView {
        public typealias OrderedListItemBuilder = ((OrderedListItem) -> Void)?

        struct Constants {
            static let roundedViewHeightWidthLg: CGFloat = 24
        }

        public var title: String = "" {
            didSet {
                updateUI()
            }
        }

        public var number: Int = 1 {
            didSet {
                updateUI()
            }
        }

        public var roundedBackgroundColor: UIColor = Ocean.color.colorInterfaceLightUp {
            didSet {
                updateUI()
            }
        }

        public lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .top
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    roundedNumberView,
                    titleLabel
                ])
            }
        }()

        public lazy var titleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
            }
        }()

        public lazy var roundedNumberView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidthLg / 2
            view.addSubview(numberLabel)

            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidthLg),
                view.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidthLg),
                numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

            return view
        }()

        public lazy var numberLabel: UILabel = {
            let label = UILabel()
            label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
            label.textColor = Ocean.color.colorBrandPrimaryDown
            label.text = number.description
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        public convenience init(builder: OrderedListItemBuilder = nil) {
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
            add(view: contentStack)
        }

        private func updateUI() {
            titleLabel.text = title
            numberLabel.text = number.description
            roundedNumberView.backgroundColor = roundedBackgroundColor
        }
    }
}
