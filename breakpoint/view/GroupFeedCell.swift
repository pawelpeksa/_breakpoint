//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by Mac on 11/9/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(image:UIImage,email: String, content:String){
        self.profileImg.image = image
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
}
