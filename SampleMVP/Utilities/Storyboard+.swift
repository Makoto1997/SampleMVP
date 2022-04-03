//
//  Storyboard+.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import UIKit

extension UIStoryboard {
    
    static var firstViewController: FirstViewController {
        UIStoryboard.init(name: "First", bundle: nil).instantiateInitialViewController() as! FirstViewController
    }
    
    static var secondViewController: SecondViewController {
        UIStoryboard.init(name: "Second", bundle: nil).instantiateInitialViewController() as! SecondViewController
    }
}
