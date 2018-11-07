//
//  LoginVC.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxtField: insetTextField!
    
    @IBOutlet weak var passwordTxtField: insetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    @IBAction func signInButtonWasPressed(_ sender: Any) {
        
        if emailTxtField.text != nil  && passwordTxtField.text != nil{
            AuthService.instannce.loginUser(userEmail: emailTxtField.text!, password: passwordTxtField.text!) { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    return
                } else {
                    print(String(describing:loginError?.localizedDescription))
                }
                
                AuthService.instannce.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!) { (success, registrationError) in
                    if success {
                        AuthService.instannce.loginUser(userEmail: self.emailTxtField.text!, password: self.passwordTxtField.text!, userLoginComptite: { (success, nil)  in
                            print("successfully register user")
                        })
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                        print(String(describing:registrationError?.localizedDescription))
                    }
                }
                
            }
            
            
            
        }
    }
    
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
    }
    
}
extension LoginVC: UITextFieldDelegate{
    
}
