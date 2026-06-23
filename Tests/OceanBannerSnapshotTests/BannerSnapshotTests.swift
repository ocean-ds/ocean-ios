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

    // MARK: Validação do bug do small (reproduz o contexto do app demo)

    /// Gera duas telas no MESMO contexto do app demo (vários banners num ScrollView, small no topo):
    /// - `validation-buggy.png`: réplica do layout ANTIGO (maxHeight: .infinity) → deve estourar.
    /// - `validation-fixed.png`: componente REAL corrigido → deve ficar correto.
    func testGenerateValidationScreens() throws {
        Ocean.installFonts()
        let outDir = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .appendingPathComponent("__BannerSnapshots__", isDirectory: true)
        try FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)

        try writeScreen(AnyView(demoScreen(buggy: true)),
                        to: outDir.appendingPathComponent("validation-buggy.png"))
        try writeScreen(AnyView(demoScreen(buggy: false)),
                        to: outDir.appendingPathComponent("validation-fixed.png"))
    }

    private func writeScreen(_ view: AnyView, to url: URL) throws {
        var result: UIImage?
        let exp = expectation(description: "screen")
        Snapshotting<AnyView, UIImage>.image(layout: .fixed(width: 390, height: 844))
            .snapshot(view)
            .run { image in
                result = image
                exp.fulfill()
            }
        wait(for: [exp], timeout: 20)
        guard let data = result?.pngData() else {
            throw NSError(domain: "BannerSnapshot", code: 3,
                          userInfo: [NSLocalizedDescriptionKey: "tela de validação vazia"])
        }
        try data.write(to: url)
    }

    private func demoScreen(buggy: Bool) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
                if buggy {
                    BuggyOldSmallBanner(title: "Banner Small Default", description: "")
                    BuggyOldSmallBanner(title: "Banner Small Warning", description: "Aviso compacto.")
                } else {
                    OceanSwiftUI.Banner(parameters: self.demoSmallParams(type: .default, description: ""))
                    OceanSwiftUI.Banner(parameters: self.demoSmallParams(type: .warning, description: "Aviso compacto."))
                }

                ForEach(0..<4, id: \.self) { _ in
                    OceanSwiftUI.Banner(parameters: self.demoLargeParams())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, Ocean.size.spacingStackXs)
        }
        .background(Color(Ocean.color.colorInterfaceLightPure))
    }

    private func demoSmallParams(type: OceanSwiftUI.BannerParameters.BannerType,
                                 description: String) -> OceanSwiftUI.BannerParameters {
        let parameters = OceanSwiftUI.BannerParameters()
        parameters.size = .small
        parameters.bannerType = type
        parameters.title = type == .warning ? "Banner Small Warning" : "Banner Small Default"
        parameters.description = description
        parameters.image = UIImage(systemName: type == .warning ? "exclamationmark.triangle" : "photo")
        return parameters
    }

    private func demoLargeParams() -> OceanSwiftUI.BannerParameters {
        let parameters = OceanSwiftUI.BannerParameters()
        parameters.size = .large
        parameters.bannerType = .default
        parameters.title = "Banner Large Default"
        parameters.description = "Descrição opcional do banner no tamanho large."
        parameters.image = UIImage(systemName: "photo")
        parameters.buttons = [OceanSwiftUI.ButtonParameters(text: "Ação")]
        return parameters
    }
}

/// Réplica do layout ANTIGO do small (com `maxHeight: .infinity`) para comparar com o corrigido.
private struct BuggyOldSmallBanner: View {
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline)
                if !description.isEmpty {
                    Text(description).font(.subheadline).foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)

            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 82)
                .frame(maxHeight: .infinity)
                .clipped()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 1.0, green: 0.96, blue: 0.91))
        .cornerRadius(8)
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
