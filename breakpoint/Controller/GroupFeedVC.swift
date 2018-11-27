//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Mac on 11/9/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var messageTxtField: insetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    private var group: Group?
    private var groupMessages = [Message]()
    
    func initData(forGroup group:Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        groupTitleLbl.text = group?._groupTitle
        
        Dataservice.instance.getEmailsForGroup(group: group!) { [weak self] (returnedArrayEmail) in
            self?.membersLbl.text = returnedArrayEmail.joined(separator: ", ")
        }
        
        Dataservice.instance.REF_GROUPS.observe(.value) { [weak self] (snapshot) in
            Dataservice.instance.getAllMessagesfor(desiredGroup: (self?.group!)!, handler: { [weak self] (returnedMessageArray) in
                self?.groupMessages = returnedMessageArray
                DispatchQueue.main.async {
                     self?.tableView.reloadData()
                }
    
                if (self?.groupMessages.count)! > 0 {
                    self?.tableView.scrollToRow(at: IndexPath(row: (self?.groupMessages.count)! - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        
        if messageTxtField.text != nil{
            self.disableControls()
            Dataservice.instance.uploadPost(withMessage: messageTxtField.text!, withUnicID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?._key) { (completed) in
                if completed {
                    self.messageTxtField.text = ""
                    self.enableControls()
                }
            }
        }
    }
    
    private func setupView(){
        self.view.bindToKeyBoard()
        self.messageTxtField.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func disableControls(){
        self.sendBtn.isEnabled = false
        self.messageTxtField.isEnabled = false
    }
    
    private func enableControls(){
        self.sendBtn.isEnabled = true
        self.messageTxtField.isEnabled = true
    }
}

extension GroupFeedVC: UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "GroupFeedCellIdentifier")
        guard let cell = reusableCell as? GroupFeedCell else {
            return UITableViewCell()
        }
        let message = groupMessages[indexPath.row]
        Dataservice.instance.getUserName(uid: message.senderId) { (email) in
            cell.configureCell(image:UIImage(named: "defaultProfileImage")! , email: email, content: message.content)
        }
        
        return cell
    }
}


 
