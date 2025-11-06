//
//  Ocean+BaseModalViewController.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 22/06/22.
//

import UIKit
import SPStorkController
import OceanTokens

extension Ocean {
    open class BaseModalViewController: UIViewController {

        var onDismiss: ((Bool) -> Void)?
        var wasClosed: Bool = true

        public lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.distribution = .fill
                stack.axis = .vertical
            }
        }()

        private lazy var closeImageView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.xSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.contentMode = .scaleAspectFit
                imageView.addTapGesture(target: self, selector: #selector(closeTap))
                imageView.accessibilityIdentifier = "closeButton"

                imageView.oceanConstraints
                    .width(constant: 20)
                    .height(constant: 20)
                    .make()
            }
        }()

        public lazy var closeView: UIView = {
            let view = UIView()
            view.addSubview(closeImageView)

            closeImageView.oceanConstraints
                .centerY(to: view)
                .trailingToTrailing(to: view)
                .make()

            view.oceanConstraints
                .height(constant: closeViewHeightSpacing)
                .make()

            return view
        }()

        public lazy var spTransitionDelegate: SPStorkTransitioningDelegate = {
            let delegate = SPStorkTransitioningDelegate()
            delegate.showIndicator = false
            delegate.cornerRadius = 24
            self.transitioningDelegate = delegate
            self.modalPresentationStyle = .custom
            self.modalPresentationCapturesStatusBarAppearance = true
            return delegate
        }()

        public var closeViewHeightSpacing: CGFloat {
            get {
                return 40
            }
        }

        public var heightSpacing: CGFloat {
            get {
                return hasTopNotch ? 65 : 45
            }
        }

        private var rootViewController: UIViewController

        public var swipeDismiss: Bool = true {
            didSet {
                spTransitionDelegate.swipeToDismissEnabled = swipeDismiss
                spTransitionDelegate.tapAroundToDismissEnabled = swipeDismiss
            }
        }

        public init(_ rootViewController: UIViewController) {
            self.rootViewController = rootViewController
            super.init(nibName: nil, bundle: nil)
        }

        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        open func makeView() {
            fatalError()
        }

        public func show() {
            DispatchQueue.main.async { [weak rootViewController] in
                guard let rootViewController = rootViewController else { return }

                if let presentedViewController = rootViewController.presentedViewController {
                    presentedViewController.dismiss(animated: true) {
                        rootViewController.present(self, animated: true, completion: nil)
                    }
                } else {
                    rootViewController.present(self, animated: true, completion: nil)
                }
            }
        }

        open override func viewDidLoad() {
            self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.view.addSubview(mainStack)
        }

        open override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onDismiss?(wasClosed)
        }

        func dismiss(animated flag: Bool, wasClosed: Bool, completion: (() -> Void)? = nil) {
            self.wasClosed = wasClosed
            super.dismiss(animated: flag, completion: completion)
        }

        @objc func closeTap() {
            self.dismiss(animated: true)
        }
    }
}
