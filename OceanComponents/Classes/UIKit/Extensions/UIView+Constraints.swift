//
//  UIView+Constraints.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 13/02/23.
//

import Foundation

extension UIView {
    public var oceanConstraints: OceanConstraintsDSL {
        return OceanConstraintsDSL(self)
    }
}

public enum OceanConstraintsAnchorType {
    case equalTo
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}

public class OceanConstraintsDSL {
    private let view: UIView
    private var constraints: [NSLayoutConstraint] = []

    public init(_ view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    public func make() {
        NSLayoutConstraint.activate(constraints)
    }

    public func getConstraint() -> NSLayoutConstraint {
        if constraints.count > 0 {
            return constraints[0]
        }

        fatalError("Constraint not exists")
    }

    public func getConstraints() -> [NSLayoutConstraint] {
        return constraints
    }
}

extension OceanConstraintsDSL {
    public func width(constant: CGFloat, priority: UILayoutPriority = .required,
                      type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintConstant(type: type,
                                                  anchorFrom: self.view.widthAnchor,
                                                  constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func height(constant: CGFloat, priority: UILayoutPriority = .required,
                       type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintConstant(type: type,
                                                  anchorFrom: self.view.heightAnchor,
                                                  constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func width(to view: UIView, constant: CGFloat = 0,
                      priority: UILayoutPriority = .required, type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.widthAnchor,
                                            anchorTo: view.widthAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func height(to view: UIView, constant: CGFloat = 0,
                       priority: UILayoutPriority = .required, type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.heightAnchor,
                                            anchorTo: view.heightAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    public func widthToHeight(to view: UIView,
                              priority: UILayoutPriority = .required,
                              type: OceanConstraintsAnchorType = .equalTo,
                              multiplier: CGFloat = 1,
                              constant: CGFloat = 0) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.widthAnchor,
                                            anchorTo: self.view.heightAnchor,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
    
    public func heightToWidth(to view: UIView,
                              priority: UILayoutPriority = .required,
                              type: OceanConstraintsAnchorType = .equalTo,
                              multiplier: CGFloat = 1,
                              constant: CGFloat = 0) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.heightAnchor,
                                            anchorTo: self.view.widthAnchor,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    public func centerX(to view: UIView, constant: CGFloat = 0,
                        priority: UILayoutPriority = .required, type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.centerXAnchor,
                                            anchorTo: view.centerXAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func centerY(to view: UIView, constant: CGFloat = 0,
                        priority: UILayoutPriority = .required, type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.centerYAnchor,
                                            anchorTo: view.centerYAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func center(to view: UIView, constant: CGFloat = 0,
                       priority: UILayoutPriority = .required, type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        return self.centerX(to: view, constant: constant, priority: priority, type: type)
            .centerY(to: view, constant: constant, priority: priority, type: type)
    }
}

extension OceanConstraintsDSL {
    public func topToTop(to view: UIView, constant: CGFloat = 0,
                         priority: UILayoutPriority = .required, safeArea: Bool = false,
                         type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.topAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func topToBottom(to view: UIView, constant: CGFloat = 0,
                            priority: UILayoutPriority = .required, safeArea: Bool = false,
                            type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.topAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func bottomToBottom(to view: UIView, constant: CGFloat = 0,
                               priority: UILayoutPriority = .required, safeArea: Bool = false,
                               type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.bottomAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func bottomToTop(to view: UIView, constant: CGFloat = 0,
                            priority: UILayoutPriority = .required, safeArea: Bool = false,
                            type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.bottomAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    public func leadingToLeading(to view: UIView, constant: CGFloat = 0,
                                 priority: UILayoutPriority = .required, safeArea: Bool = false,
                                 type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.leadingAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func leadingToTrailing(to view: UIView, constant: CGFloat = 0,
                                  priority: UILayoutPriority = .required, safeArea: Bool = false,
                                  type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.leadingAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func trailingToTrailing(to view: UIView, constant: CGFloat = 0,
                                   priority: UILayoutPriority = .required, safeArea: Bool = false,
                                   type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.trailingAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    public func trailingToLeading(to view: UIView, constant: CGFloat = 0,
                                  priority: UILayoutPriority = .required, safeArea: Bool = false,
                                  type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        let constraint = createConstraintTo(type: type,
                                            anchorFrom: self.view.trailingAnchor,
                                            anchorTo: safeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor,
                                            constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    public func fill(to view: UIView, constant: CGFloat = 0,
                     priority: UILayoutPriority = .required, safeArea: Bool = false,
                     type: OceanConstraintsAnchorType = .equalTo) -> OceanConstraintsDSL {
        return self.topToTop(to: view, constant: constant, priority: priority, safeArea: safeArea, type: type)
            .leadingToLeading(to: view, constant: constant, priority: priority, safeArea: safeArea, type: type)
            .trailingToTrailing(to: view, constant: -constant, priority: priority, safeArea: safeArea, type: type)
            .bottomToBottom(to: view, constant: -constant, priority: priority, safeArea: safeArea, type: type)
    }
}

extension OceanConstraintsDSL {
    private func createConstraintTo(type: OceanConstraintsAnchorType,
                                    anchorFrom: NSLayoutDimension,
                                    anchorTo: NSLayoutDimension,
                                    multiplier: CGFloat = 1,
                                    constant: CGFloat = 0) -> NSLayoutConstraint {
        switch type {
        case .equalTo:
            return anchorFrom.constraint(equalTo: anchorTo, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqualTo:
            return anchorFrom.constraint(greaterThanOrEqualTo: anchorTo, multiplier: multiplier, constant: constant)
        case .lessThanOrEqualTo:
            return anchorFrom.constraint(lessThanOrEqualTo: anchorTo, multiplier: multiplier, constant: constant)
        }
    }

    private func createConstraintTo(type: OceanConstraintsAnchorType,
                                    anchorFrom: NSLayoutYAxisAnchor,
                                    anchorTo: NSLayoutYAxisAnchor,
                                    multiplier: CGFloat = 1,
                                    constant: CGFloat = 0) -> NSLayoutConstraint {
        switch type {
        case .equalTo:
            return anchorFrom.constraint(equalTo: anchorTo, constant: constant)
        case .greaterThanOrEqualTo:
            return anchorFrom.constraint(greaterThanOrEqualTo: anchorTo, constant: constant)
        case .lessThanOrEqualTo:
            return anchorFrom.constraint(lessThanOrEqualTo: anchorTo, constant: constant)
        }
    }

    private func createConstraintTo(type: OceanConstraintsAnchorType,
                                    anchorFrom: NSLayoutXAxisAnchor,
                                    anchorTo: NSLayoutXAxisAnchor,
                                    multiplier: CGFloat = 1,
                                    constant: CGFloat = 0) -> NSLayoutConstraint {
        switch type {
        case .equalTo:
            return anchorFrom.constraint(equalTo: anchorTo, constant: constant)
        case .greaterThanOrEqualTo:
            return anchorFrom.constraint(greaterThanOrEqualTo: anchorTo, constant: constant)
        case .lessThanOrEqualTo:
            return anchorFrom.constraint(lessThanOrEqualTo: anchorTo, constant: constant)
        }
    }

    private func createConstraintConstant(type: OceanConstraintsAnchorType,
                                          anchorFrom: NSLayoutDimension,
                                          multiplier: CGFloat = 1,
                                          constant: CGFloat = 0) -> NSLayoutConstraint {
        switch type {
        case .equalTo:
            return anchorFrom.constraint(equalToConstant: constant)
        case .greaterThanOrEqualTo:
            return anchorFrom.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqualTo:
            return anchorFrom.constraint(lessThanOrEqualToConstant: constant)
        }
    }
}
