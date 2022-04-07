//
//  Router.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import UIKit

final class Router {
    
    static let shared: Router = .init()
    private init() {}
    
    private (set) var window: UIWindow?
    
    func showRoot(window: UIWindow?) {
        
        let vc = FirstViewController.makeFromStoryboard()
        let presenter = Presenter(output: vc)
        vc.inject(presenter: presenter)
        let rootVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        self.window = window
    }
    
    static func showFirst(from: UIViewController) {
        
        let vc = FirstViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    static func showSecond(from: UIViewController) {
        
        let vc = SecondViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
}

extension Router {
    
    private static func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        
        if let nav = from.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            from.present(next, animated: animated, completion: nil)
        }
    }
}
