//
//  ChatViewController+DataSource.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 28/03/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import MessageKit
import Kingfisher

extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        return user.sender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.messages.count
    }
    
    
    func fetchMessages() {
        
        let manager = MessageInteractor.init(manager: MessageFirebase.init(discussion: self.actualDiscussion)).manager
        
        manager.list(onSuccess: { (messages) in
            self.messages = messages
            self.download(array: messages)
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
        }) { (error) in
            print(error)
        }
        
    }
    
    func download(array: [Message]){
        for(index, message) in array.enumerated(){
            
            switch message.kind {
            case .photo:
                let image = UIImageView()
                
                if message.value == "" {
                    continue
                }
                
                let url = URL.init(string: message.value)!
                image.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, _,_,_) in
                    if let img = image {
                        let mediaItem = ImageMediaItem.init(image: img)
                        message.kind = MessageKind.photo(mediaItem)
                        self.messages[index] = message
                        self.messagesCollectionView.reloadData()
                    }
                }
                
                
                break
            default: break
            }
            
        }
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.messages[indexPath.section]
    }
}
