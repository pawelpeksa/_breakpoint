//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {
    
    var groupsArray = [Group]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Dataservice.instance.REF_GROUPS.observe(.value) { (snapshot) in
            Dataservice.instance.getAllGroups(handler: { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray
                self.tableView.reloadData()
            })
        }
    }

    func setupView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

extension GroupVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell()}
        
        let group = groupsArray[indexPath.row]
        cell.configureCell(groupTitle: group._groupTitle, groupDescription: group._groupDescrioption
            , membersCount: group._members.count)
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else {
            return
        }
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        presentDetail(groupFeedVC)
    }
}

