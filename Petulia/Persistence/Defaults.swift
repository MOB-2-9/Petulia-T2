//
//  Defaults.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseAuth

struct Defaults {
    private enum Keys {
        static let onboard = "onboard"
        static let currentUser = "currentUser"
    }
    
    //MARK: Methods
    
    ///use after logging out
    static func removeUser(_ removeFromUserDefaults: Bool = false) {
        if removeFromUserDefaults {
            //clear everything in UserDefaults except for onboard
            UserDefaults.standard.deleteAllKeys(exemptedKeys: [Keys.onboard])
        }
    }
}
