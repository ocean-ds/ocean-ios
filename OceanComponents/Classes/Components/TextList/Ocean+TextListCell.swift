//
//  Ocean+TextListCell.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public enum TextListType {
        case normal
        case inverse
        case inverseHighlight
    }

    public class TextListCell: UIView {
        struct Constants {
            static let roundedViewHeightWidth: CGFloat = 40
        }

        public var isInverse: Bool = false

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

        public var subtitleTextLabel: TextLabelModel? {
            didSet {
                updateUI()
            }
        }
        
        public var textTextLabel: TextLabelModel? {
            didSet {
                updateUI()
            }
        }

        public var text: String = "" {
            didSet {
                updateUI()
            }
        }

        public var tagTitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var tagImage: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var tagImageStatus: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var tagStatus: Tag.Status = .warning {
            didSet {
                updateUI()
            }
        }

        public var roundedBackgroundColor: UIColor? = Ocean.color.colorInterfaceLightUp {
            didSet {
                updateUI()
            }
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

        public var locked: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var arrow: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var arrowIcon: UIImage? = Ocean.icon.chevronRightSolid?.withRenderingMode(.alwaysTemplate) {
            didSet {
                updateUI()
            }
        }

        public var arrowTintColor: UIColor = Ocean.color.colorInterfaceDarkDown {
            didSet {
                updateUI()
            }
        }

        public var swipe: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var badge: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var buttonTitle: String? = nil {
            didSet {
                updateUI()
            }
        }

        public var onTouchButton: (() -> Void)? {
            didSet {
                updateUI()
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
                    arrowImageViewSpacer,
                    arrowImageView,
                    button,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    swipeImageView,
                    swipeImageViewSpacer
                ])
            }
        }()

        private lazy var roundedIconViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)

        private lazy var roundedIconView: Ocean.RoundedIcon = {
            Ocean.RoundedIcon { view in
            }
        }()

        private lazy var arrowImageViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)

        private lazy var arrowImageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
            return view
        }()

        private lazy var swipeImageView: UIImageView = {
            let view = UIImageView()
            view.image = Ocean.icon.swipe
            view.isHidden = true
            return view
        }()

        private lazy var swipeImageViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)

        private lazy var tagHighlightView: Ocean.Tag = {
            Ocean.Tag { tag in
                tag.title = "Novo"
                tag.status = .highlight
            }
        }()

        private lazy var infoStackTitle: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    tagHighlightView
                ])
            }
        }()

        private lazy var subtitleSpacer = Ocean.Spacer(space: Ocean.size.spacingInsetXxs)

        private lazy var infoStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    infoStackTitle,
                    Ocean.Spacer(space: Ocean.size.spacingInsetXxs),
                    subtitleLabel,
                    subtitleSpacer,
                    textLabel,
                    tagSpacer,
                    tagView
                ])
            }
        }()

        private lazy var button: UIButton = {
            UIButton(frame: .zero)
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
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

        private lazy var textLabel: TextLabel = {
            let label = TextLabel()
            label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
            label.boldSize = Ocean.font.fontSizeXxxs
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.numberOfLines = 1
            
            return label
        }()

        private lazy var tagSpacer = Ocean.Spacer(space: Ocean.size.spacingInsetXxs)

        private lazy var tagView: Ocean.Tag = {
            Ocean.Tag { view in
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        public convenience init(type: TextListType = .normal, builder: TextListCellBuilder = nil) {
            self.init()
            if type == .inverse {
                setupInverse()
            } else if type == .inverseHighlight {
                setupInverseHighlight()
            }
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupInverse() {
            self.isInverse = true
            self.titleLabel.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            self.titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            self.subtitleLabel.font = .baseRegular(size: Ocean.font.fontSizeXs)
            self.subtitleLabel.textColor = Ocean.color.colorInterfaceDarkPure
            self.subtitleLabel.numberOfLines = 0
        }

        private func setupInverseHighlight() {
            self.isInverse = true
            self.titleLabel.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            self.titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            self.subtitleLabel.font = .baseBold(size: Ocean.font.fontSizeSm)
            self.subtitleLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            self.subtitleLabel.numberOfLines = 0
        }

        private func setupUI() {
            self.add(view: mainStack)

            self.addTapGesture(selector: #selector(viewTapped))
        }

        private func updateUI() {
            let imageNotExist = image == nil

            titleLabel.text = title
            
            subtitleSpacer.isHidden = subtitleLabel.isHidden
            subtitleLabel.isHidden = subtitle.isEmpty && subtitleTextLabel == nil
            subtitleLabel.isSkeletonable = !subtitle.isEmpty || subtitleTextLabel != nil
            subtitleLabel.text = subtitle
            subtitleLabel.model = subtitleTextLabel
            textLabel.isHidden = text.isEmpty && textTextLabel == nil
            textLabel.isSkeletonable = !text.isEmpty
            textLabel.text = text
            textLabel.model = textTextLabel
            tagView.title = tagTitle
            tagView.image = tagImage
            tagView.status = tagStatus
            tagView.imageStatus = tagImageStatus
            tagView.isHidden = tagTitle.isEmpty
            tagSpacer.isHidden = tagView.isHidden
            if !tagView.isHidden {
                tagView.setSkeleton()
            }
            roundedIconView.image = image
            roundedIconView.imageTintColor = imageTintColor
            roundedIconView.imageContentMode = imageContentMode
            roundedIconView.roundedBackgroundColor = roundedBackgroundColor
            roundedIconViewSpacer.isHidden = imageNotExist
            roundedIconView.isHidden = imageNotExist
            roundedIconView.isSkeletonable = !imageNotExist
            arrowImageViewSpacer.isHidden = !arrow
            arrowImageView.isHidden = !arrow
            arrowImageView.image = arrowIcon
            arrowImageView.tintColor = arrowTintColor
            if locked {
                arrowImageViewSpacer.isHidden = false
                arrowImageView.isHidden = false
                arrowImageView.image = Ocean.icon.lockClosedSolid?.withRenderingMode(.alwaysTemplate)
                arrowImageView.tintColor = Ocean.color.colorInterfaceDarkUp
                roundedIconView.imageTintColor = Ocean.color.colorInterfaceDarkUp
            }
            swipeImageView.isHidden = !swipe
            swipeImageViewSpacer.isHidden = !swipe
            tagHighlightView.isHidden = !badge
            button.isHidden = true

            if let title = buttonTitle {
                setupButton(title: title)
            }

            if isInverse {
                if imageNotExist {
                    mainStack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                                left: 0,
                                                bottom: Ocean.size.spacingStackXxs,
                                                right: 0)
                } else {
                    mainStack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                                left: 0,
                                                bottom: Ocean.size.spacingStackXs,
                                                right: 0)
                }
            }
        }

        private func setupButton(title: String) {
            button.isHidden = false
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            button.titleLabel?.font = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXxs)
            button.setTitleColor(Ocean.color.colorBrandPrimaryPure, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: Ocean.size.spacingInsetXs, left: Ocean.size.spacingInsetSm, bottom: Ocean.size.spacingInsetXs, right: Ocean.size.spacingInsetSm)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.6
        }

        public func setSkeleton(inTitle: Bool = true) {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.infoStack.isSkeletonable = true
            if inTitle {
                self.infoStackTitle.isSkeletonable = true
                self.titleLabel.isSkeletonable = true
            }
        }
        
        @objc func viewTapped() {
            self.onTouch?()
        }

        @objc private func buttonTapped() {
            self.onTouchButton?()
        }
    }
}
