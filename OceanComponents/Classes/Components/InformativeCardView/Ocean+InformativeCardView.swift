//
//  Ocean+InformativeCardView.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 19/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    
    public struct InformativeCardModel {
        
        public var state: Ocean.InformativeCardViewState
        public var iconImage: UIImage
        public var tooltipMessage: String
        public var titleText: String
        public var valueText: String?
        public var descriptionText: String
        public var subItems: [InformativeCardSubItemModel]
        public var additionalInformationText: String
        public var actionText: String?
        public var onTouchAction: ((GroupCTA) -> Void)?
        
        public init(state: Ocean.InformativeCardViewState,
                    iconImage: UIImage,
                    tooltipMessage: String? = nil,
                    titleText: String,
                    valueText: String? = nil,
                    descriptionText: String? = nil,
                    subItems: [InformativeCardSubItemModel]? = nil,
                    additionalInformationText: String? = nil,
                    actionText: String? = nil,
                    onTouchAction: ((GroupCTA) -> Void)?) {
            self.state = state
            self.iconImage = iconImage
            self.tooltipMessage = tooltipMessage ?? ""
            self.titleText = titleText
            self.valueText = valueText
            self.descriptionText = descriptionText ?? ""
            self.subItems = subItems ?? []
            self.additionalInformationText = additionalInformationText ?? ""
            self.actionText = actionText
            self.onTouchAction = onTouchAction
        }
    }
    
    public struct InformativeCardSubItemModel {
        
        public var tooltipMessage: String
        public var labelText: String
        public var valueText: String
        
        public init(labelText: String, valueText: String, tooltipMessage: String = "") {
            self.labelText = labelText
            self.valueText = valueText
            self.tooltipMessage = tooltipMessage
        }
    }
    
    public enum InformativeCardViewState: String {
        case defaultState
        case sellState
        case emptyState
    }
    
    public class InformativeCardView: UIView {
        
        // MARK: Private properties
        
        private var model: InformativeCardModel
        
        // MARK: Views
        
        private lazy var defaultView: InformativeCardDefaultView = {
            let view = InformativeCardDefaultView(frame: .zero, model: model)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        private lazy var sellView: InformativeCardSellView = {
            let view = InformativeCardSellView(frame: .zero, model: model)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        private lazy var emptyView: InformativeCardEmptyView = {
            let view = InformativeCardEmptyView(frame: .zero, model: model)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        private lazy var divider: Ocean.Divider = {
            let divider = Ocean.Divider()
            divider.isHidden = cta.isHidden
            divider.translatesAutoresizingMaskIntoConstraints = false
            divider.isHiddenWhenSkeletonIsActive = true
            divider.isSkeletonable = true
            
            return divider
        }()
        
        private lazy var cta: Ocean.GroupCTA = {
            let cta = Ocean.GroupCTA()
            cta.translatesAutoresizingMaskIntoConstraints = false
            cta.isHiddenWhenSkeletonIsActive = true
            cta.isSkeletonable = true
            cta.onTouch = { [weak self] in
                guard let self = self else { return }
                
                self.model.onTouchAction?(self.cta)
            }
            
            return cta
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                
                stack.alignment = .fill
                stack.axis = .vertical
                stack.backgroundColor = Ocean.color.colorInterfaceLightPure
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.isSkeletonable = true
                
                stack.add([
                    defaultView,
                    sellView,
                    emptyView,
                    divider,
                    cta
                ])
            }
        }()
        
        // MARK: Constructors
        
        public init(frame: CGRect, model: InformativeCardModel) {
            self.model = model
            super.init(frame: frame)
            
            setupUI()
            updateUI()
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            isSkeletonable = true
            addSubview(contentStack)
            
            ocean.radius.applyMd()
            ocean.borderWidth.applyHairline(color: Ocean.color.colorInterfaceLightDown)
            
            contentStack.oceanConstraints
                .fill(to: self)
                .make()
        }
        
        // MARK: Private methods
        
        private func updateUI() {
            defaultView.isHidden = model.state != .defaultState
            sellView.isHidden = model.state != .sellState
            emptyView.isHidden = model.state != .emptyState
            
            defaultView.updateUI()
            sellView.updateUI()
            emptyView.updateUI()
            
            cta.text = model.actionText ?? ""
            cta.isHidden = model.actionText == nil || model.actionText?.isEmpty == true
            cta.isSkeletonable = !cta.isHidden
            divider.isHidden = cta.isHidden
        }
    }
}
