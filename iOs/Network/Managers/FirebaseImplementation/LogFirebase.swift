//
//  LogFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 26/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import Firebase

public class LogFirebase: LogManager {
    
    public func log(event: Event) {
        Analytics.setScreenName(event.screen, screenClass: event.type)
        Analytics.logEvent(event.name, parameters: event.parameters as? [String:Any])
    }
    
}
