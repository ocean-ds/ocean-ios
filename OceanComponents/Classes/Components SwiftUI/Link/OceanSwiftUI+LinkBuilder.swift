//
//  OceanSwiftUI+LinkBuilder.swift
//  Charts
//
//  Created by Acassio Mendonça on 03/10/23.
//

import OceanTokens

extension OceanSwiftUI.Link {
    public static func primaryMedium(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .primary
            link.parameters.size = .medium
            buider?(link)
        }
    }
    
    public static func primarySmall(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .primary
            link.parameters.size = .small
            buider?(link)
        }
    }
    
    public static func primaryTiny(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .primary
            link.parameters.size = .tiny
            buider?(link)
        }
    }
    
    public static func inverseMedium(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .inverse
            buider?(link)
        }
    }
    
    public static func inverseSmall(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .inverse
            link.parameters.size = .small
            buider?(link)
        }
    }
    
    public static func inverseTiny(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .inverse
            link.parameters.size = .tiny
            buider?(link)
        }
    }
    
    public static func neutralMedium(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .neutral
            buider?(link)
        }
    }
    
    public static func neutralSmall(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .neutral
            link.parameters.size = .small
            buider?(link)
        }
    }
    
    public static func neutralTiny(buider: OceanSwiftUI.Link.Builder? = nil) -> OceanSwiftUI.Link {
        return OceanSwiftUI.Link { link in
            link.parameters.style = .neutral
            link.parameters.size = .tiny
            buider?(link)
        }
    }
}
