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
            backgroundRounded.setConstraints(([.horizontalMargin(.zero)], toView: contentView))

            contentStack.setConstraints(([.horizontalMargin(Ocean.size.spacingStackXxs),
                                          .bottomToBottom(Ocean.size.spacingStackXxs),
                                          .topToTop(Ocean.size.borderRadiusSm)], toView: backgroundRounded))
            backgroundClearView.setConstraints((.fillSuperView, toView: self))

            [backgroundClearView, contentView].forEach({ view in
                view.isUserInteractionEnabled = true
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tooltipAction)))
            })
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
                contentView.setConstraints((.bottomToTop(20), toView: target))
                backgroundRounded.setConstraints((.bondToTop, toView: contentView))
                triangleView.transform = .identity
                triangleView.rotate(angle: 180)
                triangleView.setConstraints(([.topToBottom(-2),
                                              .width(Constants.triangleWidth),
                                              .height(Constants.triangleHeight)
                                            ], toView: backgroundRounded),
                                            ([.bondToBottom], toView: contentView),
                                            ([.bondToLeading], toView: target))
            case .bottom:
                contentView.setConstraints((.topToBottom(20), toView: target))
                backgroundRounded.setConstraints((.bondToBottom, toView: contentView))
                triangleView.setConstraints(([.bottomToTop(-2),
                                              .width(Constants.triangleWidth),
                                              .height(Constants.triangleHeight)
                                            ], toView: backgroundRounded),
                                            ([.bondToTop], toView: contentView),
                                            ([.bondToLeading], toView: target))
            }

            contentView.setConstraints(([.width(UIScreen.main.bounds.width - Ocean.size.spacingInlineLg),
                                         .centerHorizontally], toView: self))

            self.setConstraints(([.width(UIScreen.main.bounds.width),
                                  .height(UIScreen.main.bounds.height),
                                  .sameCenter], toView: self.superview))

            self.setNeedsLayout()
            self.layoutIfNeeded()
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




