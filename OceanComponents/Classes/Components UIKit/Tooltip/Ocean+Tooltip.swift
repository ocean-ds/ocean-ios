//
//  Ocean+Tooltip.swift
//  FSCalendar
//
//  Created by Pedro Azevedo on 06/07/21.
//

import OceanTokens
import UIKit
import SkeletonView

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
                messageLabel.textAlignment = .center
            }
        }

        public var title: String = "" {
            didSet {
                titleLabel.text = title
                titleLabel.isHidden = title.isEmpty
            }
        }
        
        public var indicatorMargin: CGFloat = 20

        private var backgroundRounded = UIView()
        private var triangleView = TriangleView()
        private var targetView = UIView()
        private var presenter = UIView()
        private var position: Position = .bottom
        private var timer: Timer?

        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
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

        private lazy var contentView: UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            return view
        }()

        private lazy var backgroundClearView: UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            return view
        }()

        public convenience init(builder: TooltipBuilder) {
            self.init()
            builder(self)
            setupUI()
        }

        public override func removeFromSuperview() {
            super.removeFromSuperview()
            self.timer?.invalidate()
        }

        private func setupUI() {
            translatesAutoresizingMaskIntoConstraints = false

            self.addSubview(backgroundClearView)
            self.addSubview(contentView)
            contentView.addSubview(backgroundRounded)
            contentView.addSubview(contentStack)
            contentView.addSubview(triangleView)

            backgroundRounded.backgroundColor = Ocean.color.colorInterfaceDarkDeep
            backgroundRounded.layer.cornerRadius = 4
            backgroundRounded.clipsToBounds = false
            backgroundRounded.oceanConstraints
                .leadingToLeading(to: contentView)
                .trailingToTrailing(to: contentView)
                .make()

            contentStack.oceanConstraints
                .topToTop(to: backgroundRounded, constant: Ocean.size.borderRadiusTiny)
                .leadingToLeading(to: backgroundRounded, constant: Ocean.size.spacingStackXxs)
                .trailingToTrailing(to: backgroundRounded, constant: -Ocean.size.spacingStackXxs)
                .bottomToBottom(to: backgroundRounded, constant: -Ocean.size.spacingStackXxs)
                .make()

            backgroundClearView.oceanConstraints
                .fill(to: self)
                .make()

            [backgroundClearView, contentView].forEach({ view in
                view.isUserInteractionEnabled = true
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tooltipAction)))
                view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(tooltipAction)))
            })
        }

        public func show(target: UIView, position: Position = .top, presenter: UIView) {
            self.targetView = target
            self.position = position
            self.presenter = presenter
            self.presenter.layoutIfNeeded()
            self.presenter.addSubview(self)

            self.setupTimerToClose()

            switch position {
            case .top:
                contentView.oceanConstraints
                    .bottomToTop(to: target, constant: -indicatorMargin)
                    .make()

                backgroundRounded.oceanConstraints
                    .topToTop(to: contentView)
                    .make()

                triangleView.transform = .identity
                triangleView.rotate(angle: 180)

                triangleView.oceanConstraints
                    .width(constant: Constants.triangleWidth)
                    .height(constant: Constants.triangleHeight)
                    .topToBottom(to: backgroundRounded, constant: -2)
                    .leadingToLeading(to: contentView, constant: 2, priority: .required, type: .greaterThanOrEqualTo)
                    .trailingToTrailing(to: contentView, constant: -2, priority: .required, type: .lessThanOrEqualTo)
                    .centerX(to: target, priority: .defaultLow)
                    .bottomToBottom(to: contentView)
                    .make()
            case .bottom:
                contentView.oceanConstraints
                    .topToBottom(to: target, constant: indicatorMargin)
                    .make()

                backgroundRounded.oceanConstraints
                    .bottomToBottom(to: contentView)
                    .make()

                triangleView.oceanConstraints
                    .width(constant: Constants.triangleWidth)
                    .height(constant: Constants.triangleHeight)
                    .topToTop(to: contentView)
                    .leadingToLeading(to: contentView, constant: 2, priority: .required, type: .greaterThanOrEqualTo)
                    .trailingToTrailing(to: contentView, constant: -2, priority: .required, type: .lessThanOrEqualTo)
                    .centerX(to: target, priority: .defaultLow)
                    .bottomToTop(to: backgroundRounded, constant: 2)
                    .make()
            }

            contentView.oceanConstraints
                .width(constant: UIScreen.main.bounds.width - Ocean.size.spacingInlineLg)
                .centerX(to: self)
                .make()

            if let superview = self.superview {
                self.oceanConstraints
                    .width(constant: UIScreen.main.bounds.width)
                    .height(constant: UIScreen.main.bounds.height)
                    .center(to: superview)
                    .make()
            }

            self.setNeedsLayout()
            self.layoutIfNeeded()
        }

        private func setupTimerToClose() {
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] _ in
                self.removeFromSuperview()
            }
        }

        @objc private func tooltipAction(_ sender: Any) {
            self.removeFromSuperview()
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
