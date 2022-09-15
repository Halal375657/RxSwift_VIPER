//
//  AccountWireFrame.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import UIKit
import RxCocoa

final class AccountsWireframe: BaseWireframe<AccountsViewController> {

    // MARK: - Private properties -
    private let storyboard = UIStoryboard(name: "Account", bundle: nil)

    // MARK: - Module setup -
    init(account: Account) {
        let moduleViewController = storyboard.instantiateViewController(ofType: AccountsViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = AccountsInteractor(services: Services())
        let presenter = AccountsPresenter(view: moduleViewController, interactor: interactor, wireframe: self, account: account)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

extension AccountsWireframe: AccountsWireframeInterface {
    func willShow(account: Account) {
        //
    }
    

}
