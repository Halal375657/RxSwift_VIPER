//
//  AccountsViewController.swift
//  RxSwiftDemo
//
//  Created by iOS on 13/9/22.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class AccountsViewController: UIViewController {
    
    // MARK: - Public properties -
    var presenter: AccountsPresenterInterface!
    public var account: Account?
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties -
    private let disposeBag = DisposeBag()
    private var dataSource : RxTableViewSectionedReloadDataSource<AccountCellModel>!
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showTransactions()
        configureTableView()
        bindTableViewDataSource()
    }

    // MARK: Private -
    fileprivate func configureTableView() {
        tableView.register(TransactionDetailTableCell.self, forCellReuseIdentifier: TransactionDetailTableCell.reuseIdentifier)
        tableView.register(UINib(nibName: Constants.Nib.accountTableViewCell, bundle: nil), forCellReuseIdentifier: AccountTableViewCell.resuseIdentifier)
    }
    
    fileprivate func bindTableViewDataSource() {
        dataSource = getDataSource()
        presenter
        .transactions?
        .bind(to: tableView.rx.items(dataSource: self.dataSource))
        .disposed(by: disposeBag)
    }
    
    // MARK: - Button action -
    fileprivate func getDataSource() -> RxTableViewSectionedReloadDataSource<AccountCellModel>{
        return RxTableViewSectionedReloadDataSource<AccountCellModel>(
            configureCell: { ( dataSource, tableView, indexPath, item) in
                
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.resuseIdentifier, for: indexPath) as! AccountTableViewCell
                    cell.viewModel = self.presenter.getAccount
                    return cell
                }
                
                let transCell = tableView.dequeueReusableCell(withIdentifier: TransactionDetailTableCell.reuseIdentifier, for: indexPath) as! TransactionDetailTableCell
                transCell.viewModel = item
                return transCell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return sectionIndex == 0 ? "" : dataSource[sectionIndex].header
            }
        )
    }
}

// MARK: - Extensions -

extension AccountsViewController: AccountsViewInterface {
    func showTransactions() {
        presenter.showTransactions()
    }
}

