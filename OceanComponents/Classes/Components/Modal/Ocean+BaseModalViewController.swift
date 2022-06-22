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
    public class BaseModalViewController: UIViewController {
        internal lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.distribution = .fill
                stack.axis = .vertical
            }
        }()

        internal lazy var closeImageView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.xSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.contentMode = .scaleAspectFit
                imageView.addTapGesture(target: self, selector: #selector(closeTap))
                imageView.setConstraints((.squareSize(20), toView: nil))
            }
        }()

        internal lazy var closeView: UIView = {
            let view = UIView()
            view.addSubview(closeImageView)
            closeImageView.setConstraints(([.centerVertically,
                                            .trailingToTrailing(0)], toView: view))
            view.setConstraints((.height(40), toView: nil))
            return view
        }()

        internal lazy var spTransitionDelegate: SPStorkTransitioningDelegate = {
            let delegate = SPStorkTransitioningDelegate()
            delegate.showIndicator = false
            delegate.cornerRadius = 24
            self.transitioningDelegate = delegate
            self.modalPresentationStyle = .custom
            self.modalPresentationCapturesStatusBarAppearance = true
            return delegate
        }()

        internal var heightSpacing: CGFloat {
            get {
                return hasTopNotch ? 65 : 45
            }
        }

        private var rootViewController: UIViewController

        var swipeDismiss: Bool = true {
            didSet {
                spTransitionDelegate.swipeToDismissEnabled = swipeDismiss
                spTransitionDelegate.tapAroundToDismissEnabled = swipeDismiss
            }
        }

        init(_ rootViewController: UIViewController) {
            self.rootViewController = rootViewController
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func makeView() {
            fatalError()
        }

        public func show() {
            DispatchQueue.main.async {
                if let presentedViewController = self.rootViewController.presentedViewController {
                    presentedViewController.dismiss(animated: true) {
                        self.rootViewController.present(self, animated: true, completion: nil)
                    }
                } else {
                    self.rootViewController.present(self, animated: true, completion: nil)
                }
            }
        }

        public override func viewDidLoad() {
            self.view.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.view.addSubview(mainStack)
        }

        @objc func closeTap() {
            self.dismiss(animated: true)
        }
    }
}
