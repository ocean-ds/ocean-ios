//
//  LinkSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 03/10/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class LinkSwiftUIViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var linkPrimaryMedium: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryMedium { link in
            link.parameters.text = "linkPrimaryMedium"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimaryMediumChevron: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryMedium { link in
            link.parameters.text = "linkPrimaryMediumChevron"
            link.parameters.type = .chevron
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimaryMediumExternal: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryMedium { link in
            link.parameters.text = "linkPrimaryMediumExternal"
            link.parameters.type = .external
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimarySmall: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primarySmall { link in
            link.parameters.text = "linkPrimarySmall"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimarySmallChevron: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primarySmall { link in
            link.parameters.text = "linkPrimarySmallChevron"
            link.parameters.type = .chevron
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimarySmallExternal: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primarySmall { link in
            link.parameters.text = "linkPrimarySmallExternal"
            link.parameters.type = .external
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimaryTiny: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryTiny { link in
            link.parameters.text = "linkPrimaryTiny"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimaryTinyChevron: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryTiny { link in
            link.parameters.text = "linkPrimaryTinyChevron"
            link.parameters.type = .chevron
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkPrimaryTinyExternal: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryTiny { link in
            link.parameters.text = "linkPrimaryTinyExternal"
            link.parameters.type = .external
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkDisabled: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.primaryMedium { link in
            link.parameters.text = "linkDisabled"
            link.parameters.isEnabled = false
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkInverseMedium: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.inverseMedium { link in
            link.parameters.text = "linkInverseMedium"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkInverseSmall: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.inverseSmall { link in
            link.parameters.text = "linkInverseSmall"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkInverseTiny: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.inverseTiny { link in
            link.parameters.text = "linkInverseTiny"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkNeutralMedium: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.neutralMedium { link in
            link.parameters.text = "linkNeutralMedium"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkNeutralSmall: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.neutralSmall { link in
            link.parameters.text = "linkNeutralSmall"
            link.parameters.onTouch = { }
        }
    }()
    
    lazy var linkNeutralTiny: OceanSwiftUI.Link = {
        return OceanSwiftUI.Link.neutralTiny { link in
            link.parameters.text = "linkNeutralTiny"
            link.parameters.onTouch = { }
        }
    }()
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs
        
        stack.add([
            linkPrimaryMedium.uiView,
            linkPrimaryMediumChevron.uiView,
            linkPrimaryMediumExternal.uiView,
            linkPrimarySmall.uiView,
            linkPrimarySmallChevron.uiView,
            linkPrimarySmallExternal.uiView,
            linkPrimaryTiny.uiView,
            linkPrimaryTinyChevron.uiView,
            linkPrimaryTinyExternal.uiView,
            linkDisabled.uiView,
            linkInverseMedium.uiView,
            linkInverseSmall.uiView,
            linkInverseTiny.uiView,
            linkNeutralMedium.uiView,
            linkNeutralSmall.uiView,
            linkNeutralTiny.uiView,
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
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
            .make()
        
        mainStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: view)
            .make()
    }
}
