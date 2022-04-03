//
//  Sample.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import Foundation

struct SampleItem {
    
    let title: String

    static func createItems() -> [SampleItem] {
        
        let items = [
            SampleItem(title: "日本"),
            SampleItem(title: "アメリカ"),
            SampleItem(title: "ロシア"),
            SampleItem(title: "中国"),
            SampleItem(title: "韓国")
        ]
        
        return items
    }
}
