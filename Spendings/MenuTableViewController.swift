//
//  MenuTableViewController.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    struct Storyboard {
        static let menuControllers: [(identifier: String, title: String)] = [
            ("mainController", "Главная"),
            ("resultsController", "Статистика"),
            ("editTypesController", "Редактировать")
        ]
    }
    
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.scrollsToTop = false
        
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRow(at: IndexPath(row: selectedMenuItem, section: 0), animated: false, scrollPosition: .middle)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storyboard.menuControllers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clear
            cell!.textLabel?.textColor = UIColor.UIColorFromRGB(0xCCCCCC)
            let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.UIColorFromRGB(0x333333).withAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = Storyboard.menuControllers[indexPath.row].title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let destViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: Storyboard.menuControllers[indexPath.row].identifier)
        sideMenuController()?.setContentViewController(destViewController)
    }

}
