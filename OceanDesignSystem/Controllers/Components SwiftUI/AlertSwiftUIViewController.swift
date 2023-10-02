//
//  AlertSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 02/10/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class AlertSwiftUIViewController: UIViewController {
    
    lazy var alertInfo: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.info { alert in
            alert.parameters.text = "Text"
        }
    }()
    
    lazy var alertInfoLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.infoLong { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Info Long"
        }
    }()
    
    lazy var alertInfoShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.infoShort { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Info Short"
        }
    }()
    
    lazy var alertWarning: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.warning { alert in
            alert.parameters.text = "Text alert Warning"
        }
    }()
    
    lazy var alertWarningLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.warningLong { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Warning Long"
        }
    }()
    
    lazy var alertWarningShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.warningShort { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Warning Short"
        }
    }()
    
    lazy var alertPositive: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positive { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "alert Positive"
        }
    }()
    
    lazy var alertPositiveLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positiveLong { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Positive Long"
        }
    }()
    
    lazy var alertPositiveShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positiveShort { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Positive Short"
        }
    }()
    
    lazy var alertNegative: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negative { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Negative"
        }
    }()
    
    lazy var alertNegativeLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negativeLong { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Negative Long"
        }
    }()
    
    lazy var alertNegativeShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negativeShort { alert in
            alert.parameters.title = "Title"
            alert.parameters.text = "Text alert Negative Short"
        }
    }()
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            alertInfo.uiView,
            alertInfoLong.uiView,
            alertInfoShort.uiView,
            alertWarning.uiView,
            alertWarningLong.uiView,
            alertWarningShort.uiView,
            alertPositive.uiView,
            alertPositiveLong.uiView,
            alertPositiveShort.uiView,
            alertNegative.uiView,
            alertNegativeLong.uiView,
            alertNegativeShort.uiView
        ])

        stack.setMargins(horizontal: Ocean.size.spacingStackXs)

        return stack
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        setupConstraints()
    }

    private func setupConstraints() {
        mainStack.oceanConstraints
            .topToTop(to: self.view)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .make()
    }
}
