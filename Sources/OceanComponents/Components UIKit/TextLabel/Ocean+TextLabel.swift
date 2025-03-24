//
//  Ocean+TextLabel.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 21/07/22.
//

import OceanTokens
import UIKit

extension Ocean {
    public class TextLabel: UIView {
        public var model: TextLabelModel? {
            didSet {
                updateUI()
            }
        }

        public var text: String? {
            didSet {
                updateUI()
            }
        }

        public var font: UIFont? = .baseRegular(size: Ocean.font.fontSizeXs) {
            didSet {
                updateUI()
            }
        }

        public var boldSize: CGFloat = Ocean.font.fontSizeSm {
            didSet {
                updateUI()
            }
        }

        public var textColor: UIColor = Ocean.color.colorInterfaceDarkDown {
            didSet {
                updateUI()
            }
        }

        public var numberOfLines: Int = 1 {
            didSet {
                updateUI()
            }
        }

        lazy var iconImageView: UIImageView = {
            UIImageView { imageView in
                imageView.tintColor = self.textColor
                imageView.contentMode = .scaleAspectFit
                imageView.isHidden = true
            }
        }()

        lazy var valueLabel: UILabel = {
            UILabel { label in
                label.font = self.font
                label.textColor = self.textColor
                label.text = ""
            }
        }()

        lazy var newValueLabel: UILabel = {
           UILabel { label in
                label.font = self.font
                label.textColor = self.textColor
                label.text = ""
                label.isHidden = true
            }
        }()

        lazy var valueStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.spacing = Ocean.size.spacingInsetXxs
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center

            stack.add([
                iconImageView,
                valueLabel,
                newValueLabel
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
            add(view: valueStack)
        }

        private func updateUI() {
            reset()
            self.valueLabel.text = self.text

            if let model = model {
                self.valueLabel.text = model.value

                if model.bold {
                    self.valueLabel.font = .baseBold(size: self.boldSize)
                    self.valueLabel.textColor = Ocean.color.colorInterfaceDarkPure
                }

                if let newValue = model.newValue, !newValue.isEmpty {
                    self.valueLabel.attributedText = model.value.toStrike()
                    self.newValueLabel.text = newValue
                    self.newValueLabel.font = self.font
                    self.newValueLabel.numberOfLines = self.numberOfLines
                    self.newValueLabel.isHidden = false
                    setTextColor(model, self.newValueLabel)
                } else {
                    setTextColor(model, self.valueLabel)
                }
                setImage(model)
            }
        }

        fileprivate func setImage(_ model: Ocean.TextLabelModel) {
            if let icon = model.imageIcon {
                self.iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
                setImageColor(model)
                self.iconImageView.isHidden = false
            }
        }

        fileprivate func setTextColor(_ model: Ocean.TextLabelModel, _ label: UILabel) {
            if let color = model.color {
                label.textColor = color
            }
        }

        fileprivate func setImageColor(_ model: Ocean.TextLabelModel) {
            if let color = model.color {
                self.iconImageView.tintColor = color
            }
        }

        fileprivate func reset() {
            self.valueLabel.font = self.font
            self.valueLabel.textColor = self.textColor
            self.valueLabel.numberOfLines = self.numberOfLines
            self.valueLabel.attributedText = nil
            self.valueLabel.text = ""

            self.iconImageView.tintColor = self.textColor
            self.iconImageView.contentMode = .scaleAspectFit
            self.iconImageView.isHidden = true

            self.newValueLabel.font = self.font
            self.newValueLabel.textColor = self.textColor
            self.newValueLabel.text = ""
            self.newValueLabel.isHidden = true
        }
    }
}
