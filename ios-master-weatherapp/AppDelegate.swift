//
//  AppDelegate.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 18/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let targetVC = HomeViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: targetVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

