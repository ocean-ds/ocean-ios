//
//  BannerSnapshotTests.swift
//  OceanBannerSnapshotTests (Swift Package test target)
//
//  Gera os snapshots PNG do componente REAL OceanSwiftUI.Banner para a galeria web.
//  Vive num test target do Swift Package (membership explícita) — o test target do app
//  de exemplo não compilava arquivos novos (synchronized group não os incluía).
//
//  Render real via UIHostingController + UIGraphicsImageRenderer (sem dependência extra).
//  Saída: <pasta deste arquivo>/__BannerSnapshots__/<key>.png
//  Chave compartilhada com o Android: banner__{size}__{type}__{image}__{buttons}
//

import XCTest
import SwiftUI
import UIKit
import OceanComponents

final class BannerSnapshotTests: XCTestCase {

    private let width: CGFloat = 343

    func testGenerateBannerSnapshots() throws {
        let outDir = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .appendingPathComponent("__BannerSnapshots__", isDirectory: true)
        try FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)

        for snapshotCase in BannerSnapshotMatrix.all {
            let view = OceanSwiftUI.Banner(parameters: snapshotCase.parameters())
                .frame(width: width)
            let data = try Self.png(of: view, width: width)
            try data.write(to: outDir.appendingPathComponent("\(snapshotCase.key).png"))
            print("[banner-snapshot] wrote \(snapshotCase.key).png")
        }
    }

    /// Renderiza uma SwiftUI View para PNG via UIHostingController + UIGraphicsImageRenderer.
    static func png<Content: View>(of view: Content, width: CGFloat) throws -> Data {
        let controller = UIHostingController(rootView: view)
        let target = controller.view!
        target.backgroundColor = .clear

        let fitting = target.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        let height = max(fitting.height, 1)
        target.bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let window = UIWindow(frame: target.bounds)
        window.rootViewController = controller
        window.isHidden = false
        target.setNeedsLayout()
        target.layoutIfNeeded()

        let renderer = UIGraphicsImageRenderer(bounds: target.bounds)
        let image = renderer.image { _ in
            target.drawHierarchy(in: target.bounds, afterScreenUpdates: true)
        }
        guard let data = image.pngData() else {
            throw NSError(domain: "BannerSnapshot", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Falha ao gerar PNG"])
        }
        return data
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
