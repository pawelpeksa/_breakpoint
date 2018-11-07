//
//  MeVC.swift
//  breakpoint
//
//  Created by Mac on 11/1/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func signOutBtnWasPressed(_ sender: Any) {
        
        let logOutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to log out? ", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            
            do{
            try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            }catch{
                print(error)
            }
        }
        logOutPopUp.addAction(logoutAction)
        present(logOutPopUp, animated: true, completion: nil)
    }
    

}
