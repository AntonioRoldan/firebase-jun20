//
//  MessageFirestore.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 23/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

public class MessageFirestore: MessageManager {
    
    public var discussion: Discussion
    var ref: CollectionReference
    
    public required init(discussion: Discussion) {
        self.discussion = discussion
        self.ref = Firestore.firestore().collection(self.discussion.uid)
    }
    
    public func list(onSuccess: @escaping ([Message]) -> Void, onError: ErrorClosure?) {
        
        self.ref.order(by: "sentDate").addSnapshotListener { (snapshot, error) in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            if let snap = snapshot {
                let message = snap.documents
                    .compactMap({ Message.mapperFirestore(json: $0) })
                
                onSuccess(message)
            }
            
        }
        
    }
    
    public func add(message: Message, onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        
        let child = Message.toDict(message: message)
        
        self.ref.addDocument(data: child) { (error) in
            if let err = error, let retError = onError {
                retError(err)
            }
            onSuccess()
        }
        
    }
    
    
}
