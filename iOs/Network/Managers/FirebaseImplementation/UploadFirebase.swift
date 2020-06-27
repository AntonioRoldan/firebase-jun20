//
//  UploadFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 23/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

public class UploadFirebase: UploadManager {
    
    public func save(name: String, image: UIImage, onSuccess: @escaping (_ url: String) -> Void, onError: ErrorClosure?) {
        
        let ref = Storage.storage().reference().child(name)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.1){
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            metadata.customMetadata = ["user": "John Mcklaine"]

            ref.putData(imageData, metadata: metadata) { (metadata, error) in
                
                if let err = error, let retError = onError {
                    retError(err)
                }
                
                ref.downloadURL { (url, erro) in
                    
                    if let err = error, let retError = onError {
                        retError(err)
                    }
                    
                    onSuccess(url?.absoluteString ?? "")
                    
                }
                
            }
            
        }

        
    }
    
}
