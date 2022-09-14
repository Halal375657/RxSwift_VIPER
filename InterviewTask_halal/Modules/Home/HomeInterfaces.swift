//
//  HomeInterfaces.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeWireframeInterface: WireframeInterface {
    func willShow(account: Account)
}

protocol HomeViewInterface: ViewInterface {
    func showAccounts()
    //func showUser(index: Int)
}

protocol HomePresenterInterface: PresenterInterface {
    var accounts: BehaviorRelay<[Account]> { get }
    
    func showAccounts()
    //func showUserWith(index: Int)
}

protocol HomeInteractorInterface: InteractorInterface {
    func getAccounts() -> Driver<Accounts>
    //func getUserBy(id: Int) -> Driver<Account>
}
