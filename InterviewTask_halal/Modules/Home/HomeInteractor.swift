//
//  HomeInteractor.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeInteractor {

    private var privateService: APIServicesInterfaces!
    private let disposeBag = DisposeBag()

}

// MARK: - Extensions -

extension HomeInteractor: HomeInteractorInterface {

    var services: APIServicesInterfaces {
        get {
            return privateService
        }
        set {
            privateService = newValue
        }
    }

    convenience init(services: APIServicesInterfaces) {
        self.init()
        
        self.services = services
    }
    
    func getAccounts() -> Driver<Accounts> {
        return services.getAccounts()
    }

}
