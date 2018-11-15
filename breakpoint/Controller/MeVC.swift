//
//  MeVC.swift
//  breakpoint
//
//  Created by Mac on 11/1/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class MeVC: UIViewController {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerSelectProfileImgView)))
        profileImg.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.emailLbl.text = Auth.auth().currentUser?.email
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.masksToBounds = true
        
        showSpinner()

        ImageService.instance.getUserImageId(uid: (Auth.auth().currentUser?.uid)!) { (downloadedImgId) in
            
            
             guard let downloadedImgId = downloadedImgId else { return }
        
            
            if let imageFromCache = self.imageCache.object(forKey: (downloadedImgId as AnyObject) as! NSString) as? UIImage {
                self.setImageAndHideSpinner(imageFromCache)
                return
            }
        
            let profileImageRef = Storage.storage().reference().child("profileImg/\(downloadedImgId)")
            profileImageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                } else {
                    
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }
                    
                    self.imageCache.setObject(image, forKey: downloadedImgId as NSString)
                    
                    DispatchQueue.main.async {
                        self.setImageAndHideSpinner(image)
                    }
                }
            }
        }
    }
    
    func setImageAndHideSpinner(_ image:UIImage) {
        self.profileImg.image = image
        self.hideSpinner()
    }
    
    func showSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
  
    
    @IBAction func signOutBtnWasPressed(_ sender: Any) {
        
        let logOutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to log out? ", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.profileImg.image = UIImage(named: "defaultProfileImage")
                self.present(authVC!, animated: true, completion: nil)
            }catch{
                print(error)
            }
        }
        logOutPopUp.addAction(logoutAction)
        present(logOutPopUp, animated: true, completion: nil)
    }
    
    
}
