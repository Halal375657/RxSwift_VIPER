//
//  HomeWireFrame.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import UIKit

final class HomeWireframe: BaseWireframe<HomeViewController> {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Home", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: HomeViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = HomeInteractor(services: Services())
        let presenter = HomePresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension HomeWireframe: HomeWireframeInterface {
    func willShow(account: Account) {
        print("tapped the willShow method.")
        navigationController?.pushWireframe(AccountsWireframe(account: account))
    }
}
