//
//  UIView+Bond.swift
//  Blu
//
//  Created by Leticia Fernandes on 19/01/22.
//  Copyright © 2022 Blu. All rights reserved.
//

// swiftlint:disable all
import UIKit

public enum BondType {
    case width(CGFloat)
    case height(CGFloat)
    case squareSize(CGFloat)
    case ratio(CGFloat, CGFloat)

    case fillSuperView
    case fullHeight
    case fullWidth

    case marginEqual(CGFloat)
    case verticalMargin(CGFloat)
    case horizontalMargin(CGFloat)

    case sameCenter
    case centerHorizontally
    case centerVertically

    case bondToTop
    case bondToBottom
    case bondToLeading
    case bondToTrailing
    case bondHorizontally

    case topToTop(CGFloat)
    case topToBottom(CGFloat)

    case topToTopGreaterOrEqual(CGFloat)

    case bottomToTop(CGFloat)
    case bottomToBottom(CGFloat)

    case bottomToTopGreaterOrEqual(CGFloat)
    case bottomToBottomGreaterOrEqual(CGFloat)

    case leadingToLeading(CGFloat)
    
    case trailingToTrailing(CGFloat)
    case trailingToTrailingGreaterOrEqual(CGFloat)

    case leadingToTrailing(CGFloat)
    case trailingToLeading(CGFloat)

    case trailingToLeadingGreaterOrEqual(CGFloat)
}

extension UIView {
    public func addSubviews(_ viewsToAdd: UIView...) {
        viewsToAdd.forEach { self.addSubview($0) }
    }

    public func removeSubviews() {
        self.subviews.forEach{ $0.removeFromSuperview() }
    }

    public func setConstraints(_ singleConstraintToView: (BondType, toView: UIView?)...) {
        singleConstraintToView.forEach { (type, toView) in
            self.setBond(type: type, toView: toView)
        }
    }

    public func setConstraints(_ constraintsToView: ([BondType], toView: UIView?)...) {
        constraintsToView.forEach { (types, toView) in
            types.forEach {
                self.setBond(type: $0, toView: toView)
            }
        }
    }

    private func setBond(type: BondType) {
        self.translatesAutoresizingMaskIntoConstraints = false

        switch type {
        case .width(let value):
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
        case .height(let value):
            self.heightAnchor.constraint(equalToConstant: value).isActive = true
        case .squareSize(let value):
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
            self.heightAnchor.constraint(equalToConstant: value).isActive = true
        default: break
        }
    }

    private func setBond(type: BondType, toView: UIView?) {
        guard let toView = toView else {
            self.setBond(type: type)
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false

        switch type {
        case .width(_), .height(_), .squareSize(_):
            self.setBond(type: type)
        case .ratio(let width, let height):
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: width / height, constant: 0))

        case .fillSuperView:
            self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
        case .fullHeight:
            self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        case .fullWidth:
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true

        case .marginEqual(let margin):
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: margin).isActive = true
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -margin).isActive = true
            self.topAnchor.constraint(equalTo: toView.topAnchor, constant: margin).isActive = true
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -margin).isActive = true
        case .verticalMargin(let margin):
            self.topAnchor.constraint(equalTo: toView.topAnchor, constant: margin).isActive = true
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -margin).isActive = true
        case .horizontalMargin(let margin):
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: margin).isActive = true
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -margin).isActive = true

        case .sameCenter:
            self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
        case .centerHorizontally:
            self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
        case .centerVertically:
            self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true

        case .bondToTop:
            self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
        case .bondToBottom:
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        case .bondToLeading:
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
        case .bondToTrailing:
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
        case .bondHorizontally:
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true

        case .topToTop(let margin):
            self.topAnchor.constraint(equalTo: toView.topAnchor, constant: margin).isActive = true
        case .topToBottom(let margin):
            self.topAnchor.constraint(equalTo: toView.bottomAnchor, constant: margin).isActive = true

        case .topToTopGreaterOrEqual(let margin):
            let constraint = self.topAnchor.constraint(greaterThanOrEqualTo: toView.topAnchor, constant: margin)
            constraint.priority = .defaultLow
            constraint.isActive = true

        case .bottomToTop(let margin):
            self.bottomAnchor.constraint(equalTo: toView.topAnchor, constant: -margin).isActive = true
        case .bottomToBottom(let margin):
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -margin).isActive = true

        case .bottomToTopGreaterOrEqual(let margin):
            let constraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: toView.topAnchor, constant: margin)
            constraint.priority = .defaultLow
            constraint.isActive = true
        case .bottomToBottomGreaterOrEqual(let margin):
            let constraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: toView.bottomAnchor, constant: margin)
            constraint.priority = .defaultLow
            constraint.isActive = true

        case .leadingToLeading(let margin):
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: margin).isActive = true

        case .trailingToTrailing(let margin):
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -margin).isActive = true

        case .trailingToTrailingGreaterOrEqual(let margin):
            let constraint = self.trailingAnchor.constraint(greaterThanOrEqualTo: toView.trailingAnchor, constant: margin)
            //constraint.priority = .defaultLow
            constraint.isActive = true

        case .leadingToTrailing(let margin):
            self.leadingAnchor.constraint(equalTo: toView.trailingAnchor, constant: margin).isActive = true
        case .trailingToLeading(let margin):
            self.trailingAnchor.constraint(equalTo: toView.leadingAnchor, constant: -margin).isActive = true

        case .trailingToLeadingGreaterOrEqual(let margin):
            let constraint = self.trailingAnchor.constraint(greaterThanOrEqualTo: toView.leadingAnchor, constant: margin)
            constraint.priority = .defaultHigh
            constraint.isActive = true
        }
    }
}

extension UIView {
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }

    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }

    public var safeLeftAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.leftAnchor
    }

    public var safeRightAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.rightAnchor
    }
}
