//
//  AppDelegate.swift
//  GitCrop
//
//  Created by dev dfcc on 7/29/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = FrameSelectViewController()
        let navitaionController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navitaionController
        window?.makeKeyAndVisible()
        return true
    }



}

