//
//  ImageService.swift
//  breakpoint
//
//  Created by Mac on 11/13/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//


import UIKit
import Firebase
import FirebaseStorage

class ImageService{
    
    static let instance = ImageService()
    
    
    
    
    func getProfileImageName()->String {
        return NSUUID().uuidString
    }
    
    
    func uploadData(image:UIImage, handler: @escaping (_ metaDataImgUrl:String) -> ()){
        
        let imageName = getProfileImageName() + ".png"
        let profileImageStorageRef = Storage.storage().reference().child("profileImg").child(imageName)
        
        if  let uploadData = UIImagePNGRepresentation(image){
            profileImageStorageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                profileImageStorageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print("Failed to download url:", error!)
                        return
                    } else {
                        let url = url
                        let imageUrl = url?.path
                        self.addImageNameForLocalUser(imageURL: imageUrl!, imageName: imageName)
                        handler(imageUrl!)
                    }
                })
            }
        }
    }
    
    
    func getUserImageId(uid:String, handler: @escaping (_ userImg:String?) -> ()){
        
        Dataservice.instance.REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if user.key == uid {
                    let imageId = user.childSnapshot(forPath: "photoURL").value as? String
                    handler(imageId)
                }
            }
        }
    }
    
    
    func addImageNameForLocalUser(imageURL:String, imageName:String) {
        
        if let curentUser = Auth.auth().currentUser {
            let changeRequest = curentUser.createProfileChangeRequest()
            changeRequest.photoURL = URL(string: imageURL)
            changeRequest.commitChanges { (error) in
                if let err = error {
                    print("Error setting photoID for user")
                    print(err)
                    return
                }
                
                Dataservice.instance.REF_USERS.child(curentUser.uid).child("photoURL").setValue(imageName)
                
                
                
            }
            
        }
        
    }
    
  
   
}

