//
//  AppDelegate.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 10/1/21.
//

import UIKit


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tbc = WidgetsViewController()
        let vc = ListViewController()
        tbc.content = [vc]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tbc
        self.window?.makeKeyAndVisible()
        return true
    }
}

