//
//  Ocean+TransectionFooterListItem.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 26/07/22.
//

import UIKit
import OceanTokens

extension Ocean {
    public class TransactionFooterItemView: UIView {

        public var title: String = ""{
            didSet {
                updateUI()
            }
        }

        public var tooltipMessage: String = ""{
            didSet {
                updateUI()
            }
        }

        public var tooltipIcon: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var subtitleTextLabel: TextLabelModel? {
            didSet {
                updateUI()
            }
        }

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 1
            }
        }()

        private lazy var textLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 1
            }
        }()

        private lazy var subtitleLabel: TextLabel = {
            let label = TextLabel()
            label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.numberOfLines = 1

            return label
        }()

        var tooltipImageView: UIImageView = {
            UIImageView { imageView in
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.image = Ocean.icon.informationCircleSolid
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.isHidden = true
                imageView.addTapGesture(target: self, selector: #selector(tooltipClick))
            }
        }()

        var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { component in
                component.message = ""
            }
        }()

        lazy var titleView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            view.addSubviews(titleLabel, tooltipImageView)

            tooltipImageView.setConstraints(([.leadingToTrailing(Ocean.size.spacingStackXxxs),
                                              .centerVertically], toView: self.titleLabel))
            titleLabel.setConstraints(([.topToTop(.zero), .leadingToLeading(.zero)], toView: view))

            return view
        }()

        lazy var valueStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = Ocean.size.spacingStackXxxs
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                subtitleLabel
            ])

            return stack
        }()

        lazy var itemStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = 0
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                titleView,
                valueStack
            ])

            return stack
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            add(view: itemStack)
        }

        @objc private func tooltipClick() {
            tooltip.show(target: tooltipImageView, position: .top, presenter: self.superview?.superview ?? self)
        }

        func updateUI() {
            titleLabel.text = title
            subtitleLabel.model = subtitleTextLabel
            if let tooltipIcon = tooltipIcon {
                tooltipImageView.image = tooltipIcon
                tooltipImageView.isHidden = false
            } else {
                tooltipImageView.isHidden = true
            }

        }
    }


}
