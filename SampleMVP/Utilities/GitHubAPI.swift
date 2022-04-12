//
//  GitHubAPI.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/10.
//

import Foundation

protocol GitHubAPIProtocol: AnyObject {
    
    func get(searchText: String, complition: ((Result<[GitHubModel], Error>) -> Void)?)
}

final class GitHubAPI: GitHubAPIProtocol {
    
    static let shared = GitHubAPI()
    private init() {}
    
    func get(searchText: String, complition: ((Result<[GitHubModel], Error>) -> Void)? = nil) {
        let apiUrl = URL(string: "https://api.github.com/search/repositories?q=\(searchText)")!
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: apiUrl) { (data, responce, error) in
            if let error = error {
                complition?(.failure(error))
                return
            }
            
            guard
                let data = data,
                let decodeData = try? JSONDecoder().decode(APIResponce.self, from: data) else {
                complition?(.failure(AppError.decodeApi.error))
                return
            }
            
            let gitHubModels = decodeData.items
            complition?(.success(gitHubModels))
        }
        
        task.resume()
    }
}
