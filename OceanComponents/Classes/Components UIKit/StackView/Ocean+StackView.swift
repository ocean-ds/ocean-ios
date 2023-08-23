//
//  Ocean+StackView.swift
//  OceanComponents
//
//  Created by Leticia Fernandes on 03/02/22.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    public class StackView: UIStackView {

        override public func addArrangedSubview(_ view: UIView) {
            guard let spacerView = view as? Ocean.Spacer,
                  self.distribution != .fillEqually,
                  self.distribution != .fillProportionally else {
                      super.addArrangedSubview(view)
                      return
                  }

            spacerView.backgroundColor = .clear
            super.addArrangedSubview(spacerView)
            spacerView.removeConstraints(spacerView.constraints)

            switch self.axis {
            case .vertical:
                spacerView.oceanConstraints
                    .height(constant: spacerView.space)
                    .make()
            case .horizontal:
                spacerView.oceanConstraints
                    .width(constant: spacerView.space)
                    .make()
            default: break
            }
        }
    }
}
