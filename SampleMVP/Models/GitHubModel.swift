//
//  GitHubModel.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/08.
//

import Foundation

struct GitHubModel: Codable {
    
    let fullName: String
    var urlStr: String { "https://github.com/\(fullName)" }
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}

struct APIResponce: Codable {
    
    let items: [GitHubModel]
}
