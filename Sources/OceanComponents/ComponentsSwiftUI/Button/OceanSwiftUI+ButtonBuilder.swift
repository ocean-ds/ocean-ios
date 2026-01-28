//
//  OceanSwiftUI+ButtonBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 23/08/23.
//

import OceanTokens

extension OceanSwiftUI.Button {
    public static func primarySM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primary
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func primaryMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primary
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func primaryLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primary
            button.parameters.size = .large
            builder?(button)
        }
    }

    public static func secondarySM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondary
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func secondaryMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondary
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func secondaryLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondary
            button.parameters.size = .large
            builder?(button)
        }
    }

    public static func tertiarySM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiary
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func tertiaryMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiary
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func tertiaryLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiary
            button.parameters.size = .large
            builder?(button)
        }
    }

    public static func primaryCriticalSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryCritical
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func primaryCriticalMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryCritical
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func primaryCriticalLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryCritical
            button.parameters.size = .large
            builder?(button)
        }
    }

    public static func secondaryCriticalSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryCritical
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func secondaryCriticalMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryCritical
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func secondaryCriticalLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryCritical
            button.parameters.size = .large
            builder?(button)
        }
    }

    public static func tertiaryCriticalSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiaryCritical
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func tertiaryCriticalMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiaryCritical
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func tertiaryCriticalLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiaryCritical
            button.parameters.size = .large
            builder?(button)
        }
    }

    public static func primaryInverseSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryInverse
            button.parameters.size = .small
            builder?(button)
        }
    }

    public static func primaryInverseMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryInverse
            button.parameters.size = .medium
            builder?(button)
        }
    }

    public static func primaryInverseLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryInverse
            button.parameters.size = .large
            builder?(button)
        }
    }
    
    public static func primaryWarningSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryWarning
            button.parameters.size = .small
            builder?(button)
        }
    }
    
    public static func primaryWarningMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryWarning
            button.parameters.size = .medium
            builder?(button)
        }
    }
    
    public static func primaryWarningLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryWarning
            button.parameters.size = .large
            builder?(button)
        }
    }
    
    public static func secondaryWarningSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryWarning
            button.parameters.size = .small
            builder?(button)
        }
    }
    
    public static func secondaryWarningMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryWarning
            button.parameters.size = .medium
            builder?(button)
        }
    }
    
    public static func secondaryWarningLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryWarning
            button.parameters.size = .large
            builder?(button)
        }
    }
    
    public static func tertiaryWarningSM(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiaryWarning
            button.parameters.size = .small
            builder?(button)
        }
    }
    
    public static func tertiaryWarningMD(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiaryWarning
            button.parameters.size = .medium
            builder?(button)
        }
    }
    
    public static func tertiaryWarningLG(builder: OceanSwiftUI.Button.Builder? = nil) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .tertiaryWarning
            button.parameters.size = .large
            builder?(button)
        }
    }
}
