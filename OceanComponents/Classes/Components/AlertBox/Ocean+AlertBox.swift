//
//  Ocean+AlertBox.swift
//  FSCalendar
//
//  Created by Pedro Azevedo on 24/06/21.
//

import OceanTokens

extension Ocean {
    final public class AlertBox: UIView {
        public enum IconType {
            case info
            case error
            case warning
            case success
        }
        
        public var onTouch: (() -> Void)?
        
        public var iconType: IconType? {
            didSet {
                if (self.iconType == .info) {
                    backgroundColor = Ocean.color.colorInterfaceLightUp
                    iconImageView.tintColor = Ocean.color.colorBrandPrimaryDown
                    titleLabel.textColor = Ocean.color.colorBrandPrimaryDown
                    image = Ocean.icon.informationCircleOutline?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .warning) {
                    backgroundColor = Ocean.color.colorStatusNeutralUp
                    iconImageView.tintColor = Ocean.color.colorStatusNeutralDeep
                    titleLabel.textColor = Ocean.color.colorStatusNeutralDeep
                    image = Ocean.icon.exclamationCircleOutline?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .error) {
                    backgroundColor = Ocean.color.colorStatusNegativeUp
                    iconImageView.tintColor = Ocean.color.colorStatusNegativePure
                    titleLabel.textColor = Ocean.color.colorStatusNegativePure
                    image = Ocean.icon.banOutline?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .success) {
                    backgroundColor = Ocean.color.colorStatusPositiveUp
                    iconImageView.tintColor = Ocean.color.colorStatusPositiveDeep
                    titleLabel.textColor = Ocean.color.colorStatusPositiveDeep
                    image = Ocean.icon.checkCircleOutline?.withRenderingMode(.alwaysTemplate)
                }
            }
        }
        
        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }
        
        public var title: String = ""{
            didSet {
                updateUI()
            }
        }
        
        public var text: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var textAttributedString: NSAttributedString? {
            didSet {
                updateUI()
            }
        }
        
        private lazy var mainContentStack: UIStackView = {
            let contentStack = UIStackView()
            contentStack.axis = .horizontal
            contentStack.spacing = Ocean.size.spacingStackXxs
            contentStack.distribution = .fill
            contentStack.alignment = .center
            contentStack.translatesAutoresizingMaskIntoConstraints = false

            contentStack.addArrangedSubview(iconImageView)
            contentStack.addArrangedSubview(messageStack)
            
            contentStack.isLayoutMarginsRelativeArrangement = true
            contentStack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                               left: Ocean.size.spacingStackXs,
                                               bottom: Ocean.size.spacingStackXs,
                                               right: Ocean.size.spacingStackXs)
            
            return contentStack
        }()
        
        private lazy var messageStack: UIStackView = {
            let contentStack = UIStackView()
            contentStack.axis = .vertical
            contentStack.spacing = Ocean.size.spacingStackXxxs
            contentStack.distribution = .fillProportionally
            contentStack.alignment = .fill
            contentStack.translatesAutoresizingMaskIntoConstraints = false

            contentStack.addArrangedSubview(titleLabel)
            contentStack.addArrangedSubview(messageLabel)
            
            return contentStack
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            return imageView
        }()
        
        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: 14)
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var messageLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        public convenience init(builder: AlertBoxBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            layer.cornerRadius = 4
            clipsToBounds = true
            addSubview(mainContentStack)
        
            NSLayoutConstraint.activate([
                mainContentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                mainContentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                mainContentStack.topAnchor.constraint(equalTo: topAnchor),
                mainContentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchAction(_:))))
        }
        
        private func updateUI() {
            iconImageView.image = image
            titleLabel.text = title
            titleLabel.isHidden = title.isEmpty
            messageLabel.text = text
            if let textAttributedString = self.textAttributedString {
                messageLabel.attributedText = textAttributedString
            }
            
            mainContentStack.spacing = title.isEmpty ? Ocean.size.spacingStackXxs : Ocean.size.spacingStackXs
        }
        
        @objc private func touchAction(_ sender: Any) {
            onTouch?()
        }
    }
}
