//
//  ShadowView.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView(){
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}

