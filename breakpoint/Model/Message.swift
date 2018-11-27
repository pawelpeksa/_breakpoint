//
//  Message.swift
//  breakpoint
//
//  Created by Mac on 11/7/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation


struct Message{
    
    private var _content: String
    private var _senderId:String
    
    var content: String {
        return _content
    }
    
    var senderId: String{
        return _senderId
    }
    
    init(content:String,senderId:String) {
        self._content = content
        self._senderId = senderId
    }
}
