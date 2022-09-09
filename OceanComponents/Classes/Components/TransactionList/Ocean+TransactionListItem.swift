//
//  Ocean+TransactionListItem.swift
//  OceanComponents
//
//  Created by Vini on 07/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class TransactionListItem: UIView {
        public typealias TransactionListItemBuilder = (TransactionListItem) -> Void

        public enum ValueStatus {
            case neutral
            case positive
            case negative
        }

        public struct Model {
            public var level1: String = ""
            public var level2: String = ""
            public var level3: String = ""
            public var level4: String = ""
            public var value: Double = 0
            public var valueStatus: ValueStatus = .neutral
            public var date: String = ""
            public var tagTitle: String = ""
            public var tagImage: UIImage? = nil
            public var tagStatus: Tag.Status = .warning
            public var tagImageStatus: Bool = false
            public var withDivider: Bool = true

            public init(level1: String = "",
                        level2: String = "",
                        level3: String = "",
                        level4: String = "",
                        value: Double = 0,
                        valueStatus: ValueStatus = .neutral,
                        date: String = "",
                        tagTitle: String = "",
                        tagImage: UIImage? = nil,
                        tagStatus: Tag.Status = .warning,
                        tagImageStatus: Bool = false,
                        withDivider: Bool = true) {
                self.level1 = level1
                self.level2 = level2
                self.level3 = level3
                self.level4 = level4
                self.value = value
                self.valueStatus = valueStatus
                self.date = date
                self.tagTitle = tagTitle
                self.tagImage = tagImage
                self.tagStatus = tagStatus
                self.tagImageStatus = tagImageStatus
                self.withDivider = withDivider
            }
        }

        public var onTouch: (() -> Void)?
        public var onTouchCheckbox: (() -> Void)?

        public var model: Model? {
            didSet {
                updateUI()
            }
        }

        public var hasCheckbox: Bool = false {
            didSet {
                UIView.animate(withDuration: 0.3) {
                    self.selectCheckBox.isHidden = !self.hasCheckbox
                    self.selectCheckBoxSpacer.isHidden = !self.hasCheckbox
                    self.selectCheckBox.alpha = self.hasCheckbox ? 1 : 0
                }
            }
        }

        public var isSelected: Bool {
            get {
                return selectCheckBox.isSelected
            }
            set {
                selectCheckBox.isSelected = newValue
            }
        }

        private lazy var selectCheckBox: Ocean.CheckBox = {
            Ocean.CheckBox { view in
                view.label = ""
                view.stackAlignment = .center
                view.isHidden = true
                view.alpha = 0
                view.onTouch = {
                    self.onTouchCheckbox?()
                }
            }
        }()

        private lazy var selectCheckBoxSpacer: UIView = {
            let view = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
            view.isHidden = true
            return view
        }()

        private lazy var level1Label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 2
                label.translatesAutoresizingMaskIntoConstraints = false
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            }
        }()

        private lazy var level1Container = level1Label.addMargins()

        private lazy var level1Spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)

        private lazy var level2Label: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            }
        }()

        private lazy var level2Spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)

        private lazy var level3Label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            }
        }()

        private lazy var level4Label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorBrandPrimaryDeep
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var level4Spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)

        private lazy var leftContentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    level4Label,
                    level4Spacer,
                    level1Container,
                    level1Spacer,
                    level2Label,
                    level2Spacer,
                    level3Label
                ])
            }
        }()

        private lazy var rightContentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .trailing
                stack.spacing = Ocean.size.spacingStackXxxs

                stack.add([
                    valueContainer,
                    tagView,
                    dateLabel
                ])
            }
        }()

        private lazy var valueLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textAlignment = .right
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
                label.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
        }()

        private lazy var valueContainer = valueLabel.addMargins()

        private lazy var tagView: Ocean.Tag = {
            Ocean.Tag { view in
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var dateLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textAlignment = .right
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
                label.setContentCompressionResistancePriority(.required, for: .horizontal)
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.8
            }
        }()


        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.spacing = Ocean.size.spacingStackXxxs

                stack.add([
                    selectCheckBox,
                    selectCheckBoxSpacer,
                    leftContentStack,
                    rightContentStack
                ])

                stack.setMargins(allMargins: Ocean.size.spacingStackXs)
            }
        }()

        private lazy var divider = Ocean.Divider(widthConstraint: self.widthAnchor)

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill

                stack.add([
                    contentStack,
                    divider
                ])
            }
        }()

        public convenience init(builder: TransactionListItemBuilder) {
            self.init()
            builder(self)
            setupUI()
        }

        private func setupUI() {
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            add(view: mainStack)

            self.isUserInteractionEnabled = true
            self.addTapGesture(selector: #selector(tapped(sender:)))
            self.addLongPressGesture(selector: #selector(longPressed(sender:)))
        }

        private func updateUI() {
            guard let model = self.model else { return }

            level1Label.text = model.level1
            level1Spacer.isHidden = model.level2.isEmpty
            level2Label.text = model.level2
            level2Label.isHidden = model.level2.isEmpty
            level2Spacer.isHidden = model.level2.isEmpty
            level3Label.text = model.level3
            level3Label.isHidden = model.level3.isEmpty
            level4Label.text = model.level4
            level4Label.isHidden = model.level4.isEmpty
            level4Spacer.isHidden = model.level4.isEmpty
            let valueCurrency = model.value.toCurrency(symbolSpace: true) ?? " R$ 0,00"
            switch model.valueStatus {
            case .positive:
                valueLabel.text = "+" + valueCurrency
                valueLabel.textColor = Ocean.color.colorStatusPositiveDeep
            case .negative:
                valueLabel.text = "-" + valueCurrency
                valueLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            default:
                valueLabel.text = valueCurrency
                valueLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            }
            tagView.status = model.tagStatus
            tagView.image = model.tagImage
            tagView.title = model.tagTitle
            tagView.imageStatus = model.tagImageStatus
            tagView.isHidden = model.tagTitle.isEmpty
            dateLabel.text = model.date
            dateLabel.isHidden = model.date.isEmpty
            divider.isHidden = !model.withDivider
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.leftContentStack.isSkeletonable = true
            self.rightContentStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.mainStack.isSkeletonable = true

            level1Container.isSkeletonable = true
            level2Label.isSkeletonable = true
            level3Label.isSkeletonable = true
            level4Label.isSkeletonable = true
            valueContainer.isSkeletonable = true
            dateLabel.isSkeletonable = true
            dateLabel.isHiddenWhenSkeletonIsActive = true
            tagView.setSkeleton()
        }

        @objc private func tapped(sender: UITapGestureRecognizer) {
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            onTouch?()
        }

        @objc private func longPressed(sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                self.backgroundColor = Ocean.color.colorInterfaceLightDown
            } else if sender.state == .ended {
                self.backgroundColor = Ocean.color.colorInterfaceLightPure
                onTouch?()
            }
        }
    }
}
