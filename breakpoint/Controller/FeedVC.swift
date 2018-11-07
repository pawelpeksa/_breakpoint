//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    var messageArray = [Message]()

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
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        Dataservice.instance.getUserName(uid: message.senderId) { (returnedUserName) in
             cell.configureCell(profileImage: image!, emailLbl: returnedUserName, messageContentLbl: message.content)
        }
        
       
        return cell
    }
    
    
}



