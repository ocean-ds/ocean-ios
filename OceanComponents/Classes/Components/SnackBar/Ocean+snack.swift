//
//  Ocean+snack.swift
//  OceanComponents
//
//  Created by Alex Gomes on 17/08/20.
//

import Foundation
import OceanTokens

extension Ocean {
    public struct View {
        public static func snackbarInfo(builder: SnackbarBuilder) -> Snackbar {
            return Snackbar { view in
                view.iconType = .info
                builder(view)
            }
        }
        
        public static func snackbarError(builder: SnackbarBuilder) -> Snackbar {
            return Snackbar { view in
                view.iconType = .error
                builder(view)
            }
        }
        
        public static func snackbarAlert(builder: SnackbarBuilder) -> Snackbar {
            return Snackbar { view in
                view.iconType = .alert
                builder(view)
            }
        }
        
        public static func snackbarSuccess(builder: SnackbarBuilder) -> Snackbar {
            return Snackbar { view in
                view.iconType = .success
                builder(view)
            }
        }
    }
}
