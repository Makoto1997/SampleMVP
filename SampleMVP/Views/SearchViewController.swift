//
//  SearchViewController.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/08.
//
// Viewに関すること以外書かない
// ifやforといった制御が入ることはないはず
import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    private var searchBar = UISearchBar()
    // VCのインスタンス作成後にPresenterInputProtocolに準拠するもの(ここではSearchPresenterを登録)
    private var input: SearchPresenterInput!
    func inject(input: SearchPresenterInput) {
        // このinputがpresenterのこと
        self.input = input
    }
    
    // 理想としてはこのようにinitを持ちたいが、インスタンスを作るときにどっちも欲しがる形になってしまうのでinjectメソッドを用意している
    //    init(presenter: SearchPresenter) {
    //        self.input = presenter
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // presenterにAPI通信を任せる
        input.search(param: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return input.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        // i番目のModelをpresenterから貰うように問い合わせている
        let gitHubModel = input.item(index: indexPath.item)
        cell.configure(gitHubModel: gitHubModel)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 何番目のセルがタップされたかをpresenterに伝える
        input.didSelect(index: indexPath.row)
    }
}

extension SearchViewController: SearchPresenterOutput {
    
    func update(loading: Bool) {
        
        indicator.animation(isStart: loading)
    }
    
    func update(gitHubModels: [GitHubModel]) {
        
        DispatchQueue.main.async {
            self.searchBar.text = ""
            self.searchBar.resignFirstResponder()
            self.tableView.reloadData()
        }
    }
    
    func validation(error: ParameterValidationError) {
        
        Alert.okAlert(vc: self, title: error.message, message: "")
    }
    
    func get(error: Error) {
        
        Alert.okAlert(vc: self, title: error.localizedDescription, message: "")
    }
    
    func showWeb(url: URL) {
        
        Router.showWeb(url: url, from: self)
    }
}
