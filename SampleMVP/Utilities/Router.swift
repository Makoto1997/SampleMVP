//
//  Router.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/08.
//

import UIKit
import SafariServices

final class Router {
    
    static func showRoot(window: UIWindow) {
        let vc = UIStoryboard.searchViewController
        let presenter = SearchPresenter(output: vc)
        // ここでPresenterと繋げる
        // PresenterとVCが参照しあうのでどちらかをweakにしないといけない
        vc.inject(input: presenter)
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    static func showWeb(url: URL, from: UIViewController) {
        
        let safariVC = SFSafariViewController(url: url)
        from.present(safariVC, animated: true, completion: nil)
    }
}
