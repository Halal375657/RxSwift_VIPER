//
//  AccountsInterface.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol AccountsWireframeInterface: WireframeInterface {
    func willShow(account: Account)
}

protocol AccountsViewInterface: ViewInterface {
    func showTransactions()
}

protocol AccountsPresenterInterface: PresenterInterface {
    var getAccount: Account { get }
    var transactions: Observable<[AccountCellModel]>?  { get }
    
    func showTransactions()
}

protocol AccountsInteractorInterface: InteractorInterface {
    func getTransactions(account: Account) -> Observable<[AccountCellModel]>
}
