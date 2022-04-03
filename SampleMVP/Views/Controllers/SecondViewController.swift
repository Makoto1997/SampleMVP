//
//  SecondViewController.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import UIKit

final class SecondViewController: UIViewController {
    
    static func makeFromStoryboard() -> SecondViewController {
        let vc = UIStoryboard.secondViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
