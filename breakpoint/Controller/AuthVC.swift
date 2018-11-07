//
//  AuthVC.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func googleSignInWasPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var facebookSignInWasPressed: UIButton!
    
}


