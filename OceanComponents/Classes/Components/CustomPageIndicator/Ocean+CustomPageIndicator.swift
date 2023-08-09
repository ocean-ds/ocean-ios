//
//  Ocean+CustomPageIndicator.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 08/08/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class CustomPageIndicator: UIView {
        private var indicators: [UIView] = []
        private var indicatorSize: CGSize = CGSize(width: 6, height: 6)
        private var selectedIndicatorSize: CGSize = CGSize(width: 12, height: 6)
        
        var numberOfPages: Int = 0 {
            didSet {
                setupIndicators()
                invalidateIntrinsicContentSize()
            }
        }
        
        var currentPage: CGFloat = 0 {
            didSet {
                updateIndicators()
            }
        }
        
        var currentPageIndicatorTintColor: UIColor = Ocean.color.colorBrandPrimaryPure {
            didSet {
                setNeedsLayout()
            }
        }
        
        var pageIndicatorTintColor: UIColor = Ocean.color.colorInterfaceLightDeep {
            didSet {
                setNeedsLayout()
            }
        }
        
        private func setupIndicators() {
            indicators.forEach { $0.removeFromSuperview() }
            indicators = []
            
            for _ in 0..<numberOfPages {
                let view = UIView()
                view.backgroundColor = Ocean.color.colorInterfaceLightDeep
                view.layer.cornerRadius = indicatorSize.height / 2
                addSubview(view)
                indicators.append(view)
            }
            
            updateIndicators()
        }
        
        private func updateIndicators() {
            let floorCurrentPage = Int(floor(currentPage))
            let ceilCurrentPage = Int(ceil(currentPage))
            
            for (index, view) in indicators.enumerated() {
                switch index {
                case floorCurrentPage:
                    updateIndicator(view, progress: 1 - (currentPage - CGFloat(floorCurrentPage)))
                case ceilCurrentPage:
                    updateIndicator(view, progress: currentPage - CGFloat(floorCurrentPage))
                default:
                    view.backgroundColor = pageIndicatorTintColor
                    view.frame.size = indicatorSize
                    view.layer.cornerRadius = indicatorSize.height / 2
                }
            }
            
            setNeedsLayout()
        }
        
        private func updateIndicator(_ view: UIView, progress: CGFloat) {

            view.backgroundColor = interpolate(from: pageIndicatorTintColor,
                                               to: currentPageIndicatorTintColor, with: progress)
            
            let widthDifference = selectedIndicatorSize.width - indicatorSize.width
            let newSize = CGSize(width: indicatorSize.width + widthDifference * progress,
                                 height: indicatorSize.height)
            view.frame.size = newSize
            view.layer.cornerRadius = newSize.height / 2
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            let spacing: CGFloat = 8
            var xPosition: CGFloat = 0
            
            for view in indicators {
                view.center.y = bounds.midY
                view.frame.origin.x = xPosition
                xPosition += view.frame.width + spacing
            }
            
            let totalWidth = (indicatorSize.width * CGFloat(indicators.count - 1)) + selectedIndicatorSize.width + (spacing * CGFloat(indicators.count - 1))
            frame.size = CGSize(width: totalWidth, height: indicatorSize.height)
        }
        
        public override var intrinsicContentSize: CGSize {
            let totalWidth = indicators.reduce(0) {
                $0 + $1.frame.width
            } + (8 * CGFloat(indicators.count - 1))
            return CGSize(width: totalWidth, height: indicatorSize.height)
        }
        
        private func interpolate(from: UIColor, to: UIColor, with progress: CGFloat) -> UIColor {
            let fromComponents = from.cgColor.components ?? [0, 0, 0, 0]
            let toComponents = to.cgColor.components ?? [0, 0, 0, 0]
            
            let r: CGFloat = fromComponents[0] + (toComponents[0] - fromComponents[0]) * progress
            let g: CGFloat = fromComponents[1] + (toComponents[1] - fromComponents[1]) * progress
            let b: CGFloat = fromComponents[2] + (toComponents[2] - fromComponents[2]) * progress
            let a: CGFloat = fromComponents[3] + (toComponents[3] - fromComponents[3]) * progress
            
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
    }
}
