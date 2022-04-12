//
//  AppError.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/12.
//

import Foundation

enum AppError: Int {
    
    case decodeApi, emptyApiResponce, getApiData
    
    var domain: String {
        
        switch self {
        case .decodeApi:
            return "デコードできませんでした"
            
        case .emptyApiResponce:
            return "検索結果がありませんでした"
            
        case .getApiData:
            return "値が取得できませんでした"
        }
    }
    
    var error: NSError {
        
        NSError(domain: domain, code: rawValue, userInfo: nil)
    }
}
