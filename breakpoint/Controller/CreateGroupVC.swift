//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Mac on 11/7/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {
    
//    var usersArray = [String]()

    @IBOutlet weak var titleTxtField: insetTextField!
    
    
    @IBOutlet weak var descriptionTxtField: insetTextField!
    
    
    @IBOutlet weak var emailSearchTxtField: insetTextField!
    
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

    @IBAction func doneBtnWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func closeBtnWasPressed(_ sender: UIButton) {
    }
}

extension CreateGroupVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else{ return UITableViewCell() }
        
        let profileImg = UIImage(named: "DefaultProfileImage")
        cell.configureCel(profileImage: profileImg!, email: "mailva@gmail.com", isSelected: true)
        return cell
        
    
    }
    
    
}
