//
//  Ocean+TextLabel.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 21/07/22.
//

import OceanTokens

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
                imageView.tintColor = Ocean.color.colorStatusPositiveDeep
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
            self.valueLabel.text = self.text
            self.valueLabel.font = self.font
            self.valueLabel.textColor = self.textColor
            self.valueLabel.numberOfLines = self.numberOfLines

            if let model = model {
                self.valueLabel.text = model.value

                if let newValue = model.newValue, !newValue.isEmpty {
                    self.valueLabel.attributedText = model.value.toStrike()
                    self.newValueLabel.text = newValue
                    self.newValueLabel.font = self.font
                    self.newValueLabel.numberOfLines = self.numberOfLines
                    self.newValueLabel.isHidden = false
                    if let setColor = model.colorString, !setColor.isEmpty {
                        self.newValueLabel.textColor = setColor.toOceanColor()
                    }
                } else {
                    if let setColor = model.colorString, !setColor.isEmpty {
                        self.valueLabel.textColor = setColor.toOceanColor()
                    }
                    self.newValueLabel.isHidden = true
                }

                if model.bold {
                    self.valueLabel.font = .baseBold(size: Ocean.font.fontSizeSm)
                    self.valueLabel.textColor = Ocean.color.colorInterfaceDarkPure
                }

                if let icon = model.imageIcon {
                    self.iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
                    self.iconImageView.tintColor = Ocean.color.colorStatusPositiveDeep
                    self.iconImageView.isHidden = false

                }
            }
        }
    }
}

