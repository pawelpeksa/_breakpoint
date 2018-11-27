//
//  AuthServise.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    
    static let instannce = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user  else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            Dataservice.instance.createDBUser(uid: user.uid, userData: userData as Dictionary<String, AnyObject>)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(userEmail email :String, password:String, userLoginCompleted: @escaping (_ status:Bool, _ error:Error?) ->()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
          if error != nil{
                userLoginCompleted(false, error)
                return
            }
            userLoginCompleted(true, nil)
        }
        
    }
    
}

