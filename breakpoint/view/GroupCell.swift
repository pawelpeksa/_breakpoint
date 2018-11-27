//
//  GroupCell.swift
//  breakpoint
//
//  Created by Mac on 11/8/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupTitle: UILabel!
    
    @IBOutlet weak var membersLbl: UILabel!
    
    @IBOutlet weak var groupDescription: UILabel!
    
    func configureCell(groupTitle:String,groupDescription:String,membersCount:Int){
        self.groupTitle.text = groupTitle
        self.groupDescription.text = groupDescription
        self.membersLbl.text = "\(membersCount) members"
    }
}
