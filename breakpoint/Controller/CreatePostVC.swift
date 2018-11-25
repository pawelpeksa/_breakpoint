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
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.configureView()
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        
        if self.isTextValid() {
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
    
    private func setupView(){
        self.textView.delegate = self
        self.sendBtn.bindToKeyBoard()
    }
    
    private func configureView(){
        self.emailLbl.text = Auth.auth().currentUser?.email
        
        ImageService.instance.getImage(ForUserID: (Auth.auth().currentUser?.uid)!) { (image) in
            if let image = image {
                self.profileImg.image = image
            }
        }
    }
    
    private func isTextValid() -> Bool{
        return textView.text != nil && textView.text != "Say somethink here"
    }
}

extension CreatePostVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
