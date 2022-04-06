//
//  TableViewCell.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak private var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure(item: SampleItem) {
        
        label.text = item.title
    }
}
