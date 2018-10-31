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
    
    
    func registerUser(userEmail email :String, password:String, userCreationComplete: @escaping (_ status:Bool, _ error:Error?) ->()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else{
               userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user.user.providerID, "email": user.user.email]
            Dataservice.instance.createDBUser(uid: user.user.uid, userData: userData as Dictionary<String, AnyObject>)
        }
    }
    
    func loginUser(userEmail email :String, password:String, userLoginComptite: @escaping (_ status:Bool, _ error:Error?) ->()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
          if error != nil{
                userLoginComptite(false,error)
                return
            }
            userLoginComptite(true,nil)
        }
        
    }
}

