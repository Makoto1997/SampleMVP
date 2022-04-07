//
//  AppDelegate.swift
//  SampleMVP
//
//  Created by Makoto on 2022/03/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
        
        return true
    }
}

