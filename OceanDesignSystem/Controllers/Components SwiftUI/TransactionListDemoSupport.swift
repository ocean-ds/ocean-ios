//
//  TransactionListDemoSupport.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import OceanComponents
import OceanTokens
import SwiftUI
import UIKit

/// Sample data and layout shared by the Transaction List family demo screens (MR-615, CT-1..CT-8).
enum TransactionListDemo {

    static func content(_ size: OceanSwiftUI.ContentListParameters.Size = .md,
                        type: OceanSwiftUI.ContentListParameters.ContentListItemType = .default) -> OceanSwiftUI.ContentListParameters {
        OceanSwiftUI.ContentListParameters(title: "Title",
                                           description: "Description",
                                           caption: "Caption",
                                           type: type,
                                           size: size,
                                           strikethroughText: type == .strikethrough ? "Strikethrough" : "")
    }

    static func amount(_ size: OceanSwiftUI.AmountDetailsParameters.Size = .md,
                       type: OceanSwiftUI.AmountDetailsParameters.AmountType = .default) -> OceanSwiftUI.AmountDetailsParameters {
        OceanSwiftUI.AmountDetailsParameters(amount: "R$ 0,00",
                                             strikethroughAmount: "R$ 0,00",
                                             type: type,
                                             size: size,
                                             tag: .init(label: "Label", status: .positive),
                                             additionalData: "Additional data")
    }

    static let states: [(String, OceanSwiftUI.TransactionListState)] = [
        ("Default", .default),
        ("Loading", .loading),
        ("Disabled", .disabled)
    ]

    static let iconColors: [(String, OceanSwiftUI.TransactionListIconColor)] = [
        ("Default", .default),
        ("On color", .onColor),
        ("Highlight", .highlight)
    ]

    static let densities: [(String, OceanSwiftUI.TransactionListDensity)] = [
        ("Default", .default),
        ("Compact", .compact)
    ]

    static let positions: [(String, OceanSwiftUI.TransactionListChildPosition)] = [
        ("Standalone", .standalone),
        ("First", .first),
        ("Middle", .middle),
        ("Last", .last)
    ]

    static let sizes: [(String, OceanSwiftUI.ContentListParameters.Size, OceanSwiftUI.AmountDetailsParameters.Size)] = [
        ("Conteúdo md · valor md", .md, .md),
        ("Conteúdo sm · valor md", .sm, .md),
        ("Conteúdo md · valor sm", .md, .sm),
        ("Conteúdo sm · valor sm", .sm, .sm)
    ]

    static let amountTypes: [(String, OceanSwiftUI.AmountDetailsParameters.AmountType)] = [
        ("Default", .default),
        ("Positive", .positive),
        ("Negative", .negative),
        ("Inactive", .inactive),
        ("Strikethrough", .strikethrough),
        ("Strikethrough Neutral", .strikethroughNeutral)
    ]

    static let contentTypes: [(String, OceanSwiftUI.ContentListParameters.ContentListItemType)] = [
        ("Default", .default),
        ("Inactive", .inactive),
        ("Positive", .positive),
        ("Warning", .warning),
        ("Highlight", .highlight),
        ("Highlight Lead", .highlightLead),
        ("Strikethrough", .strikethrough)
    ]
}

/// Titled block of a demo screen.
struct TransactionListDemoSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OceanSwiftUI.Typography.eyebrow { label in
                label.parameters.text = title
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .padding(.top, Ocean.size.spacingStackSm)
            .padding(.bottom, Ocean.size.spacingStackXxs)

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Hosts a demo screen the same way the other SwiftUI demo controllers do.
class TransactionListDemoViewController<Content: View>: UIViewController {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let hostingController = UIHostingController(rootView: ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                content
            }
            .padding(.bottom, Ocean.size.spacingStackLg)
        })
        let uiView = hostingController.getUIView()
        view.addSubview(uiView)
        uiView.oceanConstraints
            .fill(to: view)
            .make()
    }
}
