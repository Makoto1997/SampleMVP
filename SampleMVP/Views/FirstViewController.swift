//
//  FirstViewController.swift
//  SampleMVP
//
//  Created by Makoto on 2022/04/03.
//

import UIKit

final class FirstViewController: UIViewController {
    
    static func makeFromStoryboard() -> FirstViewController {
        let vc = UIStoryboard.firstViewController
        return vc
    }
    
    private let cellNibName = "nibName"
    private let cellIdentifier = "identifier"
    private var outputText = "なにも選択されていません"
    private var presenter: PresenterInput!
    
    @IBOutlet weak private var label: UILabel! {
        didSet {
            
            label.text = outputText
        }
    }
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: PresenterInput) {
        
        self.presenter = presenter
    }
}

extension FirstViewController: PresenterOutput{
    
    func update(text: String) {
        
        label.text = text
    }
}

extension FirstViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else { return UITableViewCell() }
        let item = presenter.item(index: indexPath.row)
        cell.configure(item: item)
        
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter.didSelect(index: indexPath.row)
    }
}
