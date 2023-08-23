//
//  OceanSwiftUI+ButtonBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 23/08/23.
//

import OceanTokens

extension OceanSwiftUI.Button {
    public static func primarySM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primary
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func primaryMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primary
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func primaryLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primary
            button.parameters.size = .large
            builder(button)
        }
    }

    public static func secondarySM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondary
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func secondaryMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondary
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func secondaryLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondary
            button.parameters.size = .large
            builder(button)
        }
    }

    public static func textSM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .text
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func textMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .text
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func textLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .text
            button.parameters.size = .large
            builder(button)
        }
    }

    public static func primaryCriticalSM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryCritical
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func primaryCriticalMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryCritical
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func primaryCriticalLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryCritical
            button.parameters.size = .large
            builder(button)
        }
    }

    public static func secondaryCriticalSM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryCritical
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func secondaryCriticalMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryCritical
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func secondaryCriticalLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .secondaryCritical
            button.parameters.size = .large
            builder(button)
        }
    }

    public static func textCriticalSM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .textCritical
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func textCriticalMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .textCritical
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func textCriticalLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .textCritical
            button.parameters.size = .large
            builder(button)
        }
    }

    public static func primaryInverseSM(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryInverse
            button.parameters.size = .small
            builder(button)
        }
    }

    public static func primaryInverseMD(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryInverse
            button.parameters.size = .medium
            builder(button)
        }
    }

    public static func primaryInverseLG(builder: OceanSwiftUI.Button.Builder) -> OceanSwiftUI.Button {
        return OceanSwiftUI.Button { button in
            button.parameters.style = .primaryInverse
            button.parameters.size = .large
            builder(button)
        }
    }
}
