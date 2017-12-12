//
//  ViewController.swift
//  TestData
//
//  Created by Krzysztof Biskupski on 11.12.2017.
//  Copyright © 2017 pl.naosoft. All rights reserved.
//

import UIKit
import Reachability
//MARK: Controller
class ViewController: UIViewController {
    @IBOutlet var currentTableView: UITableView?
    var currentUsersList = [TDUser]()
    var favouriteUserList = [TDUser]()
    var mainUserList = [TDUser]()
    var isFavouriteMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTableView!.register(UINib(nibName: "TDUserTableViewCell", bundle: nil), forCellReuseIdentifier: "TDUserTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       let reachability = Reachability()!
       if reachability.connection != .none {
            TDManagerRepository.instante.userRepository.fetchUsersList { (usersList) in
                self.currentUsersList = usersList
                self.mainUserList = usersList;
                self.currentTableView?.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func switchListView(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
           switchList(listType: 0)
            break;
        case 1:
            switchList(listType: 1)
            break
        default:
            break
        }
    }
    
    func switchList(listType: Int) {
        currentUsersList.removeAll();
        if listType == 0 {
            isFavouriteMode = false
            currentUsersList = mainUserList
        }
        else if listType == 1 {
            isFavouriteMode = true
             currentUsersList = favouriteUserList
        }
        currentTableView?.reloadData()
    }
}
//MARK: TabelView
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TDUserTableViewCell", for: indexPath) as! TDUserTableViewCell
        let userData = self.currentUsersList[indexPath.row]
        cell.propagerDataOnView(userData: userData, isFavouriteMode: isFavouriteMode)
        cell.finishSelectionAction = {(userData) -> Void in
            self.favouriteManager(selecdedUser: userData)
        }
        return cell
    }
}
//MARK: Favourite
extension ViewController {
    func favouriteManager(selecdedUser:TDUser?)  {
        if elementExist(element: selecdedUser!) {
            if isFavouriteMode {
                if let index = favouriteUserList.index(where: {$0.email == selecdedUser?.email}) {
                    favouriteUserList.remove(at: index)
                    currentUsersList = favouriteUserList
                    currentTableView?.reloadData()
                }
            }
        }
        else {
            favouriteUserList.append(selecdedUser!)
        }
    }
    
    func elementExist(element:TDUser) -> Bool {
        let test =  favouriteUserList.filter { (item) -> Bool in
            return element.email == item.email
        }
        if test.count > 0  {
            return true
        }
        else {
            return false
        }
    }
}

