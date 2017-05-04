//
//  RootViewController.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit

class RootNavigationController: ENSideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MenuTableViewController(), menuPosition:.left)
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        view.bringSubview(toFront: navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
