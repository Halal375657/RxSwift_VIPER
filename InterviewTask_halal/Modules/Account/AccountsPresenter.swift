//
//  AccountsPresenter.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import RxSwift
import RxCocoa
import RxDataSources

final class AccountsPresenter {
    
    // MARK: - Private properties -
    
    private var account: Account
    private var privateTransactions: Observable<[AccountCellModel]>?
    private unowned let view: AccountsViewInterface
    private let interactor: AccountsInteractorInterface
    private let wireframe: AccountsWireframeInterface
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle -
    
    init(view: AccountsViewInterface, interactor: AccountsInteractorInterface, wireframe: AccountsWireframeInterface, account: Account) {
        self.account = account
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension AccountsPresenter: AccountsPresenterInterface {
    var getAccount: Account {
        return account
    }
    
    var transactions: Observable<[AccountCellModel]>? {
        return privateTransactions
    }
    
    func showTransactions() {
        self.privateTransactions = self.interactor.getTransactions(account: account)
    }
}
