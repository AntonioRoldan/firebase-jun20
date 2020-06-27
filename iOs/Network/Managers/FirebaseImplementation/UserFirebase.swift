//
//  UserFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 22/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import FirebaseAuth

public class UserFirebase: UserManager {
    
    public func register(user: User, onSuccess: @escaping (User) -> Void, onError: ErrorClosure?) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password!) { (user, error) in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            if let u = user {
                onSuccess(User.init(id: u.user.uid, email: u.user.email!, password: nil))
            }
            
        }
        
    }
    
    public func login(user: User, onSuccess: @escaping (User) -> Void, onError: ErrorClosure?) {
        
        Auth.auth().signIn(withEmail: user.email, password: user.password!) { (user, error) in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            if let u = user {
                onSuccess(User.init(id: u.user.uid, email: u.user.email!, password: nil))
            }
            
        }
        
    }
    
    public func recoverPassword(user: User, onSuccess: @escaping (User) -> Void, onError: ErrorClosure?) {
        
        Auth.auth().sendPasswordReset(withEmail: user.email) { (error) in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            onSuccess(user)
            
        }
        
    }
    
    public func isLogged(onSuccess: @escaping (User?) -> Void, onError: ErrorClosure?) {
        
        if let user = Auth.auth().currentUser {
            let user = User.init(id: user.uid, email: user.email!, password: nil)
            onSuccess(user)
        }
        
        onSuccess(nil)
        
    }
    
    public func logout(onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let error as NSError {
            print(error.localizedDescription)
            if let retError = onError {
                retError(error)
            }
        }
        
    }
    
    
}
