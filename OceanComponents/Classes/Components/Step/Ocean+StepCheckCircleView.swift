//
//  Ocean+StepCheckCircleView.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    final class StepCheckCircleView: StepBaseCircleView, ICheckCircleViewDrawable {
        private var imageSize: CGFloat {
            return circleRadius - circleRadius / 4
        }
        
        var image: UIImage? = Ocean.icon.checkSolid
        
        convenience init(frame: CGRect,
                         circleRadius: CGFloat,
                         circleBorderColor: UIColor) {
            self.init(frame: frame)
            self.circleRadius = circleRadius
            self.circleBorderColor = circleBorderColor
            self.circleBorderWidth = circleBorderWidth * 2
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            drawImage()
        }
        
        func drawImage() {
            let imageView = UIImageView()
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = Ocean.color.colorInterfaceLightPure
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: imageSize),
                imageView.heightAnchor.constraint(equalToConstant: imageSize),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
}
