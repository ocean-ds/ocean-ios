//
//  CardListItemTagPositionTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Cobre a prop `tagPosition` do CardListItem (MR-555 / MR-552): os valores `.above` e
/// `.below` acrescentados, e a não-regressão dos valores preexistentes (RN-01).
///
/// O repositório não tem infraestrutura de snapshot, então a verificação aqui é de API e
/// de contrato de parâmetros; a fidelidade visual das posições é validada no app de showcase.
final class CardListItemTagPositionTests: XCTestCase {

    // MARK: - RN-01: o default não muda

    func testDefaultTagPositionIsLeading() {
        let parameters = OceanSwiftUI.CardListItemParameters()

        XCTAssertEqual(parameters.tagPosition, .leading)
    }

    func testDefaultTagPositionIsPreservedWhenOtherParametersAreSet() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             subtitle: "Subtitle",
                                                             tagLabel: "3x sem acréscimo")

        XCTAssertEqual(parameters.tagPosition, .leading)
    }

    func testTrailingRemainsAssignable() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             tagLabel: "3x sem acréscimo",
                                                             tagPosition: .trailing)

        XCTAssertEqual(parameters.tagPosition, .trailing)
    }

    // MARK: - Valores novos

    func testAboveIsAssignableViaInitializer() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             subtitle: "Subtitle",
                                                             caption: "Caption",
                                                             tagLabel: "3x sem acréscimo",
                                                             tagPosition: .above)

        XCTAssertEqual(parameters.tagPosition, .above)
    }

    func testBelowIsAssignableViaInitializer() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             subtitle: "Subtitle",
                                                             caption: "Caption",
                                                             tagLabel: "3x sem acréscimo",
                                                             tagPosition: .below)

        XCTAssertEqual(parameters.tagPosition, .below)
    }

    func testTagPositionIsMutableAfterInit() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             tagLabel: "3x sem acréscimo")
        parameters.tagPosition = .above

        XCTAssertEqual(parameters.tagPosition, .above)
    }

    /// O `switch` exaustivo é a prova de compilação de que o enum tem exatamente estes quatro
    /// casos — se alguém acrescentar ou remover um valor, este teste deixa de compilar.
    func testTagPositionHasExactlyFourCases() {
        let allCases: [OceanSwiftUI.CardListItemParameters.TagPosition] =
            [.leading, .trailing, .above, .below]

        for position in allCases {
            switch position {
            case .leading, .trailing, .above, .below:
                continue
            }
        }

        XCTAssertEqual(allCases.count, 4)
    }

    // MARK: - Construção da view com cada posição

    func testViewIsBuiltForEveryTagPosition() {
        let positions: [OceanSwiftUI.CardListItemParameters.TagPosition] =
            [.leading, .trailing, .above, .below]

        for position in positions {
            let view = OceanSwiftUI.CardListItem { card in
                card.parameters.title = "Title"
                card.parameters.subtitle = "Subtitle"
                card.parameters.caption = "Caption"
                card.parameters.tagLabel = "3x sem acréscimo"
                card.parameters.tagPosition = position
                card.parameters.hasRadioButton = true
            }

            XCTAssertEqual(view.parameters.tagPosition, position)
        }
    }

    func testViewIsBuiltWithoutTagWhenPositionIsSet() {
        let view = OceanSwiftUI.CardListItem { card in
            card.parameters.title = "Title"
            card.parameters.tagPosition = .above
        }

        XCTAssertTrue(view.parameters.tagLabel.isEmpty)
        XCTAssertEqual(view.parameters.tagPosition, .above)
    }
}
