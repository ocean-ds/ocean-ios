//
//  UIVIew+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import UIKit

extension UIView {
    var hasTopNotch: Bool {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
    }

    public func add(view: UIView, selfAutoresizingConstraints: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = selfAutoresizingConstraints
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    public func addTapGesture(target: Any? = nil, selector: Selector) {
        let tap = UITapGestureRecognizer(target: target == nil ? self : target, action: selector)
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    public func addLongPressGesture(target: Any? = nil, selector: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target == nil ? self : target, action: selector)
        longPress.minimumPressDuration = 0.2
        self.addGestureRecognizer(longPress)
        self.isUserInteractionEnabled = true
    }

    public func addMargins(allMargins: CGFloat) -> UIView {
        return addMargins(top: allMargins, left: allMargins, bottom: allMargins, right: allMargins)
    }

    public func addMargins(horizontal: CGFloat) -> UIView {
        return addMargins(left: horizontal, right: horizontal)
    }

    public func addMargins(vertical: CGFloat) -> UIView {
        return addMargins(top: vertical, bottom: vertical)
    }

    public func addMargins(top: CGFloat = 0,
                           left: CGFloat = 0,
                           bottom: CGFloat = 0,
                           right: CGFloat = 0) -> UIView {
        let newView = UIView()
        translatesAutoresizingMaskIntoConstraints = false
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.addSubview(self)
        newView.isSkeletonable = true

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: newView.topAnchor, constant: top),
            self.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: left),
            self.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -right),
            self.bottomAnchor.constraint(equalTo: newView.bottomAnchor, constant: -bottom)
        ])

        return newView
    }

    public func alignCenter(height: CGFloat? = nil) -> UIView {
        let newView = UIView()
        newView.addSubview(self)

        self.setConstraints(([.centerVertically,
                              .centerHorizontally], toView: newView))
        if let height = height {
            newView.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            newView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        }

        return newView
    }

    public func alignLeft(height: CGFloat? = nil) -> UIView {
        let newView = UIView()
        newView.addSubview(self)

        self.setConstraints(([.topToTop(0),
                              .leadingToLeading(0),
                              .bottomToBottom(0)], toView: newView))

        if let height = height {
            newView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        return newView
    }

    public func alignRight(height: CGFloat? = nil) -> UIView {
        let newView = UIView()
        newView.addSubview(self)

        self.setConstraints(([.topToTop(0),
                              .trailingToTrailing(0),
                              .bottomToBottom(0)], toView: newView))

        if let height = height {
            newView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        return newView
    }
}
