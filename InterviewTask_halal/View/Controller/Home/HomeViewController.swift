//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by iOS on 6/9/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    // MARK: - Class properties
    
    @IBOutlet weak var tableView: UITableView!
    
    private let apiCalling = APICalling()
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindTableViewData()
    }

    // MARK: Private
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: AccountTableViewCell.resuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func bindTableViewData() {
        let request = APIRequest(urlString: Link.baseURL)
        let result : Observable<[Account]> = self.apiCalling.send(apiRequest: request)
        /// Bind items to table
        _ = result.bind(to: tableView.rx.items(cellIdentifier: AccountTableViewCell.resuseIdentifier, cellType: AccountTableViewCell.self)) { (row, model, cell) in
            cell.viewModel = model
        }.disposed(by: disposeBag)
        
        /// Bind a model selected handler
        _ = tableView.rx.modelSelected(Account.self).bind { account in
            let vc = AccountsViewController.loadFromNib()
            vc.account = account
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }

}

