//
//  ActivityIndicatorView+.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/12.
//

import UIKit

extension UIActivityIndicatorView {
    
    func animation(isStart: Bool) {
        
        DispatchQueue.main.async {
            if isStart {
                self.startAnimating()
                
            }else {
                self.stopAnimating()
            }
        }
    }
}
