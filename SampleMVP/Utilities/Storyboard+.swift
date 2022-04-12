//
//  Storyboard+.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/10.
//

import UIKit

extension UIStoryboard {
    
    static var searchViewController: SearchViewController {
        UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
    }
}
