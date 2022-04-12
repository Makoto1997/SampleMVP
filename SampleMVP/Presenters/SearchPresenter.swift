//
//  SearchPresenter.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import Foundation

// PresenterはInput・outputする相手は知らない
// ModelやUtility(API)に依存している
// Controllerにも依存してるが、protocolなので依存度は弱い状態である
// ここで行うのは単純な処理のみ
// 入力に関するプロトコル
// VCから送られてくる
protocol SearchPresenterInput {
    
    var numberOfItems: Int { get }
    func item(index: Int) -> GitHubModel
    func search(param: String?)
    func didSelect(index: Int)
}

// 出力に関するプロトコル
// VCに結果を渡す
protocol SearchPresenterOutput: AnyObject {
    
    func update(loading: Bool)
    func update(gitHubModels: [GitHubModel])
    func validation(error: ParameterValidationError)
    func get(error: Error)
    func showWeb(url: URL)
}

final class SearchPresenter {
    // VCとPresenterが参照し合い循環参照が起きるためweakキーワードを付ける
    private weak var output: SearchPresenterOutput! // VCのこと
    private var api: GitHubAPIProtocol!
    // 状態をここで保持する
    private var gitHubModels: [GitHubModel]
    
    init(output: SearchPresenterOutput, api: GitHubAPIProtocol = GitHubAPI.shared) {
        // このoutputがVCのこと
        self.output = output
        self.api = api
        self.gitHubModels = []
    }
}

// Presenterはinputのプロトコルに準拠する
extension SearchPresenter: SearchPresenterInput {
    
    var numberOfItems: Int {
        gitHubModels.count
    }
    
    func item(index: Int) -> GitHubModel {
        
        gitHubModels[index]
    }
    
    func search(param: String?) {
        
        if let validationError = ParameterValidationError(param: param) {
            output.validation(error: validationError)
            return
        }
        
        guard let searchText = param else { return }
        
        // output(VC側に何をするかを任せる)
        output.update(loading: true)
        // PresenterではAPIを叩くだけ
        self.api.get(searchText: searchText) { [weak self] (result) in
            
            guard let self = self else{ return }
            switch result {
            case .success(let gitHubModels):
                self.output.update(loading: false)
                if gitHubModels.isEmpty {
                    self.output.get(error: AppError.emptyApiResponce.error)
                    return
                }
                // ここでModelを取得(状態保持)
                self.gitHubModels = gitHubModels
                // output(VC側に任せる)
                self.output.update(gitHubModels: gitHubModels)
            case .failure(let error):
                self.output.update(loading: false)
                // output(VC側に任せる)
                self.output.get(error: error)
            }
        }
    }
    
    func didSelect(index: Int) {
        
        guard let gitHubUrl = URL(string: gitHubModels[index].urlStr) else {
            output.get(error: AppError.getApiData.error)
            return
        }
        output.showWeb(url: gitHubUrl)
    }
}
