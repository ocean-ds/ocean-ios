//
//  Ocean+AlertBox.swift
//  FSCalendar
//
//  Created by Pedro Azevedo on 24/06/21.
//

import OceanTokens

extension Ocean {
    final public class AlertBox: UIView {

        public typealias AlertBoxBuilder = (AlertBox) -> Void
        public var onTouch: (() -> Void)?
        
        private var iconSize: CGSize = .init(width: 15, height: 15)
        
        public enum Size {
            case medium
            case small
            case large
        }
        
        public var size: Size = .small {
            didSet {
                switch size {
                case .large:
                    iconSize = .init(width: 32, height: 32)
                case .medium:
                    iconSize = .init(width: 24, height: 24)
                case .small:
                    iconSize = .init(width: 15, height: 15)
                }
            }
        }
        
        public var text: String = "" {
            didSet {
                messageLabel.text = text
            }
        }
        
        private lazy var mainContentStack: UIStackView = {
            let contentStack = UIStackView()
            contentStack.axis = .vertical
            contentStack.spacing = 0
            contentStack.distribution = .fill
            contentStack.alignment = .fill
            contentStack.translatesAutoresizingMaskIntoConstraints = false

            contentStack.addArrangedSubview(Spacer(space: Ocean.size.borderRadiusLg))
            contentStack.addArrangedSubview(horizontalContentStack)
            contentStack.addArrangedSubview(Spacer(space: Ocean.size.borderRadiusLg))
            
            return contentStack
        }()
        
        private lazy var horizontalContentStack: UIStackView = {
            let contentStack = UIStackView()
            contentStack.axis = .horizontal
            contentStack.spacing = 18.5
            contentStack.distribution = .fill
            contentStack.alignment = .center

            contentStack.addArrangedSubview(iconImageView)
            contentStack.addArrangedSubview(messageStack)
            
            contentStack.isLayoutMarginsRelativeArrangement = true
            contentStack.layoutMargins = .init(top: 0, left: 18.5, bottom: 0, right: Ocean.size.borderRadiusLg)
            
            return contentStack
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = Ocean.icon.informationCircleOutline?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = Ocean.color.colorBrandPrimaryDown
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: iconSize.height).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: iconSize.width).isActive = true
            return imageView
        }()
        
        private lazy var messageStack: UIStackView = {
            let contentStack = UIStackView()
            contentStack.axis = .vertical
            contentStack.spacing = 0
            contentStack.distribution = .fill
            contentStack.alignment = .fill

            contentStack.addArrangedSubview(messageLabel)
            
            return contentStack
        }()
        
        lazy var messageLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.numberOfLines = 0
                label.font = .baseRegular(size: 12)
                label.textColor = Ocean.color.colorInterfaceDarkDown
            }
        }()

        public convenience init(builder: AlertBoxBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            backgroundColor = Ocean.color.colorInterfaceLightUp
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
        
        @objc private func touchAction(_ sender: Any) {
            onTouch?()
        }
    }
}
