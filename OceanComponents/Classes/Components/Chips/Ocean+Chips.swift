//
//  Ocean+Chips.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 08/12/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class Chips: UIView {
        struct Constants {
            static let height: CGFloat = 32
        }
        
        public var items: [String] = [] {
            didSet {
                updateUI()
            }
        }
        
        public var type: ChipType = .choice
        {
            didSet {
                updateUI()
            }
        }
        
        private var listChips: [ChipChoice] = []
        
        private lazy var scrollView: UIScrollView = {
            return UIScrollView()
        }()
        
        private lazy var rootView: UIView = {
            return UIView()
        }()
        
        private lazy var mainStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.backgroundColor = Ocean.color.colorInterfaceLightPure
            stack.spacing = 8
            stack.add(listChips)
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        public convenience init(builder: ChipsBuilder) {
            self.init()
            setupUI()
            builder(self)
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.shadowRadius = 8
            
            self.add(view: mainStack)
        }
        
        private func updateUI() {
            self.mainStack.removeAllArrangedSubviews()
            self.listChips.removeAll()
            
            switch type {
            case .choice:
                createChoiceItems()
            case .choiceWithIcon:
                break
            case .choiceWithBadge:
                break
            case .filter:
                break
            }
            
//            items.enumerated().forEach { (index, text) in
//                let view = Ocean.ChipChoice { view in
//                    view.index = index
//                    view.text = text
//                    view.status = .normal
//                    view.onSelected =  { chip in
//                        print("selected: \(chip.index) \(chip.text)")
//                    }
//                    view.onDeselected = { chip in
//                        print("deselected: \(chip.index) \(chip.text)")
//                    }
//                }
//                listChips.append(view)
//            }
//            self.mainStack.add(listChips)
        }
        
        private func createChoiceItems() {
            items.enumerated().forEach { (index, text) in
                let view = Ocean.ChipChoice { view in
                    view.index = index
                    view.text = text
                    view.status = .normal
                    view.onSelected =  { chip in
                        print("selected: \(chip.index) \(chip.text)")
                    }
                    view.onDeselected = { chip in
                        print("deselected: \(chip.index) \(chip.text)")
                    }
                }
                listChips.append(view)
            }
            self.mainStack.add(listChips)
        }
    }
}
