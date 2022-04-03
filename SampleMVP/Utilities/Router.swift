//
//  Router.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import UIKit

final class Router {
    
    static func showRoot(window: UIWindow?) {
        
        let vc = FirstViewController.makeFromStoryboard()
        let presenter = Presenter(output: vc)
        vc.inject(presenter: presenter)
        let rootVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}
