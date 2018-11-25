//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Mac on 11/7/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController, UITextFieldDelegate {
    
    private var emailArray = [String]()
    private var choosenUsersArray = [String]()
    
    @IBOutlet weak var titleTxtField: insetTextField!
    @IBOutlet weak var descriptionTxtField: insetTextField!
    @IBOutlet weak var emailSearchTxtField: insetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        doneBtn.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc func textFieldDidChange(){
        if emailSearchTxtField.text == "" {
            emailArray = []
            tableView.reloadData()
        }else{
            Dataservice.instance.getEmail(forSearchQuary: emailSearchTxtField.text!) { [weak self] (returnedEmailArray) in
                self?.emailArray = returnedEmailArray
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func doneBtnWasPressed(_ sender: UIButton) {
        if isGroupInfoValid(){
            Dataservice.instance.getIds(fromUserName: choosenUsersArray) { [weak self] (idsArray) in
                var usersId = idsArray
                usersId.append((Auth.auth().currentUser?.uid)!)
                self?.createGroup(usersId: usersId)
            }
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.emailSearchTxtField.delegate = self
        self.emailSearchTxtField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func isGroupInfoValid() -> Bool{
        return titleTxtField.text != "" && descriptionTxtField.text != ""
    }
}

extension CreateGroupVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else{ return UITableViewCell() }
        
        let profileImg = UIImage(named: "defaultProfileImage")
        
        if choosenUsersArray.contains(emailArray[indexPath.row]){
            cell.configureCel(profileImage: profileImg!, email: emailArray[indexPath.row], isSelected: true) }else{
            cell.configureCel(profileImage: profileImg!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at:indexPath) as? UserCell else{return}
        if !choosenUsersArray.contains(cell.emailLbl.text!){
            choosenUsersArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = choosenUsersArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else{
            choosenUsersArray = choosenUsersArray.filter({ $0 != cell.emailLbl.text! })
            if choosenUsersArray.count < 1 {
                groupMemberLbl.text = "add people to Your Group"
                doneBtn.isHidden = true
            }
        }
    }
    
    private func createGroup(usersId:[String]){
        Dataservice.instance.createGroup(title: self.titleTxtField.text!, description: self.descriptionTxtField.text!, usersId: usersId) { [weak self] (groupCreated) in
            if groupCreated {
                self?.dismiss(animated: true, completion: nil)
            }else{
                print("Group could not be created")
            }
        }
    }
    
}

