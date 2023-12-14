//
//  OceanSwiftUI+AlertBuilder.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 02/10/23.
//

import OceanTokens

extension OceanSwiftUI.Alert {
    public static func info(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .info
            alert.parameters.style = .none
            builder?(alert)
        }
    }
    
    public static func infoLong(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .info
            alert.parameters.style = .longDescription
            builder?(alert)
        }
    }
    
    public static func infoShort(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .info
            alert.parameters.style = .shortDescription
            builder?(alert)
        }
    }
    
    public static func positive(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .positive
            alert.parameters.style = .none
            builder?(alert)
        }
    }
    
    public static func positiveLong(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .positive
            alert.parameters.style = .longDescription
            builder?(alert)
        }
    }
    
    public static func positiveShort(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .positive
            alert.parameters.style = .shortDescription
            builder?(alert)
        }
    }
    
    public static func warning(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .warning
            alert.parameters.style = .none
            builder?(alert)
        }
    }
    
    public static func warningLong(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .warning
            alert.parameters.style = .longDescription
            builder?(alert)
        }
    }
    
    public static func warningShort(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .warning
            alert.parameters.style = .shortDescription
            builder?(alert)
        }
    }
    
    public static func negative(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .negative
            alert.parameters.style = .none
            builder?(alert)
        }
    }
    
    public static func negativeLong(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .negative
            alert.parameters.style = .longDescription
            builder?(alert)
        }
    }
    
    public static func negativeShort(builder: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .negative
            alert.parameters.style = .shortDescription
            builder?(alert)
        }
    }
}
