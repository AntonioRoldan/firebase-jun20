//
//  Message.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 28/03/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import MessageKit

public class Message: MessageType {
    
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
    public var type: String
    public var value: String
    
    public init(sender: Sender, messageId: String, sentDate: Date, kind: MessageKind, type: String, value: String){
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.type = type
        self.value = value
    }
    
    convenience init(sender: Sender, kind: MessageKind, type: String, value: String){
        self.init(sender: sender, messageId: UUID().uuidString, sentDate: Date(), kind: kind, type: type, value: value)
    }
    
}

