//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Mac on 11/9/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var groupTitleLbl: UILabel!
    
    @IBOutlet weak var sendMessageView: UIView!
    
    @IBOutlet weak var messageTxtField: insetTextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    
    var group: Group?
    
    
    func initData(forGroup group:Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageView.bindToKeyBoard()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        groupTitleLbl.text = group?._groupTitle
        
        Dataservice.instance.getEmailForGroup(group: group!) { (returnedArrayEmail) in
            self.membersLbl.text = returnedArrayEmail.joined(separator: ", ")
        }
        
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
    }
    

}
