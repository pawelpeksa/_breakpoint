//
//  LoginVC.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class LoginVC: UIViewController{
    
    @IBOutlet weak var emailTxtField: insetTextField!
    
    @IBOutlet weak var passwordTxtField: insetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonWasPressed(_ sender: Any) {
        if self.isInputValid() {
            
            guard let userEmail = self.emailTxtField.text else {
                return
            }
            
            guard let userPassword = self.passwordTxtField.text else {
                return
            }
            
            self.loginAndMaybeRegister(userEmail: userEmail, userPassword: userPassword)
        }
    }
    
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func isInputValid() -> Bool {
        return emailTxtField.text != nil && passwordTxtField.text != nil
    }
    
    private func loginAndMaybeRegister(userEmail:String, userPassword:String) {
        AuthService.instannce.loginUser(userEmail: userEmail, password: userPassword) { [weak self] (success, loginError) in
            if success {
                self?.hideLoginVC()
                return
            } else {
                print(String(describing:loginError?.localizedDescription))
            }
    
            self?.tryToRegister(userEmail:userEmail, userPassword:userPassword)
            
        }
        
    }
    
    private func tryToRegister(userEmail:String, userPassword:String) {
        
        AuthService.instannce.registerUser(withEmail: userEmail, andPassword: userPassword) { [weak self] (success, registrationError) in
            if success {
                AuthService.instannce.loginUser(userEmail: userEmail, password: userPassword, userLoginCompleted: { [weak self](success, nil)  in
                    self?.hideLoginVC()
                    print("successfully register user")
                })
            } else {
                print(String(describing:registrationError?.localizedDescription))
            }
        }
    }
    
    private func hideLoginVC() {
        DispatchQueue.main.async {
             self.dismiss(animated: true, completion: nil)
        }
    }
    
}

