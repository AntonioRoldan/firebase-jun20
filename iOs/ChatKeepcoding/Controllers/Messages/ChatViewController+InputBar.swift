//
//  ChatViewController+InputBar.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 28/03/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import MessageKit
import InputBarAccessoryView

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        for component in inputBar.inputTextView.components {
            if let text = component as? String {
                
                let kind = MessageKind.text(text)
                
                let message = Message.init(sender: user.sender, kind: kind, type: MessageTypeEnum.text.rawValue, value: text)
                
                let manager = MessageInteractor.init(manager: MessageFirebase.init(discussion: self.actualDiscussion)).manager
                
                manager.add(message: message, onSuccess: {
                    //self.messages.append(message)
                    //self.messagesCollectionView.insertSections([self.messages.count - 1])
                }, onError: { (error) in
                    print(error)
                })
                
            }
        }
        
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom()
    }
    
}
