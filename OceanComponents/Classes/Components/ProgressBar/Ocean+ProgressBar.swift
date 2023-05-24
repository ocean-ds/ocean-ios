//
//  Ocean+ProgressBar.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 22/05/23.
//

import UIKit
import OceanTokens

extension Ocean {
    
    public class ProgressBar: UIView {
        
        // MARK: Private properties
        
        private let progressViewHeight: CGFloat = 8
        
        // MARK: Views
        
        private lazy var progressView: UIProgressView = {
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.progress = 0
            progressView.progressTintColor = Ocean.color.colorBrandPrimaryDown
            progressView.trackTintColor = Ocean.color.colorInterfaceLightDown
            progressView.subviews.forEach {
                $0.layer.cornerRadius = progressViewHeight / 2
                $0.clipsToBounds = true
            }

            return progressView
        }()
        
        private lazy var progressLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 1
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.textAlignment = .right
                label.text = "0%"
            }
        }()
        
        // MARK: Constructors
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            addSubviews(progressView, progressLabel)
            
            progressView.oceanConstraints
                .centerY(to: self)
                .leadingToLeading(to: self)
                .trailingToLeading(to: progressLabel, constant: -Ocean.size.spacingStackXxs)
                .height(constant: progressViewHeight)
                .make()
            
            progressLabel.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingStackXxs)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingStackXxs)
                .trailingToTrailing(to: self)
                .width(constant: 36, type: .greaterThanOrEqualTo)
                .make()
        }
        
        // MARK: Public methods
        
        public func setProgress(_ progress: Float) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                guard let self = self else { return }

                self.progressView.setProgress(progress, animated: true)
            }
            
            let formattedValue = String(format: "%.0f", progress * 100)
            progressLabel.text = "\(formattedValue)%"
        }
    }
}
