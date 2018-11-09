//
//  Group.swift
//  breakpoint
//
//  Created by Mac on 11/8/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

class Group{
    
    public private (set) var _groupTitle:String
    public private (set) var _groupDescrioption:String
    public private (set) var _key:String
    public private (set) var _groupCount:Int
    public private (set) var _members:[String]
    
//    var groupTitle:String{
//        return _groupTitle
//    }
//    var groupDescrioption:String{
//        return _groupDescrioption
//    }
//    var key:String{
//        return _key
//    }
//
//    var groupCount:Int{
//        return _groupCount
//    }
//    var members:[String]{
//        return _members
//    }
    
    
    init(title:String, descrioption:String,key: String, groupCount:Int,members:[String]){
     self._groupTitle = title
        self._groupDescrioption = descrioption
        self._key = key
        self._groupCount = groupCount
        self._members = members
    }
    
    
    
    
}


