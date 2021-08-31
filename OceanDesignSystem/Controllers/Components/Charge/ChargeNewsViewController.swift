//
//  ChargeNewsViewController.swift
//  OceanDesignSystem
//
//  Created by Pedro Azevedo on 31/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

class ChargeNewsViewController: UIViewController {
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.borderRadiusLg
        
        stack.addArrangedSubview(topImageView)
        stack.addArrangedSubview(newsInfoLabelStack)
        stack.addArrangedSubview(newsInfoStack)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.borderRadiusMd))
        stack.addArrangedSubview(actionButton)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.borderRadiusLg))
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: Ocean.size.borderRadiusLg, left: 0, bottom: 0, right: 0)
        return stack
    }()
    
    private lazy var topImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ilustra-novidade")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public lazy var newsTitleInfoLabel: UILabel = {
        Ocean.Typography.description { label in
            label.textColor = Ocean.color.colorComplementaryPure
            label.text = "Novidade!"
        }
    }()
    
    public lazy var newsSubtitleInfoLabel: UILabel = {
        Ocean.Typography.heading3 { label in
            label.numberOfLines = 0
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.text = "Seus boletos de fornecedores agora chegam de forma automática na Blu!"
        }
    }()
    
    private lazy var newsInfoLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.borderRadiusMd
        stack.addArrangedSubview(newsTitleInfoLabel)
        stack.addArrangedSubview(newsSubtitleInfoLabel)
        return stack
    }()
    
    private lazy var newsInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(cashBackOptionInfoView)
        stack.addArrangedSubview(allPaymentsOptionInfoView)
        return stack
    }()
    
    private lazy var cashBackOptionInfoView: OptionInfoView = {
        let optionInfoView = OptionInfoView()
        optionInfoView.image = Ocean.icon.giftOutline
        optionInfoView.title = "Ganhe 1% de cashback"
        optionInfoView.subtitle = "Pagando seus boletos de fornecedores na Blu você ganha cashback."
        return optionInfoView
    }()
    
    private lazy var allPaymentsOptionInfoView: OptionInfoView = {
        let optionInfoView = OptionInfoView()
        optionInfoView.image = Ocean.icon.sparklesOutline
        optionInfoView.title = "Simplifique sua vida"
        optionInfoView.subtitle = "Centralize todos os seus pagamentos a fornecedores em um só lugar."
        return optionInfoView
    }()
    
    private lazy var actionButton: Ocean.ButtonPrimary = {
        Ocean.ButtonPrimary { button in
            button.text = "Entendi!"
            button.onTouch = {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.add(view: mainStack)
    }
}

