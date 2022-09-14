//
//  HomePresenter.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import RxSwift
import RxCocoa

final class HomePresenter {
    
    // MARK: - Private properties -
    
    private var privateAccounts: BehaviorRelay<[Account]> = BehaviorRelay(value: [])
    private unowned let view: HomeViewInterface
    private let interactor: HomeInteractorInterface
    private let wireframe: HomeWireframeInterface
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle -
    
    init(view: HomeViewInterface, interactor: HomeInteractorInterface, wireframe: HomeWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension HomePresenter: HomePresenterInterface {
    var accounts: BehaviorRelay<[Account]> {
        return privateAccounts
    }
    
    func showAccounts() {
        self.interactor.getAccounts().drive(onNext: { [unowned self] (accounts) in
            self.privateAccounts.accept(accounts.accounts ?? [])
        }).disposed(by: disposeBag)
    }
    
//    func showUserWith(index: Int) {
//        self.interactor.getUserBy(id: index).drive(onNext: { (user) in
//            self.wireframe.willShow(user: user)
//        }).disposed(by: disposeBag)
//    }
}
