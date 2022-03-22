//
//  Ocean+ParentChildTextListParentCell.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/03/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class ParentChildTextListParentCell: UIView {
        public typealias ParentChildTextListParentCellBuilder = ((ParentChildTextListParentCell) -> Void)?

        struct Constants {
            static let height: CGFloat = 72
            static let roundedViewHeightWidth: CGFloat = 40
        }

        public var title: String = "" {
            didSet {
                updateUI()
            }
        }

        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var arrowTransform: CGAffineTransform = CGAffineTransform(rotationAngle: 0) {
            didSet {
                arrowImageView.transform = arrowTransform
            }
        }

        public var onTouch: (() -> Void)?

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    contentStack
                ])

                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                            left: 0,
                                            bottom: Ocean.size.spacingStackXs,
                                            right: 0)
            }
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    roundedIconView,
                    roundedIconViewSpacer,
                    infoStack,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    arrowImageView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()

        private lazy var roundedIconViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)

        private lazy var roundedIconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidth / 2
            view.backgroundColor = Ocean.color.colorInterfaceLightUp
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
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            return view
        }()

        private lazy var arrowImageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.image = Ocean.icon.chevronDownSolid
            view.contentMode = .scaleAspectFit
            return view
        }()

        private lazy var infoStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    titleLabel,
                    subtitleLabel
                ])
            }
        }()

        private lazy var button: UIButton = {
            UIButton(frame: .zero)
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.numberOfLines = 1
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorBrandPrimaryDown
                label.numberOfLines = 1
            }
        }()

        public convenience init(builder: ParentChildTextListParentCellBuilder = nil) {
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
            self.add(view: mainStack)
            self.setConstraints((.height(Constants.height), toView: nil))

            self.addTapGesture(selector: #selector(viewTapped))
        }

        private func updateUI() {
            let imageNotExist = image == nil

            titleLabel.text = title
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.text = subtitle
            iconView.image = image?.withRenderingMode(.alwaysTemplate)
            roundedIconViewSpacer.isHidden = imageNotExist
            roundedIconView.isHidden = imageNotExist
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.roundedIconView.isSkeletonable = true
            self.iconView.isSkeletonable = true
            self.infoStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.subtitleLabel.isSkeletonable = true
        }

        @objc func viewTapped() {
            onTouch?()
        }
    }
}
