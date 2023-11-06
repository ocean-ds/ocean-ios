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

    public func addSubviews(_ viewsToAdd: UIView...) {
        viewsToAdd.forEach { self.addSubview($0) }
    }

    public func removeSubviews() {
        self.subviews.forEach{ $0.removeFromSuperview() }
    }

    public func add(view: UIView, selfAutoresizingConstraints: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = selfAutoresizingConstraints
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)

        view.oceanConstraints
            .topToTop(to: self, safeArea: true)
            .leadingToLeading(to: self)
            .trailingToTrailing(to: self)
            .bottomToBottom(to: self, safeArea: true)
            .make()
    }

    public func addMargins(allMargins: CGFloat, 
                           isSkeletonable: Bool = true) -> UIView {
        return addMargins(top: allMargins, left: allMargins,
                          bottom: allMargins, right: allMargins,
                          isSkeletonable: isSkeletonable)
    }

    public func addMargins(horizontal: CGFloat,
                           isSkeletonable: Bool = true) -> UIView {
        return addMargins(left: horizontal, right: horizontal,
                          isSkeletonable: isSkeletonable)
    }

    public func addMargins(vertical: CGFloat,
                           isSkeletonable: Bool = true) -> UIView {
        return addMargins(top: vertical, bottom: vertical,
                          isSkeletonable: isSkeletonable)
    }

    public func addMargins(top: CGFloat = 0,
                           left: CGFloat = 0,
                           bottom: CGFloat = 0,
                           right: CGFloat = 0,
                           isSkeletonable: Bool = true) -> UIView {
        let newView = createNewView(isSkeletonable: isSkeletonable)

        self.oceanConstraints
            .topToTop(to: newView, constant: top)
            .leadingToLeading(to: newView, constant: left)
            .trailingToTrailing(to: newView, constant: -right)
            .bottomToBottom(to: newView, constant: -bottom)
            .make()

        return newView
    }

    public func alignCenter(height: CGFloat? = nil, isSkeletonable: Bool = true) -> UIView {
        let newView = createNewView(isSkeletonable: isSkeletonable)

        self.oceanConstraints
            .center(to: newView)
            .make()

        setHeightNewView(newView, height: height)

        return newView
    }

    public func alignLeft(height: CGFloat? = nil, isSkeletonable: Bool = true) -> UIView {
        let newView = createNewView(isSkeletonable: isSkeletonable)

        self.oceanConstraints
            .topToTop(to: newView)
            .leadingToLeading(to: newView)
            .bottomToBottom(to: newView)
            .make()

        setHeightNewView(newView, height: height)

        return newView
    }

    public func alignRight(height: CGFloat? = nil, isSkeletonable: Bool = true) -> UIView {
        let newView = createNewView(isSkeletonable: isSkeletonable)

        self.oceanConstraints
            .topToTop(to: newView)
            .trailingToTrailing(to: newView)
            .bottomToBottom(to: newView)
            .make()

        setHeightNewView(newView, height: height)

        return newView
    }

    private func createNewView(isSkeletonable: Bool = true) -> UIView {
        let newView = UIView()
        translatesAutoresizingMaskIntoConstraints = false
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.addSubview(self)
        newView.isSkeletonable = isSkeletonable
        return newView
    }

    private func setHeightNewView(_ newView: UIView, height: CGFloat?) {
        if let height = height {
            newView.oceanConstraints
                .height(constant: height)
                .make()
        } else {
            newView.oceanConstraints
                .height(to: self)
                .make()
        }
    }
    
    public func getRootSuperview() -> UIView {
        if let superview = superview {
            return superview.getRootSuperview()
        } else {
            return self
        }
    }
}
