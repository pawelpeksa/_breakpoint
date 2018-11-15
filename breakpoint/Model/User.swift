//
//  File.swift
//  breakpoint
//
//  Created by Mac on 11/10/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit

struct User {
    
    public private (set) var userKey : String?
    public private (set) var email : String?
    public private (set) var profileImg : String?
    
    
    init(userKey:String, email:String, profileImg:String){
        self.userKey = userKey
        self.email = email
        self.profileImg = profileImg
    }

}
