//
//  OceanSwiftUI+CarouselBuilder.swift
//  Pods
//
//  Created by Vinicius Romeiro on 17/12/24.
//

import OceanTokens
import SwiftUI

extension OceanSwiftUI {
    public struct Carousel {
        public static func withImages(builder: OceanSwiftUI.CarouselWithImages.Builder) -> OceanSwiftUI.CarouselWithImages {
            return OceanSwiftUI.CarouselWithImages(builder: builder)
        }
        
        public static func withComponents<Content: View>(builder: OceanSwiftUI.CarouselWithComponents<Content>.Builder) -> OceanSwiftUI.CarouselWithComponents<Content> {
            return OceanSwiftUI.CarouselWithComponents<Content>(builder: builder)
        }
    }
}
