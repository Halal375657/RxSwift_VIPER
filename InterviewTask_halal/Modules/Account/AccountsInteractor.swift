//
//  AccountInteractor.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import Foundation
import RxSwift

final class AccountsInteractor {
    
    private var privateServices: APIServicesInterfaces!
    private let disposeBag = DisposeBag()
    
}

// MARK: - Extensions -

extension AccountsInteractor: AccountsInteractorInterface {

    var services: APIServicesInterfaces {
        get {
            return privateServices
        }
        set {
            privateServices = newValue
        }
    }

    convenience init(services: APIServicesInterfaces) {
        self.init()
        
        self.services = services
    }
    
    func getTransactions(account: Account) -> Observable<[AccountCellModel]> {
        let apiRequest = APIRequest(urlString: account.transactions ?? "")
        return services.getTransactions(apiRequest: apiRequest)
    }
    
}
