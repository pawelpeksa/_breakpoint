//
//  DataService.swift
//  breakpoint
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

let DB_BASE = Database.database().reference()

class Dataservice{
    static let instance = Dataservice()
    let currentUser = Auth.auth().currentUser?.uid
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    var REF_USERS:DatabaseReference{
        return _REF_USERS
    }
    var REF_GROUPS:DatabaseReference{
        return _REF_GROUPS
    }
    var REF_FEED:DatabaseReference{
        return _REF_FEED
    }

    func getUserName(uid:String, handler: @escaping (_ userName:String) -> ()){
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func createDBUser(uid:String,userData: Dictionary<String,AnyObject>){
        REF_USERS.child(uid).setValue(userData)
    }
    
    func uploadPost(withMessage message:String, withUnicID uid:String, withGroupKey groupKey:String?, sendComplete: @escaping (_ status:Bool)->()){
        
        if groupKey != nil {
           
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message,"senderId":uid] )
            
        } else {
            _REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderId":uid])
        }
        
        sendComplete(true)
    }
    
    func getAllMessagesfor(desiredGroup:Group,handler: @escaping (_ messageArray: [Message]) -> () ){
        
        var groupMessageArray =  [Message]()
        
        REF_GROUPS.child(desiredGroup._key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot]
                else {return}
            for groupMessage in groupMessageSnapshot{
                let groupMessage = self.createMessage(message: groupMessage)
                groupMessageArray.append(groupMessage)
            }
            
            handler(groupMessageArray)
        }
        
    }
    
    func createMessage(message:DataSnapshot) -> Message{
        let content = message.childSnapshot(forPath: "content").value as! String
        let sender = message.childSnapshot(forPath: "senderId").value as! String
        let groupMessage = Message(content: content, senderId: sender)
        return groupMessage
    }
    
    func getAllfeedMessages(handler: @escaping (_ message: [Message]) -> ()){
        
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageShapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for feedMessage in feedMessageShapshot {
                let message = self.createMessage(message: feedMessage)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func getEmail(forSearchQuary quary:String, handler: @escaping (_ emailArray:[String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(quary) == true && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(fromUserName names:[String], handler: @escaping (_ uidArray:[String])->()){
        
        REF_USERS.observe(DataEventType.value) { (userSnapshot) in
            
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if names.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
        
    }
    
    func getEmailsForGroup(group:Group, handler: @escaping (_ emailArray:[String])->()){
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let groupUsers = userSnapshot.filter{ group._members.contains($0.key) }
            let groupEmails = groupUsers.map{ $0.childSnapshot(forPath: "email").value as! String }
            
            handler(groupEmails)
        }
    }
    
    func createGroup(title:String,description:String, usersId:[String], handler: @escaping (_ isgroupCreated: Bool) -> ()){
        REF_GROUPS.childByAutoId().updateChildValues([ "title" : title , "description": description, "members" : usersId])
        handler(true)
    }
    
    
    func getAllGroups(handler:@escaping (_ groupsArray:[Group])->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for group in groupSnapshot {
                
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    
                    
                    let group = Group(title: title, descrioption: description, key: group.key, groupCount: memberArray.count, members: memberArray)
                    
                    groupsArray.append(group)
                    
                }
                
            }
            handler(groupsArray)
            
        }
    }
    

    
    


 }
    
    




