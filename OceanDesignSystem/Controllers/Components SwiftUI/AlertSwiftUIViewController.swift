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
            alert.parameters.text = "Text Ocean SwiftUI Alert Info"
        }
    }()
    
    lazy var alertInfoLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.infoLong { alert in
            alert.parameters.title = "Alert With Long Another Icon"
            alert.parameters.text = "Enim id vestibulum convallis in posuere pulvinar orci, convallis commodo lorem lacus quam eros"
            alert.parameters.icon = Ocean.icon.placeholderOutline
        }
    }()
    
    lazy var alertInfoShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.infoShort { alert in
            alert.parameters.title = "Info Short"
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
            alert.parameters.title = "Title Long Text"
            alert.parameters.text = "Text Ocean SwiftUI Alert Info Text Ocean SwiftUI Alert Info Warning Positive Negative Text Ocean SwiftUI Alert Info"
        }
    }()
    
    lazy var alertWarningShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.warningShort { alert in
            alert.parameters.title = "Warning Short"
            alert.parameters.text = "Text alert Warning Short"
        }
    }()
    
    lazy var alertPositive: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positive { alert in
            alert.parameters.text = "alert Positive"
        }
    }()
    
    lazy var alertPositiveLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positiveLong { alert in
            alert.parameters.title = "Title Long"
            alert.parameters.text = "Text Ocean SwiftUI Alert Info Text Ocean SwiftUI Alert Info Warning Positive Negative Text Ocean SwiftUI Alert Info"
        }
    }()
    
    lazy var alertPositiveShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positiveShort { alert in
            alert.parameters.title = "Title Short"
            alert.parameters.text = "Text alert Positive Short"
        }
    }()
    
    lazy var alertNegative: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negative { alert in
            alert.parameters.text = "Text alert Negative"
        }
    }()
    
    lazy var alertNegativeLong: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negativeLong { alert in
            alert.parameters.title = "Title Long"
            alert.parameters.text = "Text Ocean SwiftUI Alert Info Text Ocean SwiftUI Alert Info Warning Positive Negative Text Ocean SwiftUI Alert Info"
        }
    }()
    
    lazy var alertNegativeShort: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negativeShort { alert in
            alert.parameters.title = "Title Short"
            alert.parameters.text = "Text alert Negative Short"
        }
    }()
    
    lazy var alertInfoWithLink: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.infoShort { alert in
            alert.parameters.title = "Title Short"
            alert.parameters.text = "Orci vel donec consectetur taciti at sagittis neque maecenas quam venenatis adipiscing."
            alert.parameters.actionText = "action"
            alert.parameters.actionOnTouch = { }
        }
    }()
    
    lazy var alertWarningWithLink: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.warningShort { alert in
            alert.parameters.title = "Title Short"
            alert.parameters.text = "Lorem ipsum dolor sit amet consectetur. Sed tincidunt habitasse nam arcu orci. Mi dui in sed."
            alert.parameters.actionText = "action"
            alert.parameters.actionType = .button
            alert.parameters.actionOnTouch = { }
            alert.parameters.withIcon = false
        }
    }()
    
    lazy var alertPositiveWithLink: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.positiveLong { alert in
            alert.parameters.title = "Title Long"
            alert.parameters.text = "Lorem ipsum dolor sit amet consectetur. Sed tincidunt habitasse nam arcu orci. Mi dui in sed."
            alert.parameters.actionText = "Link Text"
            alert.parameters.actionOnTouch = { }
        }
    }()
    
    lazy var alertNegativeWithLink: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negativeLong { alert in
            alert.parameters.title = "Title Long"
            alert.parameters.text = "Lorem ipsum dolor sit amet consectetur. Sed tincidunt habitasse nam arcu orci. Mi dui in sed."
            alert.parameters.actionText = "action Text"
            alert.parameters.actionOnTouch = { print("actionOnTouch")}
            alert.parameters.withIcon = false
        }
    }()

    lazy var alertNegativeWithButton: OceanSwiftUI.Alert = {
        return OceanSwiftUI.Alert.negativeLong { alert in
            alert.parameters.title = "Title Long"
            alert.parameters.text = "Lorem ipsum dolor sit amet consectetur. Sed tincidunt habitasse nam arcu orci. Mi dui in sed."
            alert.parameters.actionText = "action"
            alert.parameters.actionType = .button
            alert.parameters.actionOnTouch = { print("actionOnTouch")}
            alert.parameters.withIcon = false
        }
    }()
    
    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            alertInfo
            alertInfoLong
            alertInfoShort
            alertWarning
            alertWarningLong
            alertWarningShort
            alertPositive
            alertPositiveLong
            alertPositiveShort
            alertNegative
            alertNegativeLong
            alertNegativeShort
            alertInfoWithLink
            alertWarningWithLink
            alertPositiveWithLink
            alertNegativeWithLink
            alertNegativeWithButton
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}
