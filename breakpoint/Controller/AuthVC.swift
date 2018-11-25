//
//  AuthVC.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthVC: UIViewController, GIDSignInUIDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil{
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func emailSignInWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInWasPressed(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    
    }
    
    @IBOutlet weak var facebookSignInWasPressed: UIButton!
    
    func setupView(){
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
}

//creating the Google sign in button


