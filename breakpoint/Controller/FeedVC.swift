//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import FirebaseStorage

class FeedVC: UIViewController {
    
    private var messageArray = [Message]()
    
    private let defaultProfileImage = UIImage(named: "defaultProfileImage")
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Dataservice.instance.getAllfeedMessages { (returnedMessagesArray) in
            
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else {
            return UITableViewCell ()
        }
       
        let message = messageArray[indexPath.row]
        
        ImageService.instance.getImage(ForUserID: message.senderId) { [weak self] (image) in
            
            var profileImage:UIImage
            
            if let image = image {
                profileImage = image
            } else {
                profileImage = (self?.defaultProfileImage)!
            }
            
            Dataservice.instance.getUserName(uid: message.senderId) { (returnedUserName) in
                cell.configureCell(profileImage:profileImage , emailLbl: returnedUserName, messageContentLbl: message.content)
            }
            
        }
        
        return cell
    }
    
    
}



