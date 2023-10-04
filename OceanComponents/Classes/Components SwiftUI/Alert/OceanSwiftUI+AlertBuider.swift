//
//  OceanSwiftUI+AlertBuider.swift
//  Charts
//
//  Created by Acassio Mendonça on 02/10/23.
//

import OceanTokens

extension OceanSwiftUI.Alert {
    public static func info(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .info
            alert.parameters.style = .none
            buider?(alert)
        }
    }
    
    public static func infoLong(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .info
            alert.parameters.style = .longDescription
            buider?(alert)
        }
    }
    
    public static func infoShort(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .info
            alert.parameters.style = .shortDescription
            buider?(alert)
        }
    }
    
    public static func positive(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .positive
            alert.parameters.style = .none
            buider?(alert)
        }
    }
    
    public static func positiveLong(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .positive
            alert.parameters.style = .longDescription
            buider?(alert)
        }
    }
    
    public static func positiveShort(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .positive
            alert.parameters.style = .shortDescription
            buider?(alert)
        }
    }
    
    public static func warning(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .warning
            alert.parameters.style = .none
            buider?(alert)
        }
    }
    
    public static func warningLong(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .warning
            alert.parameters.style = .longDescription
            buider?(alert)
        }
    }
    
    public static func warningShort(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .warning
            alert.parameters.style = .shortDescription
            buider?(alert)
        }
    }
    
    public static func negative(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .negative
            alert.parameters.style = .none
            buider?(alert)
        }
    }
    
    public static func negativeLong(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .negative
            alert.parameters.style = .longDescription
            buider?(alert)
        }
    }
    
    public static func negativeShort(buider: OceanSwiftUI.Alert.Builder? = nil) -> OceanSwiftUI.Alert {
        return OceanSwiftUI.Alert { alert in
            alert.parameters.status = .negative
            alert.parameters.style = .shortDescription
            buider?(alert)
        }
    }
}
