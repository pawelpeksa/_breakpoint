//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Mac on 11/1/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    

    @IBOutlet weak var profileImg: UIImageView!
    
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyBoard()

        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.emailLbl.text = Auth.auth().currentUser?.email
        
        ImageService.instance.getImage(ForUserID: (Auth.auth().currentUser?.uid)!) { (image) in
            if let image = image {
                self.profileImg.image = image
            }
        }
    }

    @IBAction func sendBtnWasPressed(_ sender: Any) {
        
        if textView.text != nil && textView.text != "Say somethink here"{
            sendBtn.isEnabled = false
            Dataservice.instance.uploadPost(withMessage: textView.text, withUnicID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("There was an error!")
                }
            }
        }
       
    }
    
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
     dismiss(animated: true, completion: nil)
    }
    

}

extension CreatePostVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
