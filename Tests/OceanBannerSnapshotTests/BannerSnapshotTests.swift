//
//  BannerSnapshotTests.swift
//  OceanBannerSnapshotTests (Swift Package test target)
//
//  Gera os snapshots PNG do componente REAL OceanSwiftUI.Banner para a galeria web.
//  Usa swift-snapshot-testing (captura SwiftUI de forma confiável), mas extrai o UIImage
//  diretamente para gravar com os nomes que a galeria espera (sem o "record mode").
//
//  Saída: <pasta deste arquivo>/__BannerSnapshots__/<key>.png
//  Chave compartilhada com o Android: banner__{size}__{type}__{image}__{buttons}
//

import XCTest
import SwiftUI
import UIKit
import OceanComponents
import OceanTokens
import SnapshotTesting

final class BannerSnapshotTests: XCTestCase {

    func testGenerateBannerSnapshots() throws {
        // Registra as fontes custom do Ocean (senão UIFont.baseBold(...) é nil e o Button crasha).
        Ocean.installFonts()

        let outDir = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .appendingPathComponent("__BannerSnapshots__", isDirectory: true)
        try FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)

        for snapshotCase in BannerSnapshotMatrix.all {
            let image = try render(OceanSwiftUI.Banner(parameters: snapshotCase.parameters()))
            guard let data = image.pngData() else {
                throw NSError(domain: "BannerSnapshot", code: 1,
                              userInfo: [NSLocalizedDescriptionKey: "Falha ao gerar PNG de \(snapshotCase.key)"])
            }
            try data.write(to: outDir.appendingPathComponent("\(snapshotCase.key).png"))
            print("[banner-snapshot] wrote \(snapshotCase.key).png")
        }
    }

    /// Renderiza o Banner DENTRO do contexto real do app (ScrollView + VStack, largura cheia da tela),
    /// para o storybook ser fiel — divergências dependentes de container aparecem aqui (igual ao app).
    private func render(_ banner: OceanSwiftUI.Banner) throws -> UIImage {
        let screen = ScrollView {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                banner
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, Ocean.size.spacingStackXs)
        }
        .background(Color(Ocean.color.colorInterfaceLightPure))

        var result: UIImage?
        let exp = expectation(description: "snapshot")
        Snapshotting<AnyView, UIImage>.image(layout: .fixed(width: 390, height: 844))
            .snapshot(AnyView(screen))
            .run { image in
                result = image
                exp.fulfill()
            }
        wait(for: [exp], timeout: 15)
        guard let image = result else {
            throw NSError(domain: "BannerSnapshot", code: 2,
                          userInfo: [NSLocalizedDescriptionKey: "snapshot retornou vazio"])
        }
        return image
    }
}

/// Uma combinação da matriz de variantes do Banner.
struct BannerSnapshotCase {
    let size: String
    let type: String
    let image: String
    let buttons: String

    var key: String { "banner__\(size)__\(type)__\(image)__\(buttons)" }

    func parameters() -> OceanSwiftUI.BannerParameters {
        let parameters = OceanSwiftUI.BannerParameters()
        parameters.size = size == "large" ? .large : .small
        parameters.bannerType = bannerType()
        parameters.title = "Banner Title"
        parameters.description = "This is a description for the banner component."
        if image == "image" {
            parameters.image = UIImage(systemName: "photo")
        }
        parameters.buttons = buttonParameters()
        return parameters
    }

    private func bannerType() -> OceanSwiftUI.BannerParameters.BannerType {
        switch type {
        case "warning": return .warning
        case "negative": return .negative
        case "emphasys": return .emphasys
        default: return .default
        }
    }

    private func buttonParameters() -> [OceanSwiftUI.ButtonParameters] {
        switch buttons {
        case "one": return [OceanSwiftUI.ButtonParameters(text: "Ação principal")]
        case "two": return [OceanSwiftUI.ButtonParameters(text: "Ação principal"),
                            OceanSwiftUI.ButtonParameters(text: "Secundária")]
        default: return []
        }
    }
}

/// Matriz compartilhada com o Android — mantenha as dimensões e a ordem em sincronia.
enum BannerSnapshotMatrix {
    static let all: [BannerSnapshotCase] = {
        let sizes = ["large", "small"]
        let types = ["default", "warning", "negative", "emphasys"]
        let images = ["noimage", "image"]
        let buttons = ["none", "one", "two"]

        var matrix: [BannerSnapshotCase] = []
        for size in sizes {
            for type in types {
                for image in images {
                    for button in buttons {
                        matrix.append(BannerSnapshotCase(size: size, type: type, image: image, buttons: button))
                    }
                }
            }
        }
        return matrix
    }()
}
