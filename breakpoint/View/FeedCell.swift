//
//  FeedCell.swift
//  breakpoint
//
//  Created by Mac on 11/1/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageContentLbl: UILabel!

    func configureCell(profileImage:UIImage,emailLbl:String,messageContentLbl:String) {
        self.profileImage.image = profileImage
        self.emailLbl.text = emailLbl
        self.messageContentLbl.text = messageContentLbl
    }

}
