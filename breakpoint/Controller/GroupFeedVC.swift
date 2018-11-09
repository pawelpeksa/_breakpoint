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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageView.bindToKeyBoard()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
    }
    

}
