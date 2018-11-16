//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Lottie
import FirebaseStorage

class FeedVC: UIViewController {
    
    var messageArray = [Message]()
    let defaultProfileImage = UIImage(named: "defaultProfileImage")

    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Dataservice.instance.getAllfeedMessages { (returnedMessagesArray) in
            
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }
}
    


extension FeedVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell ()}
       
        let message = messageArray[indexPath.row]
        
        
        
//

//
//        ImageService.instance.getUserImageId(uid:message.senderId) { (downloadedImgId) in
//
//
//            guard let downloadedImgId = downloadedImgId else { return }
//
////
////            if let imageFromCache = self.imageCache.object(forKey: (downloadedImgId as AnyObject) as! NSString) as? UIImage {
////                self.setImageAndHideSpinner(imageFromCache)
////                return
////            }
//
//            let profileImageRef = Storage.storage().reference().child("profileImg/\(downloadedImgId)")
//            profileImageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
//                if (error != nil) {
//                    print(error as Any)
//                } else {
//
//                    guard let data = data else { return }
//                    guard let image = UIImage(data: data) else { return }
//
////                    self.imageCache.setObject(image, forKey: downloadedImgId as NSString)
//
//                    DispatchQueue.main.async {
//                        cell.profileImage.image = image
//
//                    }
//                }
//            }
//        }
//
        ImageService.instance.getImage(ForUserID: message.senderId) { (image) in
            
            var profileImage:UIImage
            
            if let image = image {
                profileImage = image
            } else {
                profileImage = self.defaultProfileImage!
            }
            
            Dataservice.instance.getUserName(uid: message.senderId) { (returnedUserName) in
                cell.configureCell(profileImage:profileImage , emailLbl: returnedUserName, messageContentLbl: message.content)
            }
            
        }
        
        return cell
    }
    
    
}



