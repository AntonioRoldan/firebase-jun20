//
//  Message+Firebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 23/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import MessageKit

extension Message {
    
    public class func mapper(snapshot: DataSnapshot) -> Message? {
        
        guard let json = snapshot.value as? [String:Any] else{
            return nil
        }
        
        let messageId = json["messageId"] as? String ?? ""
        
        let senderId = json["senderId"] as? String ?? ""
        let displayName = json["displayName"] as? String ?? ""
        let sender = Sender.init(id: senderId, displayName: displayName)
        
        let dateString = json["sendDate"] as? String ?? ""
        let sendDate = Date.fromStringToDate(input: dateString, format: "yyyy-MM-dd HH:mm:ss")
        
        let type = json["type"] as? String ?? ""
        let messageData: MessageKind
        
        let value = json["value"] as? String ?? ""
        
        switch type {
        case "text":
            messageData = MessageKind.text(value)
        case "image":
            let placeholder = UIImage.init(named: "diehard")
            let mediaItem = ImageMediaItem.init(image: placeholder!)
            messageData = MessageKind.photo(mediaItem)
        default:
            messageData = MessageKind.text(value)
        }
        
        let message = Message.init(sender: sender, messageId: messageId, sentDate: sendDate, kind: messageData, type: type, value: value)
        
        return message
        
    }
    
    public class func toDict(message: Message) -> [String: String] {
        
        var dict = [String: String]()
        
        dict["senderId"] = message.sender.senderId
        dict["displayName"] = message.sender.displayName
        dict["messageId"] = message.messageId
        dict["sentDate"] = Date.fromDateToString(date: message.sentDate, format: "yyyy-MM-dd HH:mm:ss")
        dict["type"] = message.type
        dict["value"] = message.value
        
        return dict
        
    }
    
}

