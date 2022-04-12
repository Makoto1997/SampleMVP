//
//  TableViewCell.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/10.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak private var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
    }
    
    func configure(gitHubModel: GitHubModel) {
        
        label.text = gitHubModel.fullName
    }
}
