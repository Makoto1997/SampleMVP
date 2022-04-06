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
    
    @IBOutlet weak private var label: UILabel!
    //ここでPresenterとViewControllerを繋げる
    private var presenter: PresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: PresenterInput) {
        
        self.presenter = presenter
    }
}

extension SecondViewController: PresenterOutput {
    
    func update(text: String) {
        
        label.text = text
    }
}
