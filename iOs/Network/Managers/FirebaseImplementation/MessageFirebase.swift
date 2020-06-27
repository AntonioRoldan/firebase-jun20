//
//  MessageFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 23/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class MessageFirebase: MessageManager {
    
    public var discussion: Discussion
    var ref: DatabaseReference
    
    public required init(discussion: Discussion) {
        self.discussion = discussion
        self.ref = Database.database().reference().child("messages").child(self.discussion.uid)
    }
    
    public func list(onSuccess: @escaping ([Message]) -> Void, onError: ErrorClosure?) {
        
        self.ref.observe(.value) { (snapshot) in
            let messages = snapshot.children
                .compactMap({ Message.mapper(snapshot: $0 as! DataSnapshot) })
                .sorted { (m1, m2) -> Bool in m1.sentDate > m2.sentDate }
            
            onSuccess(messages)
        }
        
    }
    
    public func add(message: Message, onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        
        let child = Message.toDict(message: message)
        
        ref.child(message.messageId).updateChildValues(child) { (error, _) in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            onSuccess()
            
        }
        
    }
    
    
}
