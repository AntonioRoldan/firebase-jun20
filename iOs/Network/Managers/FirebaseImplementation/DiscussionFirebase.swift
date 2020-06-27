//
//  DiscussionFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 22/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class DiscussionFirebase: DiscussionManager {
    
    public func list(onSuccess: @escaping ([Discussion]) -> Void, onError: ErrorClosure?) {
        
        let ref = Database.database().reference().child("discussion")
        ref.observe(.value, with: { (snapshot) in
            
            let discussions = snapshot
                .children
                .compactMap({ Discussion.mapper(snapshot: $0 as! DataSnapshot) })
                .sorted(by: { $0.title > $1.title  })
            
            onSuccess(discussions)
            
        }) { (error) in
            if let retError = onError {
                retError(error)
            }
        }
        
        
    }
    
}
