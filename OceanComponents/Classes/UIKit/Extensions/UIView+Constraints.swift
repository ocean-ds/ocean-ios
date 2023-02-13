//
//  UIView+Constraints.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 13/02/23.
//

import Foundation

extension UIView {
    var oceanConstraints: OceanConstraintsDSL {
        return OceanConstraintsDSL(self)
    }
}

class OceanConstraintsDSL {
    let view: UIView
    var constraints: [NSLayoutConstraint] = []

    init(_ view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func make() {
        NSLayoutConstraint.activate(constraints)
    }
}

extension OceanConstraintsDSL {
    func width(constant: CGFloat, priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        let constraint = self.view.widthAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func height(constant: CGFloat, priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        let constraint = self.view.heightAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func width(to view: UIView, constant: CGFloat = 0,
               priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        let constraint = self.view.widthAnchor.constraint(equalTo: view.widthAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func height(to view: UIView, constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        let constraint = self.view.heightAnchor.constraint(equalTo: view.heightAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    func centerX(to view: UIView, constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        let constraint = self.view.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func centerY(to view: UIView, constant: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        let constraint = self.view.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func center(to view: UIView, constant: CGFloat = 0,
                priority: UILayoutPriority = .required) -> OceanConstraintsDSL {
        return self.centerX(to: view, constant: constant, priority: priority)
            .centerY(to: view, constant: constant, priority: priority)
    }
}

extension OceanConstraintsDSL {
    func topToTop(to view: UIView, constant: CGFloat = 0,
                  priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.topAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.topAnchor :
                                                            view.topAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func topToBottom(to view: UIView, constant: CGFloat = 0,
                     priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.topAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.bottomAnchor :
                                                            view.bottomAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func bottomToBottom(to view: UIView, constant: CGFloat = 0,
                        priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.bottomAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.bottomAnchor :
                                                            view.bottomAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func bottomToTop(to view: UIView, constant: CGFloat = 0,
                     priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.topAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.topAnchor :
                                                            view.topAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    func leadingToLeading(to view: UIView, constant: CGFloat = 0,
                          priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.leadingAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.leadingAnchor :
                                                                view.leadingAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func leadingToTrailing(to view: UIView, constant: CGFloat = 0,
                           priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.leadingAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.trailingAnchor :
                                                                view.trailingAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func trailingToTrailing(to view: UIView, constant: CGFloat = 0,
                            priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.trailingAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.trailingAnchor :
                                                                view.trailingAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }

    func trailingToLeading(to view: UIView, constant: CGFloat = 0,
                           priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        let constraint = self.view.trailingAnchor.constraint(equalTo: safeArea ? view.safeAreaLayoutGuide.leadingAnchor :
                                                                view.leadingAnchor, constant: constant)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
}

extension OceanConstraintsDSL {
    func fill(to view: UIView, constant: CGFloat = 0,
              priority: UILayoutPriority = .required, safeArea: Bool = false) -> OceanConstraintsDSL {
        return self.topToTop(to: view, constant: constant, priority: priority, safeArea: safeArea)
            .leadingToLeading(to: view, constant: constant, priority: priority, safeArea: safeArea)
            .trailingToTrailing(to: view, constant: -constant, priority: priority, safeArea: safeArea)
            .bottomToBottom(to: view, constant: -constant, priority: priority, safeArea: safeArea)
    }
}
