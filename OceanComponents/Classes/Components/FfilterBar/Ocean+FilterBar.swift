//
//  Ocean+FilterBar.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 26/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class FilterBar: UIView {
        
        private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        
        private let stackView: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.setMargins(horizontal: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupScrollView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupScrollView() {
            addSubview(scrollView)
            scrollView.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
            
            NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])
        }
        
        public func addFilterChips(_ view: [ChipWithFilter]) {
            stackView.add(view)
            stackView.add([Divider(heightConstraint: scrollView.widthAnchor, axis: .vertical)])
        }
        
        public func addBasicChips(_ view: [SingleChipFilter]) {
            stackView.add(view)
        }
    }
}
