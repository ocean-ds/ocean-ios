//
//  Ocean+TransectionFooterListItem.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 26/07/22.
//

import OceanTokens

extension Ocean {
    public class TransactionFooterItemView: UIView {
        public var title: String = "" {
            didSet {
                updateUI()
            }
        }

        public var tooltipMessage: String = "" {
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
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
            }
        }()

        private lazy var subtitleLabel: TextLabel = {
            let label = TextLabel()
            label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            label.boldSize = Ocean.font.fontSizeXs
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.numberOfLines = 1

            return label
        }()

        private lazy var tooltipImageView: UIImageView = {
            UIImageView { imageView in
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.isHidden = true
                imageView.addTapGesture(target: self, selector: #selector(tooltipClick))
            }
        }()

        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { component in
                component.message = ""
            }
        }()

        private lazy var titleView: UIView = {
            let view = UIView()
            view.addSubviews(titleLabel, tooltipImageView)

            tooltipImageView.setConstraints(([.leadingToTrailing(Ocean.size.spacingStackXxxs),
                                              .centerVertically], toView: self.titleLabel))
            titleLabel.setConstraints(([.topToTop(.zero), .leadingToLeading(.zero)], toView: view))

            return view
        }()

        private lazy var itemStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = 0
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill

            stack.add([
                titleView,
                subtitleLabel
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
            itemStack.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 0).isActive = true
        }

        @objc private func tooltipClick() {
            tooltip.show(target: tooltipImageView, position: .top, presenter: self)
        }

        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.model = subtitleTextLabel
            tooltipImageView.isHidden = tooltipMessage.isEmpty
            tooltip.message = tooltipMessage
        }
    }
}
