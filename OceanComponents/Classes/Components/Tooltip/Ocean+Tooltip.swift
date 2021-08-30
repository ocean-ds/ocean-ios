//
//  Ocean+Tooltip.swift
//  FSCalendar
//
//  Created by Pedro Azevedo on 06/07/21.
//

import OceanTokens

extension Ocean {
    public final class Tooltip: UIView {
        
        public enum Position {
            case top
            case bottom
        }
        
        struct Constants {
            static let triangleHeight: CGFloat = 12
            static let triangleWidth: CGFloat = 24
        }
        
        public typealias TooltipBuilder = (Tooltip) -> Void
        public var onTouch: (() -> Void)?
        
        public var message: String = "" {
            didSet {
                messageLabel.text = message
                messageLabel.isHidden = message.isEmpty
            }
        }
        
        public var title: String = "" {
            didSet {
                titleLabel.text = title
                titleLabel.isHidden = title.isEmpty
            }
        }
        
        private var backgroundRounded = UIView()
        private var triangleView = TriangleView()
        private var targetView = UIView()
        private var presenter = UIView()
        private var position: Position = .bottom
        
        private lazy var contentStack: UIStackView = {
            let stack = UIStackView()
            stack.distribution = .fill
            stack.alignment = .fill
            stack.axis = .vertical
            stack.spacing = Ocean.size.spacingInsetXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(titleLabel)
            stack.addArrangedSubview(messageLabel)
            return stack
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.text = self.title
                label.numberOfLines = 0
            }
        }()
        
        private lazy var messageLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.text = self.message
                label.numberOfLines = 0
            }
        }()
        
        public convenience init(builder: TooltipBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(backgroundRounded)
            backgroundRounded.backgroundColor = Ocean.color.colorInterfaceDarkDeep
            backgroundRounded.layer.cornerRadius = 4
            backgroundRounded.clipsToBounds = false
            backgroundRounded.translatesAutoresizingMaskIntoConstraints = false
            backgroundRounded.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
            backgroundRounded.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1).isActive = true
            backgroundRounded.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
            backgroundRounded.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
            
            addSubview(contentStack)
            NSLayoutConstraint.activate([
                contentStack.topAnchor.constraint(equalTo: topAnchor, constant: Ocean.size.borderRadiusLg),
                contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Ocean.size.borderRadiusLg),
                contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Ocean.size.borderRadiusLg),
                contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Ocean.size.borderRadiusLg)
            ])
            
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tooltipAction)))
        }

        public func show(target: UIView, position: Position = .top, presenter: UIView) {
            guard let topView = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.view ?? UIApplication.shared.keyWindow?.rootViewController?.view else { return }
            self.targetView = target
            self.position = position
            self.presenter = presenter
            topView.layoutIfNeeded()
            topView.addSubview(self)
            
            switch position {
            case .top:
                self.bottomAnchor.constraint(equalTo: target.topAnchor, constant: -20).isActive = true
                triangleView.transform = .identity
                triangleView.rotate(angle: 180)
            case .bottom:
                self.topAnchor.constraint(equalTo: target.bottomAnchor, constant: 20).isActive = true
            }

            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - Ocean.size.spacingInlineLg),
                self.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
            ])
            
            layoutSubviews()
        }
        
        @objc private func tooltipAction(_ sender: Any) {
            self.removeFromSuperview()
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            self.backgroundRounded.subviews.first?.removeFromSuperview()
            self.backgroundRounded.addSubview(triangleView)
            
            self.targetView.layoutIfNeeded()
            self.backgroundRounded.layoutIfNeeded()
            
            let xPosition = convert(targetView.frame, from: presenter).origin.x - (Constants.triangleWidth - (targetView.frame.width / 2) - (Constants.triangleWidth / 2))
            
            switch position {
            case .top:
                triangleView.frame = .init(x: xPosition, y: backgroundRounded.frame.height, width: Constants.triangleWidth, height: Constants.triangleHeight)
            case .bottom:
                triangleView.frame = .init(x: xPosition, y: -Constants.triangleHeight, width: Constants.triangleWidth, height: Constants.triangleHeight)
            }
        }
    }
}

fileprivate extension UIView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}


