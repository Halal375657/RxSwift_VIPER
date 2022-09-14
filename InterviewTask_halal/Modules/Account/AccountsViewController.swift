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
    
    // MARK: - Class properties
    
    @IBOutlet weak var tableView: UITableView!
    
    private let apiCalling = APICalling1()
    private let disposeBag = DisposeBag()
    private var dataSource : RxTableViewSectionedReloadDataSource<AccountCellModel>!
    public var account: Account?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindTableViewDataSource()
    }

    // MARK: Private
    
    fileprivate func configureTableView() {
        tableView.register(TransactionDetailTableCell.self, forCellReuseIdentifier: TransactionDetailTableCell.reuseIdentifier)
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: AccountTableViewCell.resuseIdentifier)
    }
    
    fileprivate func bindTableViewDataSource() {
        dataSource = getDataSource()
        let request = APIRequest(urlString: account?.transactions ?? "")
        let result : Observable<[AccountCellModel]> = self.apiCalling.send(apiRequest: request)
        // Bind items to section table view
        result
        .bind(to: tableView.rx.items(dataSource: self.dataSource))
        .disposed(by: disposeBag)
    }
    
    fileprivate func getDataSource() -> RxTableViewSectionedReloadDataSource<AccountCellModel> {
        return RxTableViewSectionedReloadDataSource<AccountCellModel>(
            configureCell: { ( dataSource, tableView, indexPath, item) in
                
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.resuseIdentifier, for: indexPath) as! AccountTableViewCell
                    cell.viewModel = self.account
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
    
    // MARK: - Button Action
}
