//
//  UIVIew+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import UIKit

extension UIView {
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

    var hasTopNotch: Bool {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
    }
}
