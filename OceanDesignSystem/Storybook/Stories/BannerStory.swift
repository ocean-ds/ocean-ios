//
//  BannerStory.swift
//  OceanDesignSystem
//
//  Story do componente OceanSwiftUI.Banner — registrada em StorybookCatalog.
//

import SwiftUI
import UIKit
import OceanComponents
import OceanTokens

enum BannerStory {
    static let story = StorybookStory(
        name: "Banner",
        group: "Feedback",
        makeView: { AnyView(BannerStoryView()) }
    )
}

struct BannerStoryView: View {
    @State private var sizeIndex = 0
    @State private var typeIndex = 0
    @State private var imageIndex = 1
    @State private var title = "Banner Title"
    @State private var description = "This is a description for the banner component."
    @State private var primaryButton = true
    @State private var secondaryButton = false

    private let sizes = ["Large", "Small"]
    private let types = ["Default", "Warning", "Negative", "Emphasys"]
    private let images = ["None", "Icon", "URL"]

    private let sampleImageURL =
        "https://portal-cob.blu.com.br/assets/credblu/" +
        "image_hero_bill_overdue_negative-" +
        "b5bb0660469f00e54ae453279e54f24800fb953f9d4664d704f89f3ebadd9203.webp"

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                StorybookCanvas {
                    OceanSwiftUI.Banner(parameters: makeParameters())
                }

                VStack(alignment: .leading, spacing: 12) {
                    StorybookControlsHeader()
                    StorybookSegmentedControl(title: "Size", options: sizes, selection: $sizeIndex)
                    StorybookSegmentedControl(title: "Type", options: types, selection: $typeIndex)
                    StorybookSegmentedControl(title: "Image", options: images, selection: $imageIndex)
                    StorybookTextControl(title: "Title", text: $title)
                    StorybookTextControl(title: "Description", text: $description)
                    StorybookToggleControl(title: "Primary button", isOn: $primaryButton)
                    StorybookToggleControl(title: "Secondary button", isOn: $secondaryButton)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
        }
    }

    private func makeParameters() -> OceanSwiftUI.BannerParameters {
        let sizeValues: [OceanSwiftUI.BannerParameters.Size] = [.large, .small]
        let typeValues: [OceanSwiftUI.BannerParameters.BannerType] = [.default, .warning, .negative, .emphasys]

        let parameters = OceanSwiftUI.BannerParameters()
        parameters.size = sizeValues[sizeIndex]
        parameters.bannerType = typeValues[typeIndex]
        parameters.title = title
        parameters.description = description

        switch imageIndex {
        case 1:
            parameters.image = UIImage(systemName: "photo")
        case 2:
            parameters.imageURL = sampleImageURL
        default:
            break
        }

        var buttons: [OceanSwiftUI.ButtonParameters] = []
        if primaryButton {
            buttons.append(OceanSwiftUI.ButtonParameters(text: "Ação principal"))
        }
        if secondaryButton {
            buttons.append(OceanSwiftUI.ButtonParameters(text: "Secundária"))
        }
        parameters.buttons = buttons

        return parameters
    }
}
