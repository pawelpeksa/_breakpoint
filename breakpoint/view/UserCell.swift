//
//  UserCell.swift
//  breakpoint
//
//  Created by Mac on 11/7/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    func configureCel(profileImage image:UIImage,email:String,isSelected:Bool){
        self.profileImg.image = image
        self.emailLbl.text = email
        if isSelected{
            self.checkImg.isHidden = false
        }else{
            self.checkImg.isHidden = true
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
