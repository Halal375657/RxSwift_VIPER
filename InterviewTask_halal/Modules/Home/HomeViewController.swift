//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by iOS on 6/9/22.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    // MARK: - Public properties -
    var presenter: HomePresenterInterface!
    
    // MARK: - Private properties -
    @IBOutlet private weak var tableView: UITableView!
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewTap()
        presenter.showAccounts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTableView()
        setupTableViewCell()
    }

    // MARK: Private -
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: AccountTableViewCell.resuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func setupTableViewCell() {
        tableView.delegate = nil
        tableView.dataSource = nil

        presenter.accounts.bind(onNext: { (accounts) in
            self.showAccounts()
        }).disposed(by: disposeBag)

        presenter.accounts.bind(to: tableView
            .rx
            .items(cellIdentifier: AccountTableViewCell.resuseIdentifier, cellType: AccountTableViewCell.self)) {
                (row, model, cell) in
                cell.viewModel = model
        }
        .disposed(by: disposeBag)
    }
    
    func setupTableViewTap() {
        tableView.rx
            .modelSelected(Account.self)
            .subscribe ({ [unowned self] (account) in
                let index = self.presenter.accounts.value[self.tableView.indexPathForSelectedRow?.item ?? 0]
                //self.showUser(index: index!)
                
                let vc = AccountsViewController.loadFromNib()
                vc.account = index
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }

}

// MARK: - Extensions -
extension HomeViewController: HomeViewInterface {
    func showAccounts() {
        self.tableView.reloadData()
    }
}

