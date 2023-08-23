//
//  Ocean+alert.swift
//  OceanComponents
//
//  Created by Vini on 28/07/21.
//

import Foundation
import OceanTokens

extension Ocean {
    public typealias AlertBoxBuilder = (AlertBox) -> Void
    
    public struct Alert {
        public static func info(builder: AlertBoxBuilder) -> AlertBox {
            return AlertBox { view in
                view.status = .info
                builder(view)
            }
        }
        
        public static func error(builder: AlertBoxBuilder) -> AlertBox {
            return AlertBox { view in
                view.status = .error
                builder(view)
            }
        }
        
        public static func warning(builder: AlertBoxBuilder) -> AlertBox {
            return AlertBox { view in
                view.status = .warning
                builder(view)
            }
        }
        
        public static func success(builder: AlertBoxBuilder) -> AlertBox {
            return AlertBox { view in
                view.status = .success
                builder(view)
            }
        }
    }
}
