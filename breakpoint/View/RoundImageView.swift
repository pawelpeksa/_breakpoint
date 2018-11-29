//
//  RoundImageView.swift
//  breakpoint
//
//  Created by Mac on 11/16/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }

}
