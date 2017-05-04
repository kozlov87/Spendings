//
//  AppDelegate.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate struct Constants {
        static let firstRunKey = "firstLaunch"
    }

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor.UIColorFromRGB(0x333333)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0x7F7F7F)]
        UINavigationBar.appearance().tintColor = UIColor.UIColorFromRGB(0x7F7F7F)
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Constants.firstRunKey) == nil {
            SpendingType.setDatabase()
            defaults.set(true, forKey: Constants.firstRunKey)
        }
        application.statusBarStyle = .lightContent
        return true
    }
}

extension UIColor {
    static func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

